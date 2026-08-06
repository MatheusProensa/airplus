package com.sulake.habbo.roomevents
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.WiredClickUserMessageComposer;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.notifications.IHabboNotifications;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IRoomEngine_2;
   import com.sulake.habbo.room.ISelectedRoomObjectData;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.roomevents.misc.SelfDonationTool;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   import com.sulake.habbo.roomevents.wired_setup.IUserDefinedRoomEventsCtrl;
   import com.sulake.habbo.roomevents.wired_setup.UserDefinedRoomEventsCtrl;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.NewVariablePickerHelper;
   import com.sulake.habbo.roomevents.wired_trading.chests.WiredChestController;
   import com.sulake.habbo.roomevents.wired_trading.contracts.WiredContractController;
   import com.sulake.habbo.roomevents.wired_trading.reward_notification.RewardNotificationController;
   import com.sulake.habbo.roomevents.wired_trading.transactions.details.WiredTransactionDetailsController;
   import com.sulake.habbo.roomevents.wired_trading.transactions.overview.WiredTransactionLogsController;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.ui.IRoomDesktop;
   import com.sulake.habbo.ui.IRoomUI;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNotifications;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboRoomUI;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRewardNotificationController;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSelfDonationTool;
   import com.sulake.iid.IIDSessionDataManager;
   import com.sulake.iid.IIDTransactionDetailsController;
   import com.sulake.iid.IIDTransactionLogsController;
   import com.sulake.iid.IIDWiredChestController;
   import com.sulake.iid.IIDWiredMenuController;
   import flash.display.BitmapData;
   
   public class HabboUserDefinedRoomEvents extends Component implements IHabboUserDefinedRoomEvents
   {
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _communication:IHabboCommunicationManager;
      
      private var _toolbar:IHabboToolbar;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _notifications:IHabboNotifications;
      
      private var _wiredCtrl:IUserDefinedRoomEventsCtrl;
      
      private var _incomingMessages:IncomingMessages;
      
      private var _roomEngine:IRoomEngine;
      
      private var _roomSession:IRoomSession;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _userName:String;
      
      private var _wiredMenu:WiredMenuController;
      
      private var _wiredChest:WiredChestController;
      
      private var _transactionLogs:WiredTransactionLogsController;
      
      private var _transactionDetails:WiredTransactionDetailsController;
      
      private var UnknownVarFromHabboUserDefinedRoomEvents_WiredContractController_1:WiredContractController;
      
      private var _rewardNotificationController:RewardNotificationController;
      
      private var _selfDonationTool:SelfDonationTool;
      
      private var _roomUI:IRoomUI;
      
      private var _variablesSynchronizer:WiredVariablesSynchronizer;
      
      private var UnknownVarFromHabboUserDefinedRoomEvents_WiredEnvironment_1:WiredEnvironment;
      
      private var _variablePickerHelper:NewVariablePickerHelper;
      
      public function HabboUserDefinedRoomEvents(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
         _wiredCtrl = new UserDefinedRoomEventsCtrl(this);
         _variablesSynchronizer = new WiredVariablesSynchronizer(this);
         UnknownVarFromHabboUserDefinedRoomEvents_WiredEnvironment_1 = new WiredEnvironment(this);
         _wiredMenu = new WiredMenuController(this,param1,0,param3);
         _wiredChest = new WiredChestController(this,param1,0,param3);
         _transactionLogs = new WiredTransactionLogsController(this,param1,0,param3);
         _transactionDetails = new WiredTransactionDetailsController(this,param1,0,param3);
         _variablePickerHelper = new NewVariablePickerHelper(this);
         UnknownVarFromHabboUserDefinedRoomEvents_WiredContractController_1 = new WiredContractController(this);
         _rewardNotificationController = new RewardNotificationController(this,param1,0,param3);
         _selfDonationTool = new SelfDonationTool(this,param1,0,param3);
         param1.attachComponent(_wiredMenu,[new IIDWiredMenuController()]);
         param1.attachComponent(_wiredChest,[new IIDWiredChestController()]);
         param1.attachComponent(_transactionLogs,[new IIDTransactionLogsController()]);
         param1.attachComponent(_transactionDetails,[new IIDTransactionDetailsController()]);
         param1.attachComponent(_rewardNotificationController,[new IIDRewardNotificationController()]);
         param1.attachComponent(_selfDonationTool,[new IIDSelfDonationTool()]);
      }
      
      public function get communication() : IHabboCommunicationManager
      {
         return _communication;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localization;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboNotifications(),function(param1:IHabboNotifications):void
         {
            _notifications = param1;
         }),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },true,[{
            "type":"REOE_ADDED",
            "callback":roomObjectAddedHandler
         }]),new ComponentDependency(new IIDHabboRoomSessionManager(),null,false,[{
            "type":"RSE_CREATED",
            "callback":roomSessionStateEventHandler
         },{
            "type":"RSE_STARTED",
            "callback":roomSessionStateEventHandler
         },{
            "type":"RSE_ENDED",
            "callback":roomSessionStateEventHandler
         }]),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboRoomUI(),function(param1:IRoomUI):void
         {
            _roomUI = param1;
         },false),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         },false,[{
            "type":"HTE_TOOLBAR_CLICK",
            "callback":onHabboToolbarEvent
         }])]);
      }
      
      private function roomObjectAddedHandler(param1:RoomEngineObjectEvent) : void
      {
         var _loc2_:int = param1.objectId;
         var _loc3_:int = param1.category;
         switch(_loc3_ - 10)
         {
            case 0:
               _wiredCtrl.stuffAdded(_loc2_);
               break;
            case 10:
               _wiredCtrl.stuffAdded(-_loc2_);
         }
      }
      
      override protected function initComponent() : void
      {
         _incomingMessages = new IncomingMessages(this);
         _roomEngine.events.addEventListener("REE_DISPOSED",onRoomEngineEvent);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(_incomingMessages != null)
         {
            _incomingMessages.dispose();
            _incomingMessages = null;
         }
         if(_variablesSynchronizer != null)
         {
            _variablesSynchronizer.dispose();
            _variablesSynchronizer = null;
         }
         if(UnknownVarFromHabboUserDefinedRoomEvents_WiredEnvironment_1 != null)
         {
            UnknownVarFromHabboUserDefinedRoomEvents_WiredEnvironment_1.dispose();
            UnknownVarFromHabboUserDefinedRoomEvents_WiredEnvironment_1 = null;
         }
         _wiredMenu.dispose();
         _wiredChest.dispose();
         _transactionLogs.dispose();
         _transactionDetails.dispose();
         UnknownVarFromHabboUserDefinedRoomEvents_WiredContractController_1.dispose();
         _rewardNotificationController.dispose();
         _selfDonationTool.dispose();
         _wiredMenu = null;
         _wiredChest = null;
         _transactionLogs = null;
         _transactionDetails = null;
         UnknownVarFromHabboUserDefinedRoomEvents_WiredContractController_1 = null;
         _rewardNotificationController = null;
         _selfDonationTool = null;
         super.dispose();
      }
      
      public function stuffSelected(param1:int) : void
      {
         var _loc2_:ISelectedRoomObjectData = (_roomEngine as IRoomEngine_2).getPlacedObjectData(roomId);
         if(_loc2_ && _loc2_.id == -param1)
         {
            (_roomEngine as IRoomEngine_2).setPlacedObjectData(roomId,null);
            return;
         }
         _wiredCtrl.stuffSelected(param1);
         _wiredMenu.furniSelected(param1);
      }
      
      public function userSelected(param1:int) : void
      {
         if(hasClickUserWired())
         {
            send(new WiredClickUserMessageComposer(param1));
         }
         _wiredMenu.userSelected(param1);
      }
      
      public function showInspectButton() : Boolean
      {
         return _wiredMenu.isEnabled && _wiredMenu.hasReadPermission && wiredMenu.wiredInspectButton;
      }
      
      public function showToolbarMenuButton() : Boolean
      {
         return _wiredMenu.isEnabled && _wiredMenu.hasReadPermission && wiredMenu.wiredMenuButton;
      }
      
      public function get wiredWhisperDisabled() : Boolean
      {
         return _wiredMenu.wiredWhisperDisabled;
      }
      
      public function set wiredWhisperDisabled(param1:Boolean) : void
      {
         _wiredMenu.wiredWhisperDisabled = param1;
      }
      
      private function onHabboToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.type != "HTE_TOOLBAR_CLICK")
         {
            return;
         }
         if(param1.iconId == "HTIE_ICON_WIRED_MENU")
         {
            _wiredMenu.toggleView();
         }
      }
      
      public function send(param1:IMessageComposer) : void
      {
         _communication.connection.send(param1);
      }
      
      public function getXmlWindow(param1:String) : IWindowModel
      {
         var _loc4_:ISoundAsset = null;
         var _loc2_:XmlAsset = null;
         var _loc3_:IWindowModel = null;
         try
         {
            _loc4_ = assets.getAssetByName(param1 + "_xml");
            _loc2_ = XmlAsset(_loc4_);
            _loc3_ = _windowManager.buildFromXML(XML(_loc2_.content));
         }
         catch(e:Error)
         {
         }
         return _loc3_;
      }
      
      public function refreshButton(param1:IWindowController_1, param2:String, param3:Boolean, param4:Function, param5:int, param6:String = null) : void
      {
         if(!param6)
         {
            param6 = param2;
         }
         var _loc7_:IBitmapWrapperController = param1.findChildByName(param2) as IBitmapWrapperController;
         if(!param3)
         {
            _loc7_.visible = false;
         }
         else
         {
            prepareButton(_loc7_,param6,param4,param5);
            _loc7_.visible = true;
         }
      }
      
      private function prepareButton(param1:IBitmapWrapperController, param2:String, param3:Function, param4:int) : void
      {
         param1.id = param4;
         param1.procedure = param3;
         if(param1.bitmap != null)
         {
            return;
         }
         param1.bitmap = getButtonImage(param2);
         param1.width = param1.bitmap.width;
         param1.height = param1.bitmap.height;
      }
      
      public function getButtonImage(param1:String, param2:String = "_png") : BitmapData
      {
         var _loc4_:String = param1 + param2;
         var _loc6_:ISoundAsset = assets.getAssetByName(_loc4_);
         var _loc5_:BitmapDataAsset = BitmapDataAsset(_loc6_);
         var _loc3_:BitmapData = BitmapData(_loc5_.content);
         return _loc3_.clone();
      }
      
      public function get wiredCtrl() : IUserDefinedRoomEventsCtrl
      {
         return _wiredCtrl;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      private function roomSessionStateEventHandler(param1:RoomSessionEvent) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "RSE_CREATED":
               _roomSession = param1.session;
               break;
            case "RSE_STARTED":
               _roomSession = param1.session;
               break;
            case "RSE_ENDED":
               _roomSession = param1.session;
               UnknownVarFromHabboUserDefinedRoomEvents_WiredEnvironment_1.leaveRoom();
         }
      }
      
      public function get roomId() : int
      {
         return !!_roomSession ? _roomSession.roomId : 0;
      }
      
      public function get roomSession() : IRoomSession
      {
         return _roomSession;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function set userName(param1:String) : void
      {
         _userName = param1;
      }
      
      public function get wiredMenu() : WiredMenuController
      {
         return _wiredMenu;
      }
      
      public function get wiredChest() : WiredChestController
      {
         return _wiredChest;
      }
      
      public function get transactionLogs() : WiredTransactionLogsController
      {
         return _transactionLogs;
      }
      
      public function get rewardNotificationController() : RewardNotificationController
      {
         return _rewardNotificationController;
      }
      
      public function get selfDonationTool() : SelfDonationTool
      {
         return _selfDonationTool;
      }
      
      public function get transactionDetails() : WiredTransactionDetailsController
      {
         return _transactionDetails;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      private function onRoomEngineEvent(param1:RoomEngineEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.type == "REE_DISPOSED")
         {
            _variablesSynchronizer.clear();
            UnknownVarFromHabboUserDefinedRoomEvents_WiredEnvironment_1.clear();
            _wiredCtrl.close();
            UnknownVarFromHabboUserDefinedRoomEvents_WiredContractController_1.clear();
         }
      }
      
      public function get roomUI() : IRoomUI
      {
         return _roomUI;
      }
      
      public function get roomDesktop() : IRoomDesktop
      {
         return _roomUI.desktop;
      }
      
      public function get notifications() : IHabboNotifications
      {
         return _notifications;
      }
      
      public function get variablesSynchronizer() : WiredVariablesSynchronizer
      {
         return _variablesSynchronizer;
      }
      
      public function hasClickUserWired() : Boolean
      {
         if(_roomEngine.windowManager.LilithCustomsInstance.IsWCUBlockEnabled == true)
         {
            return false;
         }
         return UnknownVarFromHabboUserDefinedRoomEvents_WiredEnvironment_1.hasClickUserWired;
      }
      
      public function get achievementsInRoom() : Vector.<String>
      {
         return UnknownVarFromHabboUserDefinedRoomEvents_WiredEnvironment_1?.achievements;
      }
      
      public function switchPlayTestMode() : void
      {
         _wiredMenu.setPlayTestMode(!_wiredMenu.playTestMode,true,true);
      }
      
      public function resetCache() : void
      {
         _wiredCtrl.clearCache();
      }
      
      public function hasWiredUIOpen() : Boolean
      {
         return _wiredCtrl.hasUIOpen() || _wiredMenu.hasUIOpen();
      }
      
      public function get isGameMode() : Boolean
      {
         return UnknownVarFromHabboUserDefinedRoomEvents_WiredEnvironment_1.clickUserOption == 1;
      }
      
      public function get variablePickerHelper() : NewVariablePickerHelper
      {
         return _variablePickerHelper;
      }
   }
}

