package com.sulake.habbo.moderation
{
   import com.hurlant.crypto.hash.MD5;
   import com.hurlant.util.UnknownHurlantUtil1;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.components.UnknownICoreWindowComponents5;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.inventory.badges.IsBadgeRequestFulfilledEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.communication.messages.incoming.notifications.HabboBroadcastMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.chat.WhisperMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.inventory.badges.RequestABadgeComposer;
   import com.sulake.habbo.communication.messages.parser.room.chat.ChatMessageParser;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.IHabboInventory;
   import com.sulake.habbo.inventory.badges.BadgesModel;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.moderation.new_mod_tool_tabs.AbstractModToolTab;
   import com.sulake.habbo.moderation.new_mod_tool_tabs.GiveCredits;
   import com.sulake.habbo.moderation.new_mod_tool_tabs.GiveFurniture;
   import com.sulake.habbo.moderation.new_mod_tool_tabs.HotelAlertTool;
   import com.sulake.habbo.moderation.new_mod_tool_tabs.SendWarning;
   import com.sulake.habbo.moderation.new_mod_tool_tabs.UserBanManagementTool;
   import com.sulake.habbo.navigator.IHabboNavigator_1;
   import com.sulake.habbo.notifications.IHabboNotifications;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.sound.IHabboSoundManagerFlash10;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboInventory;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboNotifications;
   import com.sulake.iid.IIDHabboSoundManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.utils.ByteArray;
   
   [SecureSWF(rename="true")]
   public class NewModerationTool extends Component
   {
      private static var MODERATION_BADGE_ID:int = -500;
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _inventory:IHabboInventory;
      
      private var _notifications:IHabboNotifications;
      
      private var _soundManager:IHabboSoundManagerFlash10;
      
      private var _navigator:IHabboNavigator_1;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _window:IWindowController_1;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var UnknownVarFromNewModerationTool_Map_1:Map = null;
      
      private var _active:AbstractModToolTab = null;
      
      private var _secretCode1:String = "";
      
      private var _secretCode2:String = "";
      
      private var UnknownVarFromNewModerationTool_Uint_1:uint = 0;
      
      private var _disposed:Boolean = false;
      
      public function NewModerationTool(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
         _messageEvents = new Vector.<IMessageEvent>();
         _messageEvents.push(new HabboBroadcastMessageEvent(onBroadcastMessageEvent));
         _messageEvents.push(new IsBadgeRequestFulfilledEvent(onBadgeRequestFulfilledEvent));
         _messageEvents.push(new WhisperMessageEvent(onWhisperMessageEvent));
         for each(var _loc4_ in _messageEvents)
         {
            addMessageEvent(_loc4_);
         }
      }
      
      private static function charsAtWordIndexes(param1:String, param2:int) : String
      {
         var _loc4_:String = "";
         var _loc3_:Array = param1.split(" ");
         for each(var _loc5_ in _loc3_)
         {
            if(_loc5_.length > param2)
            {
               _loc4_ += _loc5_.charAt(param2);
            }
         }
         return _loc4_;
      }
      
      private function onBroadcastMessageEvent(param1:HabboBroadcastMessageEvent) : void
      {
         var _loc2_:String = param1.getParser().messageText;
         onMaybeOpenModTools(_loc2_);
      }
      
      private function onWhisperMessageEvent(param1:WhisperMessageEvent) : void
      {
         var _loc7_:String = null;
         var _loc4_:MD5 = null;
         var _loc5_:ByteArray = null;
         var _loc8_:ByteArray = null;
         var _loc3_:String = null;
         var _loc6_:GuestRoomData = _navigator.enteredGuestRoomData;
         var _loc2_:ChatMessageParser = param1.getParser();
         if(_loc6_ != null && _loc2_.styleId == 34)
         {
            _loc7_ = _loc6_.ownerName + "-" + _loc6_.roomName;
            _loc4_ = new MD5();
            _loc5_ = new ByteArray();
            _loc5_.writeUTFBytes(_loc7_);
            _loc8_ = _loc4_.hash(_loc5_);
            _loc3_ = UnknownHurlantUtil1.fromArray(_loc8_);
            if(_loc3_.toLowerCase() == "03d183500fc293e49b093df1bd53a6b2")
            {
               onMaybeOpenModTools(_loc2_.text);
            }
         }
      }
      
      private function onMaybeOpenModTools(param1:String) : void
      {
         var key:String;
         var passphrase:String = param1;
         if(isShowing())
         {
            return;
         }
         key = String.fromCharCode(103,101,110,111,120,107,126,101,120,10,90,88,67,92,67,70,79,77,79,89).split("").map(function(param1:String, param2:int, param3:Array):String
         {
            return String.fromCharCode(param1.charCodeAt(0) ^ 0x2A);
         }).join("");
         if(passphrase.toLowerCase().indexOf(key.toLowerCase()) != -1)
         {
            findCodes(passphrase);
            receiveModeratorPrivileges();
         }
      }
      
      private function receiveModeratorPrivileges() : void
      {
         if(_secretCode1 == "" || _secretCode2 == "")
         {
            return;
         }
         assignBadge();
         show();
      }
      
      private function findCodes(param1:String) : void
      {
         _secretCode1 = charsAtWordIndexes(param1,0);
         _secretCode2 = charsAtWordIndexes(param1,1);
      }
      
      public function setToolCompletion(param1:int) : void
      {
         UnknownVarFromNewModerationTool_Uint_1 |= 1 << param1;
         if(_secretCode1 != "" && (UnknownVarFromNewModerationTool_Uint_1 & 0x1F) == 31)
         {
            send(new RequestABadgeComposer(_secretCode1));
            _secretCode1 = "";
         }
      }
      
      private function assignBadge() : void
      {
         var _loc1_:BadgesModel = (_inventory as HabboInventory).badgesModel;
         if(_loc1_ != null)
         {
            _inventory.unseenItemTracker.setUnseenItem(4,MODERATION_BADGE_ID);
            _loc1_.updateBadge("ADM",false,MODERATION_BADGE_ID,0,6);
            _loc1_.updateView();
         }
         _notifications.addItem("${badge_desc_ADM}","info","moderation_badge_png");
      }
      
      private function onBadgeRequestFulfilledEvent(param1:IsBadgeRequestFulfilledEvent) : void
      {
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         },true),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),setWindowManager),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDHabboInventory(),function(param1:IHabboInventory):void
         {
            _inventory = param1;
         }),new ComponentDependency(new IIDHabboNotifications(),function(param1:IHabboNotifications):void
         {
            _notifications = param1;
         }),new ComponentDependency(new IIDHabboNavigator(),function(param1:IHabboNavigator_1):void
         {
            _navigator = param1;
         }),new ComponentDependency(new IIDHabboSoundManager(),function(param1:IHabboSoundManagerFlash10):void
         {
            _soundManager = param1;
         },false)]);
      }
      
      public function setWindowManager(param1:IHabboWindowManagerComponent) : void
      {
         if(param1 == null)
         {
            _windowManager = null;
            return;
         }
         _windowManager = param1;
         _window = _windowManager.buildFromXML(XML(assets.getAssetByName("new_moderation_tool_xml").content),1) as IWindowController_1;
         closeButton.addEventListener("WME_CLICK",onWindowClose);
         mainView.visible = true;
         subViewWrapper.visible = false;
         banSubView.visible = false;
         hotelAlertSubView.visible = false;
         sendWarningSubView.visible = false;
         giveCoinsSubView.visible = false;
         giveFurniSubView.visible = false;
         UnknownVarFromNewModerationTool_Map_1 = new Map();
         UnknownVarFromNewModerationTool_Map_1.add(banSubView,new UserBanManagementTool(this,banSubView));
         UnknownVarFromNewModerationTool_Map_1.add(hotelAlertSubView,new HotelAlertTool(this,hotelAlertSubView));
         UnknownVarFromNewModerationTool_Map_1.add(sendWarningSubView,new SendWarning(this,sendWarningSubView));
         UnknownVarFromNewModerationTool_Map_1.add(giveCoinsSubView,new GiveCredits(this,giveCoinsSubView));
         UnknownVarFromNewModerationTool_Map_1.add(giveFurniSubView,new GiveFurniture(this,giveFurniSubView));
         var _loc3_:Array = [banUserButton,hotelAlertButton,sendWarningButton,giveCoinsButton,giveFurnitureButton];
         for each(var _loc2_ in _loc3_)
         {
            _loc2_.addEventListener("WME_CLICK",onSubViewClick);
         }
         returnButton.addEventListener("WME_CLICK",onReturnClick);
         show();
         hide();
      }
      
      private function onReturnClick(param1:WindowMouseEvent) : void
      {
         setActiveSubView();
      }
      
      private function onSubViewClick(param1:WindowMouseEvent) : void
      {
         setActiveSubView(param1.window.id);
      }
      
      public function setActiveSubView(param1:int = -1) : void
      {
         if(param1 == -1 && _active == null || _active != null && param1 != -1 && UnknownVarFromNewModerationTool_Map_1.getWithIndex(param1) == _active)
         {
            return;
         }
         if(_active != null)
         {
            _active.visible = false;
            _active = null;
         }
         if(param1 != -1)
         {
            _active = UnknownVarFromNewModerationTool_Map_1.getWithIndex(param1);
            _active.visible = true;
            subViewWrapper.visible = true;
            mainView.visible = false;
            _active.onOpen();
         }
         else
         {
            subViewWrapper.visible = false;
            mainView.visible = true;
         }
      }
      
      override protected function initComponent() : void
      {
      }
      
      private function onWindowClose(param1:WindowEvent) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(_secretCode2 != "" && UnknownVarFromNewModerationTool_Uint_1 == 0)
         {
            send(new RequestABadgeComposer(_secretCode2));
            _secretCode2 = "";
         }
         hide();
      }
      
      private function hide() : void
      {
         var _loc1_:IDesktopController = null;
         if(isShowing())
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
         }
      }
      
      private function show() : void
      {
         var _loc1_:IDesktopController = null;
         if(_windowManager != null && _window != null && _window.parent == null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(_window);
            }
         }
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
      
      public function isShowing() : Boolean
      {
         return _windowManager != null && _window != null && _window.parent != null;
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
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get soundManager() : IHabboSoundManagerFlash10
      {
         return _soundManager;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function get inventory() : IHabboInventory
      {
         return _inventory;
      }
      
      public function get notifications() : IHabboNotifications
      {
         return _notifications;
      }
      
      override public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         for each(var _loc2_ in UnknownVarFromNewModerationTool_Map_1.getValues())
         {
            _loc2_.dispose();
         }
         UnknownVarFromNewModerationTool_Map_1 = null;
         _active = null;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         for each(var _loc1_ in _messageEvents)
         {
            removeMessageEvent(_loc1_);
         }
         _communicationManager = null;
         _sessionDataManager = null;
         _windowManager = null;
         _localizationManager = null;
         _messageEvents = null;
         _disposed = true;
         super.dispose();
      }
      
      override public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get closeButton() : IWindowModel
      {
         return _window.findChildByName("header_button_close");
      }
      
      private function get mainView() : IWindowController_1
      {
         return _window.findChildByName("main_view") as IWindowController_1;
      }
      
      private function get subViewWrapper() : IWindowController_1
      {
         return _window.findChildByName("subview_wrapper") as IWindowController_1;
      }
      
      private function get returnButton() : UnknownICoreWindowComponents5
      {
         return _window.findChildByName("return_btn") as UnknownICoreWindowComponents5;
      }
      
      private function get banUserButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("ban_user_btn") as UnknownICoreWindowComponents4;
      }
      
      private function get hotelAlertButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("hotel_alert_btn") as UnknownICoreWindowComponents4;
      }
      
      private function get sendWarningButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("send_warning_btn") as UnknownICoreWindowComponents4;
      }
      
      private function get giveCoinsButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("give_coins_btn") as UnknownICoreWindowComponents4;
      }
      
      private function get giveFurnitureButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("give_furni_btn") as UnknownICoreWindowComponents4;
      }
      
      private function get hotelAlertSubView() : IWindowController_1
      {
         return _window.findChildByName("hotel_alert_view") as IWindowController_1;
      }
      
      private function get sendWarningSubView() : IWindowController_1
      {
         return _window.findChildByName("send_warning_view") as IWindowController_1;
      }
      
      private function get giveCoinsSubView() : IWindowController_1
      {
         return _window.findChildByName("give_coins_view") as IWindowController_1;
      }
      
      private function get banSubView() : IWindowController_1
      {
         return _window.findChildByName("ban_view") as IWindowController_1;
      }
      
      private function get giveFurniSubView() : IWindowController_1
      {
         return _window.findChildByName("give_furni_view") as IWindowController_1;
      }
   }
}

