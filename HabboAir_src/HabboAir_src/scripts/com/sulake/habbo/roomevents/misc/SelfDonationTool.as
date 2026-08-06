package com.sulake.habbo.roomevents.misc
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.misc.SelfDonateItemMessageComposer;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage.ChestItemType;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.misc.SelfDonationResultMessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.misc.SelfDonationResultMessageParser;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_trading.UbuntuPresetManager;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.iid.IIDHabboCommunicationManager;
   
   public class SelfDonationTool extends Component implements ILinkEventTracker, ISelfDonationTool
   {
      private static const ALLOWED_ENVIRONMENT_IDS:Array = ["s1","s2","d63","dev","local"];
      
      private var _communication:IHabboCommunicationManager;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var UnknownVarFromSelfDonationTool_PresetManager_1:PresetManager;
      
      private var UnknownVarFromSelfDonationTool_SelfDonationToolView_1:SelfDonationToolView;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var _disposed:Boolean = false;
      
      public function SelfDonationTool(param1:HabboUserDefinedRoomEvents, param2:IComponent_2, param3:uint = 0, param4:IAssetLibraryCollection = null)
      {
         super(param2,param3,param4);
         _roomEvents = param1;
         UnknownVarFromSelfDonationTool_PresetManager_1 = new UbuntuPresetManager(param1);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communication = param1;
         },true)]);
      }
      
      override protected function initComponent() : void
      {
         context.addLinkEventTracker(this);
         _messageEvents = new Vector.<IMessageEvent>();
         _messageEvents.push(new SelfDonationResultMessageEvent(onSelfDonationResult));
         for each(var _loc1_ in _messageEvents)
         {
            addMessageEvent(_loc1_);
         }
      }
      
      public function get linkPattern() : String
      {
         return "selfdonation/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         if(_loc2_[1] == "open")
         {
            open();
         }
      }
      
      public function open() : void
      {
         if(_disposed)
         {
            return;
         }
         ensureView();
         UnknownVarFromSelfDonationTool_SelfDonationToolView_1.showTool();
      }
      
      internal function onDonate(param1:ChestItemType, param2:int) : void
      {
         if(!isSandboxEnvironment)
         {
            _roomEvents.windowManager.alert("${error.title}",sandboxWarningText,0,null);
            return;
         }
         var _loc3_:String = validate(param1,param2);
         if(_loc3_ != null)
         {
            _roomEvents.windowManager.alert("${wiredfurni.error.title}",_loc3_,0,null);
            return;
         }
         if(_communication == null || _communication.connection == null)
         {
            _roomEvents.windowManager.alert("${wiredfurni.error.title}",localization.getLocalization("selfdonation.no_connection","Connection is not ready yet."),0,null);
            return;
         }
         _communication.connection.send(new SelfDonateItemMessageComposer(param1.isWallItem,param1.typeId,param1.legacyPosterId,param2));
      }
      
      private function onSelfDonationResult(param1:SelfDonationResultMessageEvent) : void
      {
         var _loc3_:String = null;
         var _loc6_:String = null;
         var _loc2_:SelfDonationResultMessageParser = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         switch(_loc2_.resultCode)
         {
            case 0:
               _loc3_ = "selfdonation.result.success";
               _loc6_ = "selfdonation.success";
               break;
            case 1:
               _loc3_ = "selfdonation.result.not_allowed";
               _loc6_ = "selfdonation.fail";
               break;
            default:
               _loc3_ = "selfdonation.result.failed";
               _loc6_ = "selfdonation.fail";
         }
         var _loc4_:String = localization.getLocalization(_loc6_,_loc6_);
         var _loc5_:String = localization.getLocalization(_loc3_,_loc3_);
         _roomEvents.windowManager.alert(_loc4_,_loc5_,0,null);
      }
      
      private function validate(param1:ChestItemType, param2:int) : String
      {
         if(!isSandboxEnvironment)
         {
            return sandboxWarningText;
         }
         if(param1 == null)
         {
            return localization.getLocalization("selfdonation.select_item","Select a furniture item first.");
         }
         if(param2 < 1 || param2 > 500)
         {
            return localization.getLocalizationWithParams("selfdonation.invalid_amount","Please enter an amount between 1 and %max%.","max",500);
         }
         var _loc3_:IFurnitureData = getFurnitureData(param1);
         if(_loc3_ == null)
         {
            return localization.getLocalization("selfdonation.invalid_item","This item cannot be donated from the sandbox tool.");
         }
         return null;
      }
      
      private function getFurnitureData(param1:ChestItemType) : IFurnitureData
      {
         if(_roomEvents == null || _roomEvents.sessionDataManager == null || param1 == null)
         {
            return null;
         }
         if(param1.isWallItem)
         {
            return _roomEvents.sessionDataManager.getWallItemData(param1.typeId);
         }
         return _roomEvents.sessionDataManager.getFloorItemData(param1.typeId);
      }
      
      private function ensureView() : void
      {
         if(UnknownVarFromSelfDonationTool_SelfDonationToolView_1 == null)
         {
            UnknownVarFromSelfDonationTool_SelfDonationToolView_1 = new SelfDonationToolView(this,UnknownVarFromSelfDonationTool_PresetManager_1);
         }
      }
      
      private function get sandboxWarningText() : String
      {
         return localization.getLocalization("selfdonation.sandbox_only","Self donation only works in the sandbox environment.");
      }
      
      public function get roomEvents() : HabboUserDefinedRoomEvents
      {
         return _roomEvents;
      }
      
      private function get localization() : IHabboLocalizationManager
      {
         return _roomEvents.localization;
      }
      
      public function get isSandboxEnvironment() : Boolean
      {
         var _loc1_:String = getProperty("environment.id");
         return ALLOWED_ENVIRONMENT_IDS.indexOf(_loc1_) != -1;
      }
      
      override public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         for each(var _loc1_ in _messageEvents)
         {
            removeMessageEvent(_loc1_);
         }
         _messageEvents = null;
         if(UnknownVarFromSelfDonationTool_SelfDonationToolView_1 != null)
         {
            UnknownVarFromSelfDonationTool_SelfDonationToolView_1.dispose();
            UnknownVarFromSelfDonationTool_SelfDonationToolView_1 = null;
         }
         UnknownVarFromSelfDonationTool_PresetManager_1 = null;
         _roomEvents = null;
         _communication = null;
         super.dispose();
      }
      
      override public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function addMessageEvent(param1:IMessageEvent) : void
      {
         if(_communication != null)
         {
            _communication.addHabboConnectionMessageEvent(param1);
         }
      }
      
      private function removeMessageEvent(param1:IMessageEvent) : void
      {
         if(_communication != null)
         {
            _communication.removeHabboConnectionMessageEvent(param1);
         }
      }
   }
}

