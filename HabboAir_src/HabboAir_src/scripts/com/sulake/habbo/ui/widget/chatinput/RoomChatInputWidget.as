package com.sulake.habbo.ui.widget.chatinput
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomDesktop;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.RoomUI;
   import com.sulake.habbo.ui.handler.ChatInputWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetChatInputContentUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetFloodControlEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetChatMessage;
   import com.sulake.habbo.ui.widget.roomtools.RoomToolsWidget;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class RoomChatInputWidget extends RoomWidgetBase
   {
      private static const MIN_PASTE_INTERVAL_MS:int = 0;
      
      private var _visualization:RoomChatInputView;
      
      private var _selectedUserName:String = "";
      
      private var _floodBlocked:Boolean = false;
      
      private var UnknownVarFromRoomChatInputWidget_Timer_1:Timer = null;
      
      private var _lastPasteTime:int;
      
      private var _roomUi:RoomUI;
      
      private var UnknownVarFromRoomChatInputWidget_IRoomDesktop_1:IRoomDesktop;
      
      public function RoomChatInputWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IHabboLocalizationManager, param5:RoomUI, param6:IRoomDesktop)
      {
         super(param1,param2,param3,param4);
         _roomUi = param5;
         UnknownVarFromRoomChatInputWidget_IRoomDesktop_1 = param6;
         _visualization = new RoomChatInputView(this);
         (param1 as ChatInputWidgetHandler).widget = this;
      }
      
      public function get floodBlocked() : Boolean
      {
         return _floodBlocked;
      }
      
      public function get roomUi() : RoomUI
      {
         return _roomUi;
      }
      
      public function get handler() : ChatInputWidgetHandler
      {
         return _widgetHandler as ChatInputWidgetHandler;
      }
      
      override public function dispose() : void
      {
         if(_visualization != null)
         {
            _visualization.dispose();
            _visualization = null;
         }
         if(UnknownVarFromRoomChatInputWidget_Timer_1 != null)
         {
            UnknownVarFromRoomChatInputWidget_Timer_1.stop();
            UnknownVarFromRoomChatInputWidget_Timer_1 = null;
         }
         _roomUi = null;
         super.dispose();
      }
      
      public function get allowPaste() : Boolean
      {
         return true;
      }
      
      public function setLastPasteTime() : void
      {
         _lastPasteTime = getTimer();
      }
      
      public function sendChat(param1:String, param2:int, param3:String = "", param4:int = 0) : void
      {
         if(_floodBlocked)
         {
            return;
         }
         var _loc5_:RoomWidgetChatMessage = new RoomWidgetChatMessage("RWCM_MESSAGE_CHAT",param1,param2,param3,param4);
         if(messageListener != null)
         {
            messageListener.processWidgetMessage(_loc5_);
         }
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWROUE_OBJECT_DESELECTED",onRoomObjectDeselected);
         param1.addEventListener("RWWCIDE_CHAT_INPUT_CONTENT",onChatInputUpdate);
         param1.addEventListener("RWUIUE_PEER",onUserInfo);
         param1.addEventListener("RWFCE_FLOOD_CONTROL",onFloodControl);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWROUE_OBJECT_DESELECTED",onRoomObjectDeselected);
         param1.removeEventListener("RWWCIDE_CHAT_INPUT_CONTENT",onChatInputUpdate);
         param1.removeEventListener("RWUIUE_PEER",onUserInfo);
         param1.removeEventListener("RWFCE_FLOOD_CONTROL",onFloodControl);
      }
      
      private function onRoomObjectDeselected(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         _selectedUserName = "";
      }
      
      private function onUserInfo(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         _selectedUserName = param1.name;
      }
      
      private function onChatInputUpdate(param1:RoomWidgetChatInputContentUpdateEvent) : void
      {
         var _loc2_:String = "";
         switch(param1.messageType)
         {
            case "whisper":
               _loc2_ = localizations.getLocalization("widgets.chatinput.mode.whisper",":tell");
               _visualization.displaySpecialChatMessage(_loc2_,param1.userName);
               break;
            case "shout":
         }
      }
      
      public function refreshChatStyles() : void
      {
         _visualization.createOrUpdateChatStylesView();
      }
      
      private function onReleaseTimerComplete(param1:TimerEvent) : void
      {
         Logger.log("Releasing flood blocking");
         _floodBlocked = false;
         if(_visualization != null)
         {
            _visualization.hideFloodBlocking();
         }
         UnknownVarFromRoomChatInputWidget_Timer_1 = null;
      }
      
      private function onReleaseTimerTick(param1:TimerEvent) : void
      {
         if(_visualization != null)
         {
            _visualization.updateBlockText(UnknownVarFromRoomChatInputWidget_Timer_1.repeatCount - UnknownVarFromRoomChatInputWidget_Timer_1.currentCount);
         }
      }
      
      public function checkChatInputPosition() : void
      {
         _visualization.updatePosition(null);
      }
      
      public function getFriendBarWidth() : int
      {
         if(!_roomUi.friendBarView)
         {
            return 1000;
         }
         return _roomUi.friendBarView.friendBarWidth;
      }
      
      public function getToolBarWidth() : int
      {
         if(!_roomUi.toolbar)
         {
            return 1000;
         }
         return _roomUi.toolbar.toolBarAreaWidth;
      }
      
      public function getRoomToolsWidth() : int
      {
         var _loc1_:RoomToolsWidget = UnknownVarFromRoomChatInputWidget_IRoomDesktop_1.getWidget("RWE_ROOM_TOOLS") as RoomToolsWidget;
         if(!_loc1_)
         {
            return 0;
         }
         return _loc1_.getWidgetAreaWidth();
      }
      
      public function get selectedUserName() : String
      {
         return _selectedUserName;
      }
      
      public function onFloodControl(param1:RoomWidgetFloodControlEvent) : void
      {
      }
      
      override public function get mainWindow() : IWindowModel
      {
         return _visualization.window;
      }
      
      public function hide() : void
      {
         if(mainWindow)
         {
            mainWindow.visible = false;
         }
      }
      
      private function show() : void
      {
         if(mainWindow)
         {
            mainWindow.visible = true;
         }
      }
      
      public function getChatInputY() : int
      {
         return !!_visualization ? _visualization.getChatInputY() : 0;
      }
      
      public function getChatInputElements() : Array
      {
         var _loc1_:Array = null;
         if(_visualization)
         {
            _loc1_ = _visualization.getChatWindowElements();
         }
         return _loc1_;
      }
      
      public function hideTransientSelectors() : void
      {
         if(_visualization != null)
         {
            _visualization.hideTransientSelectors();
         }
      }
      
      override public function release() : void
      {
         if(_visualization != null)
         {
            _visualization.release();
         }
         hide();
         UnknownVarFromRoomChatInputWidget_IRoomDesktop_1 = null;
         super.release();
      }
      
      override public function reuse(param1:IRoomDesktop) : void
      {
         super.reuse(param1);
         UnknownVarFromRoomChatInputWidget_IRoomDesktop_1 = param1;
         show();
      }
   }
}

