package com.sulake.habbo.catalog.special_items_display
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.special_items_display.model.FurniSpecialItem;
   import com.sulake.habbo.catalog.special_items_display.model.IAbstractSpecialItem;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.peerservice.HasClaimedProductResponseMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.peerservice.ClaimProductMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.peerservice.HasClaimedProductMessageComposer;
   import com.sulake.habbo.communication.messages.parser.peerservice.HasClaimedProductResponseParser;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   
   public class SpecialItemsController extends Component implements ILinkEventTracker, ISpecialItemsDisplay
   {
      public static const ITEM_TYPE_FURNI:String = "furni";
      
      public static const CLAIM_STATE_NOT_APPLICABLE:int = 0;
      
      public static const CLAIM_STATE_FETCHING:int = 1;
      
      public static const CLAIM_STATE_BROWSING:int = 2;
      
      public static const CLAIM_STATE_CLAIMABLE:int = 3;
      
      public static const CLAIM_STATE_CLAIMED:int = 4;
      
      private var _catalog:HabboCatalog;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _roomEngine:IRoomEngine;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var _key:String;
      
      private var _items:Vector.<IAbstractSpecialItem>;
      
      private var _freeClaim:String;
      
      private var _claimState:int;
      
      private var _view:SpecialItemsView;
      
      public function SpecialItemsController(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },false),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1 as HabboCatalog;
         }),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communication = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         context.addLinkEventTracker(this);
         _messageEvents = new Vector.<IMessageEvent>();
         _messageEvents.push(new HasClaimedProductResponseMessageEvent(onHasClaimedProductResponse));
         for each(var _loc1_ in _messageEvents)
         {
            addMessageEvent(_loc1_);
         }
      }
      
      private function onHasClaimedProductResponse(param1:HasClaimedProductResponseMessageEvent) : void
      {
         var _loc2_:HasClaimedProductResponseParser = param1.getParser();
         if(_loc2_.claimId == _freeClaim && _claimState == 1)
         {
            _claimState = _loc2_.hasClaimed ? 4 : 2;
            if(_view != null && _view.isShowing())
            {
               _view.updateClaimState();
            }
         }
      }
      
      public function makeClaimable() : void
      {
         if(_freeClaim == null || _freeClaim.length == 0)
         {
            return;
         }
         if(_claimState != 2)
         {
            return;
         }
         _claimState = 3;
         if(_view != null && _view.isShowing())
         {
            _view.updateClaimState();
         }
      }
      
      public function makeClaim() : void
      {
         if(_freeClaim == null || _freeClaim.length == 0)
         {
            return;
         }
         if(_claimState != 3 && _claimState != 2)
         {
            return;
         }
         _communication.connection.send(new ClaimProductMessageComposer(_freeClaim));
         _claimState = 4;
         if(_view != null && _view.isShowing())
         {
            _view.updateClaimState();
         }
      }
      
      public function get linkPattern() : String
      {
         return "special_items_display/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         _key = _loc2_[1];
         initialize();
      }
      
      public function initialize() : void
      {
         if(parseSpecialItems())
         {
            if(_freeClaim != null && _freeClaim.length > 0)
            {
               _claimState = 1;
               _communication.connection.send(new HasClaimedProductMessageComposer(_freeClaim));
            }
            else
            {
               _claimState = 0;
            }
            openView();
         }
      }
      
      private function parseSpecialItems() : Boolean
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         var _loc9_:String = null;
         var _loc4_:String = null;
         var _loc5_:IAbstractSpecialItem = null;
         var _loc7_:Vector.<IAbstractSpecialItem> = new Vector.<IAbstractSpecialItem>();
         var _loc8_:String = getProperty("special_items." + _key + ".items");
         var _loc6_:int = 0;
         var _loc10_:Array = _loc8_.split(";");
         for each(var _loc1_ in _loc10_)
         {
            _loc2_ = _loc1_.split(",",3);
            _loc3_ = _loc2_[0];
            _loc9_ = _loc2_[1];
            _loc4_ = _loc2_[2];
            _loc5_ = null;
            var _loc11_:* = _loc9_;
            if("furni" === _loc11_)
            {
               _loc5_ = new FurniSpecialItem(_loc6_,_key,_loc3_,this,_loc4_);
            }
            if(_loc5_ != null && _loc5_.isValid)
            {
               _loc7_.push(_loc5_);
               _loc6_ += 1;
            }
         }
         _items = _loc7_;
         _freeClaim = getProperty("special_items." + _key + ".free_claim");
         return _loc7_.length > 0;
      }
      
      private function openView() : void
      {
         if(_view == null)
         {
            _view = new SpecialItemsView(this,_windowManager);
         }
         _view.displayNewData();
         if(!_view.isShowing())
         {
            _view.show();
         }
      }
      
      public function addMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communication)
         {
            return;
         }
         _communication.addHabboConnectionMessageEvent(param1);
      }
      
      public function removeMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communication)
         {
            return;
         }
         _communication.removeHabboConnectionMessageEvent(param1);
      }
      
      public function get catalog() : HabboCatalog
      {
         return _catalog;
      }
      
      public function get localizationManager() : IHabboLocalizationManager
      {
         return _localizationManager;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      public function get key() : String
      {
         return _key;
      }
      
      public function get items() : Vector.<IAbstractSpecialItem>
      {
         return _items;
      }
      
      public function get claimState() : int
      {
         return _claimState;
      }
      
      public function get view() : SpecialItemsView
      {
         return _view;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(_view)
         {
            _view.dispose();
            _view = null;
         }
         for each(var _loc1_ in _messageEvents)
         {
            removeMessageEvent(_loc1_);
         }
         _catalog = null;
         _sessionDataManager = null;
         _communication = null;
         _windowManager = null;
         _localizationManager = null;
         _roomEngine = null;
         super.dispose();
      }
   }
}

