package com.sulake.habbo.notifications
{
   import adobe.serialization.json.JSONDecoder;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.catalog.event.CatalogEvent;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.outgoing.users.GetMOTDMessageComposer;
   import com.sulake.habbo.freeflowchat.IHabboFreeFlowChat;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.inventory.IHabboInventory;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.notifications.feed.NotificationController;
   import com.sulake.habbo.notifications.singular.SingularNotificationController;
   import com.sulake.habbo.notifications.utils.PetImageUtility;
   import com.sulake.habbo.notifications.utils.ProductImageUtility;
   import com.sulake.habbo.quest.rewardtrack.IRewardTrackController;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboFreeFlowChat;
   import com.sulake.iid.IIDHabboFriendList;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboInventory;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRewardTrackController;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.display.BitmapData;
   
   public class HabboNotifications extends Component implements IHabboNotifications
   {
      private var _communication:IHabboCommunicationManager;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _inventory:IHabboInventory;
      
      private var _friendList:IHabboFriendList;
      
      private var _roomEngine:IRoomEngine;
      
      private var _catalog:IHabboCatalog;
      
      private var _toolBar:IHabboToolbar;
      
      private var UnknownVarFromHabboNotifications_ProductImageUtility_1:ProductImageUtility;
      
      private var UnknownVarFromHabboNotifications_PetImageUtility_1:PetImageUtility;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var _habboHelp:IHabboHelp;
      
      private var _freeFlowChat:IHabboFreeFlowChat;
      
      private var _avatarRenderManager:IAvatarRenderManager;
      
      private var _rewardTrack:IRewardTrackController;
      
      private var _feedController:NotificationController;
      
      private var _singularController:SingularNotificationController;
      
      private var UnknownVarFromHabboNotifications_IncomingMessages_1:IncomingMessages;
      
      private var _disabled:Boolean;
      
      public function HabboNotifications(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
         _disabled = false;
      }
      
      public function get assetLibrary() : IAssetLibraryCollection
      {
         return assets;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localization;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get roomSessionManager() : IRoomSessionManager
      {
         return _roomSessionManager;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function get toolBar() : IHabboToolbar
      {
         return _toolBar;
      }
      
      public function get habboHelp() : IHabboHelp
      {
         return _habboHelp;
      }
      
      public function get freeFlowChat() : IHabboFreeFlowChat
      {
         return _freeFlowChat;
      }
      
      public function get rewardTrack() : IRewardTrackController
      {
         return _rewardTrack;
      }
      
      public function get singularController() : SingularNotificationController
      {
         return _singularController;
      }
      
      public function get feedController() : NotificationController
      {
         return _feedController;
      }
      
      public function get disabled() : Boolean
      {
         return _disabled;
      }
      
      public function set disabled(param1:Boolean) : void
      {
         _disabled = param1;
      }
      
      public function get productImageUtility() : ProductImageUtility
      {
         if(_roomEngine == null || _inventory == null)
         {
            return null;
         }
         if(UnknownVarFromHabboNotifications_ProductImageUtility_1 == null)
         {
            UnknownVarFromHabboNotifications_ProductImageUtility_1 = new ProductImageUtility(_roomEngine,_inventory);
         }
         return UnknownVarFromHabboNotifications_ProductImageUtility_1;
      }
      
      public function get petImageUtility() : PetImageUtility
      {
         if(_roomEngine == null)
         {
            return null;
         }
         if(UnknownVarFromHabboNotifications_PetImageUtility_1 == null)
         {
            UnknownVarFromHabboNotifications_PetImageUtility_1 = new PetImageUtility(_roomEngine);
         }
         return UnknownVarFromHabboNotifications_PetImageUtility_1;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboInventory(),function(param1:IHabboInventory):void
         {
            _inventory = param1;
         },false),new ComponentDependency(new IIDHabboFriendList(),function(param1:IHabboFriendList):void
         {
            _friendList = param1;
         },false),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },false),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         },false,[{
            "type":"CATALOG_BUILDER_MEMBERSHIP_EXPIRED",
            "callback":onBuilderMembershipExpired
         },{
            "type":"CATALOG_BUILDER_MEMBERSHIP_IN_GRACE",
            "callback":onBuilderMembershipInGrace
         },{
            "type":"COLLECTIBLES_CLAIM_FAIL",
            "callback":onCollectiblesClaimFail
         },{
            "type":"COLLECTIBLE_CLAIM_SUCCESS",
            "callback":onCollectiblesClaimSuccess
         },{
            "type":"COLLECTIBLE_CLAIM_WAIT",
            "callback":onCollectiblesClaimWait
         },{
            "type":"COLLECTIBLES_MINT_FAIL",
            "callback":onCollectiblesMintFail
         },{
            "type":"COLLECTIBLES_MINT_SUCCESS",
            "callback":onCollectiblesMintSuccess
         }]),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolBar = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboRoomSessionManager(),function(param1:IRoomSessionManager):void
         {
            _roomSessionManager = param1;
         },false),new ComponentDependency(new IIDHabboHelp(),function(param1:IHabboHelp):void
         {
            _habboHelp = param1;
         }),new ComponentDependency(new IIDHabboFreeFlowChat(),function(param1:IHabboFreeFlowChat):void
         {
            _freeFlowChat = param1;
         },false),new ComponentDependency(new IIDRewardTrackController(),function(param1:IRewardTrackController):void
         {
            _rewardTrack = param1;
         },false),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:IAvatarRenderManager):void
         {
            _avatarRenderManager = param1;
         },false)]);
      }
      
      override protected function initComponent() : void
      {
         _singularController = new SingularNotificationController(this);
         UnknownVarFromHabboNotifications_IncomingMessages_1 = new IncomingMessages(this,_communication);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(UnknownVarFromHabboNotifications_IncomingMessages_1 != null)
         {
            UnknownVarFromHabboNotifications_IncomingMessages_1.dispose();
            UnknownVarFromHabboNotifications_IncomingMessages_1 = null;
         }
         if(_feedController != null)
         {
            _feedController.dispose();
            _feedController = null;
         }
         if(UnknownVarFromHabboNotifications_PetImageUtility_1 != null)
         {
            UnknownVarFromHabboNotifications_PetImageUtility_1.dispose();
            UnknownVarFromHabboNotifications_PetImageUtility_1 = null;
         }
         if(UnknownVarFromHabboNotifications_ProductImageUtility_1 != null)
         {
            UnknownVarFromHabboNotifications_ProductImageUtility_1.dispose();
            UnknownVarFromHabboNotifications_ProductImageUtility_1 = null;
         }
         super.dispose();
      }
      
      public function activate() : void
      {
         if(_feedController != null)
         {
            _feedController.setFeedEnabled(true);
         }
         _communication.connection.send(new GetMOTDMessageComposer());
      }
      
      public function get communication() : IHabboCommunicationManager
      {
         return _communication;
      }
      
      public function addSongPlayingNotification(param1:String, param2:String) : void
      {
         _singularController.addSongPlayingNotification(param1,param2);
      }
      
      public function addItem(param1:String, param2:String, param3:String = null, param4:String = null, param5:Object = null) : void
      {
         var _loc6_:BitmapData = null;
         if(param3 != null)
         {
            _loc6_ = (assets.getAssetByName(param3).content as BitmapData).clone();
         }
         addItemWithBitmap(param1,param2,_loc6_,param4,param5);
      }
      
      public function addItemWithBitmap(param1:String, param2:String, param3:BitmapData = null, param4:String = null, param5:Object = null) : void
      {
         _singularController.addItem(param1,param2,param3,null,null,param4,param5);
      }
      
      public function removeNotificationById(param1:String) : void
      {
         if(_singularController == null || param1 == null)
         {
            return;
         }
         _singularController.removeNotificationById(param1);
      }
      
      public function showNotification(param1:String, param2:Map = null) : void
      {
         var _loc7_:Object = null;
         var _loc9_:String = null;
         var _loc5_:String = null;
         var _loc3_:Boolean = false;
         var _loc11_:String = null;
         var _loc6_:BitmapData = null;
         var _loc10_:ISoundAsset = null;
         if(param2 == null)
         {
            param2 = new Map();
         }
         var _loc4_:String = "notification." + param1;
         if(propertyExists(_loc4_))
         {
            _loc7_ = new JSONDecoder(getProperty(_loc4_),true).getValue();
            for(var _loc8_ in _loc7_)
            {
               param2[_loc8_] = _loc7_[_loc8_];
            }
         }
         if(param2["display"] == "BUBBLE")
         {
            _loc9_ = getNotificationPart(param2,param1,"message",true);
            _loc5_ = getNotificationPart(param2,param1,"linkUrl",false);
            _loc3_ = _loc5_ != null && _loc5_.substr(0,6) == "event:";
            _loc11_ = getNotificationImageUrl(param2,param1);
            _loc6_ = null;
            if(_loc11_ != null && _loc11_.indexOf("${image.library.url}") == -1)
            {
               _loc10_ = assets.getAssetByName(_loc11_);
               if(_loc10_ != null)
               {
                  _loc6_ = (assets.getAssetByName(_loc11_).content as BitmapData).clone();
                  if(_loc6_ != null)
                  {
                     _loc11_ = null;
                  }
               }
            }
            _singularController.addItem(_loc9_,"info",_loc6_,_loc11_,null,_loc3_ ? _loc5_.substr(6) : _loc5_);
         }
         else
         {
            new NotificationPopup(this,param1,param2);
         }
      }
      
      public function getNotificationPart(param1:Map, param2:String, param3:String, param4:Boolean) : String
      {
         var _loc5_:String = null;
         if(param1.hasKey(param3))
         {
            return param1.getValue(param3);
         }
         _loc5_ = ["notification",param2,param3].join(".");
         if(localization.hasLocalization(_loc5_) || param4)
         {
            return localization.getLocalizationWithParamMap(_loc5_,_loc5_,param1);
         }
         return null;
      }
      
      public function getNotificationImageUrl(param1:Map, param2:String) : String
      {
         var _loc3_:String = param1.getValue("image");
         if(_loc3_ == null)
         {
            _loc3_ = "${image.library.url}notifications/" + param2.replace(/\./g,"_") + ".png";
         }
         return _loc3_;
      }
      
      private function onBuilderMembershipInGrace(param1:CatalogEvent) : void
      {
         showNotification("builders_club.membership_in_grace",null);
      }
      
      private function onBuilderMembershipExpired(param1:CatalogEvent) : void
      {
         showNotification("builders_club.membership_expired",null);
      }
      
      private function onCollectiblesClaimFail(param1:CatalogEvent) : void
      {
         addItem(localization.getLocalization("collectibles.claiming.failed"),"info","icon_curator_stamp_large_png");
      }
      
      private function onCollectiblesClaimSuccess(param1:CatalogEvent) : void
      {
         addItem(localization.getLocalization("collectibles.claiming.success"),"info","icon_curator_stamp_large_png");
      }
      
      private function onCollectiblesClaimWait(param1:CatalogEvent) : void
      {
         addItem(localization.getLocalization("collectibles.claiming.wait"),"info","icon_curator_stamp_large_png");
      }
      
      private function onCollectiblesMintFail(param1:CatalogEvent) : void
      {
         addItem(localization.getLocalization("shop.minting.failed"),"info","icon_curator_stamp_large_png");
      }
      
      private function onCollectiblesMintSuccess(param1:CatalogEvent) : void
      {
         addItem(localization.getLocalization("shop.minting.success"),"info","icon_curator_stamp_large_png");
      }
      
      public function createLinkEvent(param1:String) : void
      {
         context.createLinkEvent(param1);
      }
      
      public function get avatarRenderManager() : IAvatarRenderManager
      {
         return _avatarRenderManager;
      }
   }
}

