package com.sulake.habbo.ui.widget.roomtools
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.ui.handler.RoomToolsWidgetHandler;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class RoomToolsCtrlBase
   {
      protected static const DISTANCE_FROM_BOTTOM:int = 55;
      
      protected static const TOOLBAR_X:int = -5;
      
      protected static const UnknownConstFromRoomToolsCtrlBase_Int_1:int = 100;
      
      protected var _window:IWindowController_1;
      
      protected var UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1:RoomToolsWidget;
      
      protected var _windowManager:IHabboWindowManagerComponent;
      
      protected var _assets:IAssetLibraryCollection;
      
      protected var _isCollapsed:Boolean = true;
      
      protected var UnknownVarFromRoomToolsCtrlBase_Timer_1:Timer;
      
      protected var UnknownVarFromRoomToolsCtrlBase_Boolean_1:Boolean;
      
      protected var UnknownVarFromRoomToolsCtrlBase_Int_1:int;
      
      public function RoomToolsCtrlBase(param1:RoomToolsWidget, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection)
      {
         super();
         UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1 = param1;
         _windowManager = param2;
         _assets = param3;
         UnknownVarFromRoomToolsCtrlBase_Int_1 = handler.container.config.getInteger("room.enter.info.collapse.delay",5000);
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.procedure = null;
            _window.dispose();
            _window = null;
         }
         if(UnknownVarFromRoomToolsCtrlBase_Timer_1)
         {
            UnknownVarFromRoomToolsCtrlBase_Timer_1.reset();
            UnknownVarFromRoomToolsCtrlBase_Timer_1 = null;
            UnknownVarFromRoomToolsCtrlBase_Boolean_1 = false;
         }
         UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1 = null;
      }
      
      public function setElementVisible(param1:String, param2:Boolean) : void
      {
         if(!_window || !_window.findChildByName(param1))
         {
            return;
         }
         _window.findChildByName(param1).visible = param2;
      }
      
      protected function collapseAfterDelay() : void
      {
         clearCollapseTimer();
         UnknownVarFromRoomToolsCtrlBase_Timer_1 = new Timer(UnknownVarFromRoomToolsCtrlBase_Int_1,1);
         UnknownVarFromRoomToolsCtrlBase_Timer_1.addEventListener("timer",collapseTimerEventHandler);
         UnknownVarFromRoomToolsCtrlBase_Timer_1.start();
      }
      
      protected function collapseIfPending() : void
      {
         if(UnknownVarFromRoomToolsCtrlBase_Boolean_1)
         {
            collapseAfterDelay();
         }
      }
      
      protected function clearCollapseTimer() : void
      {
         if(UnknownVarFromRoomToolsCtrlBase_Timer_1 != null)
         {
            UnknownVarFromRoomToolsCtrlBase_Timer_1.reset();
            UnknownVarFromRoomToolsCtrlBase_Timer_1 = null;
         }
         UnknownVarFromRoomToolsCtrlBase_Boolean_1 = false;
      }
      
      private function collapseTimerEventHandler(param1:TimerEvent) : void
      {
         clearCollapseTimer();
         setCollapsed(true);
      }
      
      protected function cancelWindowCollapse() : void
      {
         if(UnknownVarFromRoomToolsCtrlBase_Timer_1 != null)
         {
            clearCollapseTimer();
            UnknownVarFromRoomToolsCtrlBase_Boolean_1 = true;
         }
      }
      
      public function setCollapsed(param1:Boolean) : void
      {
      }
      
      public function get isCollapsed() : Boolean
      {
         return _isCollapsed;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function get handler() : RoomToolsWidgetHandler
      {
         return !!UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1 ? UnknownVarFromRoomToolsCtrlBase_RoomToolsWidget_1.handler : null;
      }
      
      public function set visible(param1:Boolean) : void
      {
         _window.visible = param1;
      }
   }
}

