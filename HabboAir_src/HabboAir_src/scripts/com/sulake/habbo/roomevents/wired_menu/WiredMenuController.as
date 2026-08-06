package com.sulake.habbo.roomevents.wired_menu
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.preferences.AccountPreferencesEvent;
   import com.sulake.habbo.communication.messages.incoming.room.permissions.YouAreControllerMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredPermissionsEvent;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredSetPreferencesMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.roomlogs.WiredGetRoomLogsComposer;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.WiredPermissionsMessageParser;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.WiredVariablesSynchronizer;
   import com.sulake.habbo.roomevents.events.WiredMenuEvent;
   import com.sulake.habbo.roomevents.wired_menu.roomlogs.WiredRoomLogListController;
   import com.sulake.habbo.roomevents.wired_menu.roomlogs.WiredRoomLogsConfig;
   import com.sulake.habbo.roomevents.wired_menu.tabs.WiredMenuTabConfigs;
   import com.sulake.habbo.roomevents.wired_menu.tabs.tab_inspection.WiredMenuInspectionTab;
   import com.sulake.habbo.roomevents.wired_menu.tabs.tab_settings.WiredMenuSettingsTab;
   import com.sulake.habbo.roomevents.wired_menu.tabs.tab_variable_overview.WiredMenuOverviewTab;
   import com.sulake.habbo.roomevents.wired_menu.variables_management.detail.VariableManagementDetailController;
   import com.sulake.habbo.roomevents.wired_menu.variables_management.overview.VariableManagementOverviewController;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   
   public class WiredMenuController extends Component implements ILinkEventTracker, UnknownIHabboRoomeventsWired_Menu1, IComponentInterfaceQueue
   {
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _avatarRenderManager:IAvatarRenderManager;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _roomEngine:IRoomEngine;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var _view:WiredMenuView;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var UnknownVarFromWiredMenuController_Boolean_1:Boolean;
      
      private var UnknownVarFromWiredMenuController_Boolean_2:Boolean;
      
      private var UnknownVarFromWiredMenuController_VariableManagementOverviewController_1:VariableManagementOverviewController;
      
      private var UnknownVarFromWiredMenuController_VariableManagementDetailController_1:VariableManagementDetailController;
      
      private var _roomLogListController:WiredRoomLogListController;
      
      private var _wiredMenuButton:Boolean;
      
      private var _wiredInspectButton:Boolean;
      
      private var _playTestMode:Boolean;
      
      private var _wiredWhisperDisabled:Boolean;
      
      private var _showAllNotifications:Boolean;
      
      private var _uiStyle:String = "illumina";
      
      private var _disposed:Boolean = false;
      
      public function WiredMenuController(param1:HabboUserDefinedRoomEvents, param2:IComponent_2, param3:uint = 0, param4:IAssetLibraryCollection = null)
      {
         super(param2,param3,param4);
         _roomEvents = param1;
         _messageEvents = new Vector.<IMessageEvent>();
         _messageEvents.push(new WiredPermissionsEvent(onWiredPermissions));
         _messageEvents.push(new AccountPreferencesEvent(onAccountPreferences));
         _messageEvents.push(new YouAreControllerMessageEvent(onControllerMessageEvent));
         for each(var _loc5_ in _messageEvents)
         {
            addMessageEvent(_loc5_);
         }
         UnknownVarFromWiredMenuController_VariableManagementOverviewController_1 = new VariableManagementOverviewController(param1,param2,0,param4);
         UnknownVarFromWiredMenuController_VariableManagementDetailController_1 = new VariableManagementDetailController(param1,param2,0,param4);
         _roomLogListController = new WiredRoomLogListController(param1,param2,0,param4);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         },true),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
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
         },false,[{
            "type":"REE_DISPOSED",
            "callback":roomEventHandler
         }]),new ComponentDependency(new IIDHabboRoomSessionManager(),null,false,[{
            "type":"RSE_STARTED",
            "callback":roomSessionEventHandler
         }]),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:IAvatarRenderManager):void
         {
            _avatarRenderManager = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         context.addLinkEventTracker(this);
      }
      
      public function get linkPattern() : String
      {
         return "wiredmenu/";
      }
      
      public function linkReceived(param1:String) : void
      {
         if(!isEnabled || !hasReadPermission)
         {
            windowManager.alert("${wiredmenu.invalid_room.title}","${wiredmenu.invalid_room.desc}",0,null);
            return;
         }
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 2)
         {
            return;
         }
         if(_loc2_[1] == "open")
         {
            showView();
            if(_loc2_.length >= 3)
            {
               view.selectTab(_loc2_[2]);
               if(_loc2_[2] == WiredMenuTabConfigs.TAB_INSPECTION_ID)
               {
                  routeInspectionLink(param1);
               }
               else if(_loc2_[2] == WiredMenuTabConfigs.TAB_OVERVIEW_ID)
               {
                  routeOverviewLink(param1);
               }
            }
         }
         if(_loc2_[1] == "logs")
         {
            if(!isShowing())
            {
               showView();
               view.selectTab(WiredMenuTabConfigs.TAB_MONITOR_ID);
            }
            if(_roomLogListController.view == null || !_roomLogListController.view.isShowing())
            {
               _roomLogListController.send(new WiredGetRoomLogsComposer(1,WiredRoomLogsConfig.PAGE_SIZE,-1,-1,""));
            }
            else
            {
               _roomLogListController.view.activate();
            }
         }
      }
      
      public function routeInspectionLink(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 5)
         {
            return;
         }
         var _loc3_:WiredMenuInspectionTab = view.activeTab as WiredMenuInspectionTab;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:int = parseInt(_loc2_[4]);
         if(_loc2_[3] == String(WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1))
         {
            _loc3_.inspectFurni(_loc4_,true);
         }
         else if(_loc2_[3] == String(WiredInputSourcePicker.USER_SOURCE))
         {
            _loc3_.inspectUser(_loc4_,true);
         }
      }
      
      public function routeOverviewLink(param1:String) : void
      {
         var _loc3_:Array = param1.split("/");
         if(_loc3_.length < 4)
         {
            return;
         }
         var _loc2_:WiredMenuOverviewTab = view.activeTab as WiredMenuOverviewTab;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:String = _loc3_[3];
         _loc2_.jumpToVariableByName(_loc4_);
      }
      
      public function toggleView() : void
      {
         if(isShowing())
         {
            hideView();
         }
         else
         {
            showView();
         }
      }
      
      private function showView() : void
      {
         if(!isEnabled || !hasReadPermission)
         {
            return;
         }
         if(!_view || _view.disposed)
         {
            _view = new WiredMenuView(this,_windowManager);
            _view.initialize();
         }
         _view.show();
      }
      
      private function hideView() : void
      {
         if(!_view || _view.disposed)
         {
            return;
         }
         _view.hide();
      }
      
      private function isShowing() : Boolean
      {
         return _view != null && !_view.disposed && _view.isShowing();
      }
      
      public function get isEnabled() : Boolean
      {
         return getBoolean("wired.menu.enabled");
      }
      
      public function isRoomOwnerOrStaff() : Boolean
      {
         var _loc3_:IRoomSession = _roomEvents.roomSession;
         if(_loc3_ == null)
         {
            return false;
         }
         var _loc2_:Boolean = _sessionDataManager.hasSecurity(4);
         var _loc1_:Boolean = _roomEvents.roomSession.isRoomOwner;
         return _loc2_ || _loc1_;
      }
      
      public function get hasReadPermission() : Boolean
      {
         if(isRoomOwnerOrStaff())
         {
            return true;
         }
         return UnknownVarFromWiredMenuController_Boolean_2;
      }
      
      public function get hasWritePermission() : Boolean
      {
         if(isRoomOwnerOrStaff())
         {
            return true;
         }
         return UnknownVarFromWiredMenuController_Boolean_1;
      }
      
      public function send(param1:IMessageComposer) : void
      {
         _communicationManager.connection.send(param1);
      }
      
      public function addMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _communicationManager.addHabboConnectionMessageEvent(param1);
      }
      
      public function removeMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _communicationManager.removeHabboConnectionMessageEvent(param1);
      }
      
      private function roomEventHandler(param1:RoomEngineEvent) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         var _loc2_:* = param1.type;
         if("REE_DISPOSED" === _loc2_)
         {
            if(_view != null)
            {
               _view.dispose();
               _view = null;
            }
         }
      }
      
      private function onWiredPermissions(param1:WiredPermissionsEvent) : void
      {
         var _loc2_:WiredPermissionsMessageParser = param1.getParser();
         UnknownVarFromWiredMenuController_Boolean_1 = _loc2_.canModify;
         UnknownVarFromWiredMenuController_Boolean_2 = _loc2_.canRead;
         if(_view != null && !_view.disposed)
         {
            if(!UnknownVarFromWiredMenuController_Boolean_2)
            {
               _view.dispose();
               _view = null;
            }
            else
            {
               _view.permissionsUpdated();
            }
         }
         _roomEvents.wiredChest.onPermissionsChanged();
      }
      
      private function onAccountPreferences(param1:AccountPreferencesEvent) : void
      {
         _wiredMenuButton = param1.getParser().wiredMenuButton;
         _wiredInspectButton = param1.getParser().wiredInspectButton;
         setPlayTestMode(param1.getParser().playTestMode);
         _wiredWhisperDisabled = param1.getParser().wiredWhisperDisabled;
         _showAllNotifications = param1.getParser().showAllNotifications;
         uiStyle = param1.getParser().wiredUiStyle;
      }
      
      private function onControllerMessageEvent(param1:IMessageEvent) : void
      {
         var _loc2_:IRoomSession = roomEvents.roomSession;
         if(_loc2_ != null && _playTestMode)
         {
            roomEvents.notifications.addItem(localizationManager.getLocalization("wiredmenu.settings.preferences.notification.playtest"),"info","icon_wired_notification_png","wiredmenu/open/settings");
         }
      }
      
      private function roomSessionEventHandler(param1:RoomSessionEvent) : void
      {
         if(param1.type != "RSE_STARTED")
         {
            return;
         }
         param1.session.playTestMode = _playTestMode;
      }
      
      public function get wiredMenuButton() : Boolean
      {
         return _wiredMenuButton;
      }
      
      public function set wiredMenuButton(param1:Boolean) : void
      {
         _wiredMenuButton = param1;
         roomEvents.events.dispatchEvent(new WiredMenuEvent("WIRED_MENU_BUTTON_PREFERENCE_CHANGED"));
      }
      
      public function get wiredInspectButton() : Boolean
      {
         return _wiredInspectButton;
      }
      
      public function get showAllNotifications() : Boolean
      {
         return _showAllNotifications;
      }
      
      public function get uiStyle() : String
      {
         return _uiStyle;
      }
      
      public function get wiredWhisperDisabled() : Boolean
      {
         return _wiredWhisperDisabled;
      }
      
      public function set wiredWhisperDisabled(param1:Boolean) : void
      {
         _wiredWhisperDisabled = param1;
         sendPreferences();
      }
      
      public function set wiredInspectButton(param1:Boolean) : void
      {
         _wiredInspectButton = param1;
      }
      
      public function set showAllNotifications(param1:Boolean) : void
      {
         _showAllNotifications = param1;
      }
      
      public function set uiStyle(param1:String) : void
      {
         if(param1 == _uiStyle)
         {
            return;
         }
         _uiStyle = param1;
         if(getBoolean("wired.ui_picker_enabled"))
         {
            _roomEvents.wiredCtrl.setPreferredWiredStyleByName(_uiStyle == "" ? "illumina" : _uiStyle);
         }
      }
      
      public function get playTestMode() : Boolean
      {
         return _playTestMode;
      }
      
      public function setPlayTestMode(param1:Boolean, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc5_:String = null;
         var _loc4_:WiredMenuSettingsTab = null;
         var _loc6_:IRoomSession = roomEvents.roomSession;
         if(_loc6_ != null)
         {
            _loc6_.playTestMode = param1;
         }
         if(_playTestMode != param1 && param2)
         {
            _playTestMode = param1;
            _loc5_ = "wiredmenu.settings.preferences.notification.playtest." + (param1 ? "enabled" : "disabled");
            roomEvents.notifications.addItem(localizationManager.getLocalization(_loc5_),"info","icon_wired_notification_png","wiredmenu/open/settings");
            if(param3)
            {
               sendPreferences();
               if(_view != null)
               {
                  _loc4_ = _view.activeTab as WiredMenuSettingsTab;
                  if(_loc4_ == null)
                  {
                     return;
                  }
                  _loc4_.updatePreferencesUI();
               }
            }
         }
      }
      
      public function furniSelected(param1:int) : void
      {
         if(!isEnabled || _view == null || _view.disposed)
         {
            return;
         }
         if(_view.activeTabId == WiredMenuTabConfigs.TAB_INSPECTION_ID)
         {
            (_view.activeTab as WiredMenuInspectionTab).inspectFurni(param1);
         }
      }
      
      public function userSelected(param1:int) : void
      {
         if(!isEnabled || _view == null || _view.disposed)
         {
            return;
         }
         if(_view.activeTabId == WiredMenuTabConfigs.TAB_INSPECTION_ID)
         {
            (_view.activeTab as WiredMenuInspectionTab).inspectUser(param1);
         }
      }
      
      public function sendPreferences() : void
      {
         send(new WiredSetPreferencesMessageComposer(wiredMenuButton,wiredInspectButton,playTestMode,wiredWhisperDisabled,showAllNotifications,uiStyle));
      }
      
      public function hasUIOpen() : Boolean
      {
         return _view != null && _view.isShowing();
      }
      
      override public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(UnknownVarFromWiredMenuController_VariableManagementOverviewController_1)
         {
            UnknownVarFromWiredMenuController_VariableManagementOverviewController_1.dispose();
            UnknownVarFromWiredMenuController_VariableManagementOverviewController_1 = null;
         }
         if(UnknownVarFromWiredMenuController_VariableManagementDetailController_1)
         {
            UnknownVarFromWiredMenuController_VariableManagementDetailController_1.dispose();
            UnknownVarFromWiredMenuController_VariableManagementDetailController_1 = null;
         }
         if(_roomLogListController)
         {
            _roomLogListController.dispose();
            _roomLogListController = null;
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
         _messageEvents = null;
         _communicationManager = null;
         _sessionDataManager = null;
         _windowManager = null;
         _localizationManager = null;
         _roomEngine = null;
         super.dispose();
      }
      
      override public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get communicationManager() : IHabboCommunicationManager
      {
         return _communicationManager;
      }
      
      public function get localizationManager() : IHabboLocalizationManager
      {
         return _localizationManager;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get avatarRenderManager() : IAvatarRenderManager
      {
         return _avatarRenderManager;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      public function get view() : WiredMenuView
      {
         return _view;
      }
      
      public function get roomEvents() : HabboUserDefinedRoomEvents
      {
         return _roomEvents;
      }
      
      public function get variablesSynchronizer() : WiredVariablesSynchronizer
      {
         return _roomEvents.variablesSynchronizer;
      }
      
      public function get roomLogListController() : WiredRoomLogListController
      {
         return _roomLogListController;
      }
   }
}

