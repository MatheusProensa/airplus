package com.sulake.habbo.ui.widget.roomtools
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.freeflowchat.IHabboFreeFlowChat;
   import com.sulake.habbo.roomevents.events.WiredAchievementsUpdatedEvent;
   import com.sulake.habbo.ui.IRoomDesktop;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.RoomUI;
   import com.sulake.habbo.ui.handler.RoomToolsWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.chatinput.RoomChatInputWidget;
   import com.sulake.habbo.utils.StringUtil;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class RoomToolsWidget extends RoomWidgetBase
   {
      private static const ROOM_ENTER_INFO_ENABLED_KEY:String = "room.enter.info.enabled";
      
      private static const ROOM_VISIT_HISTORY:RoomVisitHistory = RoomVisitHistory.shared;
      
      private var _currentRoomName:String = "";
      
      private var UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1:RoomToolsToolbarCtrl;
      
      private var UnknownVarFromRoomToolsWidget_RoomToolsInfoCtrl_1:RoomToolsInfoCtrl;
      
      private var UnknownVarFromRoomToolsWidget_IRoomDesktop_1:IRoomDesktop;
      
      private var _freeFlowChat:IHabboFreeFlowChat;
      
      private var UnknownVarFromRoomToolsWidget_Timer_1:Timer;
      
      public function RoomToolsWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:RoomUI)
      {
         super(param1,param2,param3,param4.localization);
         handler.widget = this;
         UnknownVarFromRoomToolsWidget_IRoomDesktop_1 = param4.desktop;
         _freeFlowChat = param4.freeFlowChat;
         UnknownVarFromRoomToolsWidget_RoomToolsInfoCtrl_1 = new RoomToolsInfoCtrl(this,param2,param3);
         UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1 = new RoomToolsToolbarCtrl(this,param2,param3);
         UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1.updateRoomHistoryButtons();
         UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1.setChatHistoryButton(_freeFlowChat != null);
         var _loc5_:String = param4.getProperty("camera.launch.ui.position");
         UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1.setCameraButton(handler.container.sessionDataManager.isPerkAllowed("CAMERA") && (StringUtil.isBlank(_loc5_) || _loc5_ == "room-menu"));
         UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1.setLikeButton(handler.canRate);
         UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1.setAchievementsButton(handler.container.userDefinedRoomEvents.achievementsInRoom.length > 0);
         handler.container.userDefinedRoomEvents.events.addEventListener("WIRED_ACHIEVEMENTS_UPDATED",onAchievementsUpdated);
         UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1.setCollapsed(handler.sessionDataManager.isNoob || !(handler.sessionDataManager.uiFlags & 2));
      }
      
      private function onAchievementsUpdated(param1:WiredAchievementsUpdatedEvent) : void
      {
         UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1.setAchievementsButton(param1.achievements.length > 0);
      }
      
      override public function dispose() : void
      {
         if(UnknownVarFromRoomToolsWidget_Timer_1)
         {
            UnknownVarFromRoomToolsWidget_Timer_1.stop();
            UnknownVarFromRoomToolsWidget_Timer_1 = null;
         }
         if(UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1)
         {
            UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1.dispose();
            UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1 = null;
         }
         if(UnknownVarFromRoomToolsWidget_RoomToolsInfoCtrl_1)
         {
            UnknownVarFromRoomToolsWidget_RoomToolsInfoCtrl_1.dispose();
            UnknownVarFromRoomToolsWidget_RoomToolsInfoCtrl_1 = null;
         }
         _freeFlowChat = null;
         UnknownVarFromRoomToolsWidget_IRoomDesktop_1 = null;
         super.dispose();
      }
      
      public function updateRoomData(param1:GuestRoomData) : void
      {
         ROOM_VISIT_HISTORY.updateRoomName(param1.flatId,param1.roomName);
      }
      
      public function storeRoomData(param1:GuestRoomData) : void
      {
         ROOM_VISIT_HISTORY.onRoomEntered(param1.flatId,param1.roomName);
         if(UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1)
         {
            UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1.setLikeButton(handler.canRate);
         }
      }
      
      public function showRoomInfo(param1:Boolean, param2:String, param3:String, param4:Array) : void
      {
         if(!UnknownVarFromRoomToolsWidget_RoomToolsInfoCtrl_1)
         {
            return;
         }
         _currentRoomName = param2;
         UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1.window.findChildByName("room_name").caption = param2;
         UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1.window.findChildByName("room_owner").caption = param3;
         if(!isRoomEnterInfoEnabled())
         {
            return;
         }
         UnknownVarFromRoomToolsWidget_RoomToolsInfoCtrl_1.showRoomInfo(param1,param2,param3,param4);
      }
      
      public function enterNewRoom(param1:int) : void
      {
         if(!UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1 || !UnknownVarFromRoomToolsWidget_RoomToolsInfoCtrl_1)
         {
            return;
         }
         UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1.disableRoomHistoryButtons();
         if(UnknownVarFromRoomToolsWidget_Timer_1 != null)
         {
            UnknownVarFromRoomToolsWidget_Timer_1.stop();
         }
         UnknownVarFromRoomToolsWidget_Timer_1 = new Timer(2000,1);
         UnknownVarFromRoomToolsWidget_Timer_1.addEventListener("timer",roomButtonTimerEventHandler);
         UnknownVarFromRoomToolsWidget_Timer_1.start();
         UnknownVarFromRoomToolsWidget_RoomToolsInfoCtrl_1.setElementVisible("tags",true);
      }
      
      private function roomButtonTimerEventHandler(param1:TimerEvent) : void
      {
         var _loc2_:Timer = param1.target as Timer;
         if(_loc2_)
         {
            _loc2_.stop();
            _loc2_.removeEventListener("timer",roomButtonTimerEventHandler);
         }
         if(UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1)
         {
            UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1.updateRoomHistoryButtons();
         }
      }
      
      public function setCollapsed(param1:Boolean) : void
      {
         if(UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1)
         {
            UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1.setCollapsed(param1);
         }
      }
      
      public function get handler() : RoomToolsWidgetHandler
      {
         return _widgetHandler as RoomToolsWidgetHandler;
      }
      
      public function getIconLocation(param1:String) : IWindowModel
      {
         return UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1.window.findChildByName(param1);
      }
      
      public function getWidgetAreaWidth() : int
      {
         return !!UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1 ? UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1.right : 0;
      }
      
      public function getChatInputY() : int
      {
         if(!UnknownVarFromRoomToolsWidget_IRoomDesktop_1)
         {
            return 0;
         }
         var _loc1_:RoomChatInputWidget = UnknownVarFromRoomToolsWidget_IRoomDesktop_1.getWidget("RWE_CHAT_INPUT_WIDGET") as RoomChatInputWidget;
         if(!_loc1_)
         {
            return 0;
         }
         return _loc1_.getChatInputY();
      }
      
      public function getRoomToolbarRight() : int
      {
         return !!UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1 ? UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1.right : 0;
      }
      
      public function getCurrentRoomZoomText() : String
      {
         var _loc1_:Number = UnknownVarFromRoomToolsWidget_IRoomDesktop_1 != null ? UnknownVarFromRoomToolsWidget_IRoomDesktop_1.getCurrentRoomCanvasZoomScale() : NaN;
         if(isNaN(_loc1_) || _loc1_ <= 0)
         {
            _loc1_ = 1;
         }
         return (Math.round(Math.log(_loc1_) / 0.6931471805599453) + 1).toString();
      }
      
      public function canZoomRoom(param1:int) : Boolean
      {
         return UnknownVarFromRoomToolsWidget_IRoomDesktop_1 != null && UnknownVarFromRoomToolsWidget_IRoomDesktop_1.canZoomRoomCanvas(param1);
      }
      
      public function zoomRoom(param1:int) : void
      {
         if(UnknownVarFromRoomToolsWidget_IRoomDesktop_1 != null)
         {
            UnknownVarFromRoomToolsWidget_IRoomDesktop_1.zoomRoomCanvas(param1);
         }
      }
      
      public function goToNextRoom() : void
      {
         var _loc1_:RoomVisitHistoryEntry = ROOM_VISIT_HISTORY.goForward();
         if(_loc1_ == null)
         {
            return;
         }
         handler.goToPrivateRoom(_loc1_.flatId);
         UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1.disableRoomHistoryButtons();
      }
      
      public function goToPreviousRoom() : void
      {
         var _loc1_:RoomVisitHistoryEntry = ROOM_VISIT_HISTORY.goBack();
         if(_loc1_ == null)
         {
            return;
         }
         handler.goToPrivateRoom(_loc1_.flatId);
         UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1.disableRoomHistoryButtons();
      }
      
      public function get freeFlowChat() : IHabboFreeFlowChat
      {
         return _freeFlowChat;
      }
      
      public function get roomHistory() : RoomVisitHistory
      {
         return ROOM_VISIT_HISTORY;
      }
      
      public function get currentRoomName() : String
      {
         return _currentRoomName;
      }
      
      private function isRoomEnterInfoEnabled() : Boolean
      {
         return handler != null && handler.container != null && handler.container.config != null && handler.container.config.propertyExists("room.enter.info.enabled") && handler.container.config.getBoolean("room.enter.info.enabled");
      }
      
      override public function release() : void
      {
         UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1.release();
         UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1.visible = false;
         UnknownVarFromRoomToolsWidget_RoomToolsInfoCtrl_1.hide();
         _freeFlowChat.visible = false;
         super.release();
      }
      
      override public function reuse(param1:IRoomDesktop) : void
      {
         super.reuse(param1);
         UnknownVarFromRoomToolsWidget_IRoomDesktop_1 = param1;
         UnknownVarFromRoomToolsWidget_RoomToolsToolbarCtrl_1.visible = true;
      }
   }
}

