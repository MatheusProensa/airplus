package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   
   public class RoomUserCountWidget implements IRoomUserCountWidget
   {
      public static const TYPE:String = "room_user_count";
      
      private var UnknownVarFromRoomUserCountWidget_IWidgetWindowController_1:IWidgetWindowController;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var UnknownVarFromRoomUserCountWidget_IWindowController_1_1:IWindowController_1;
      
      public function RoomUserCountWidget(param1:IWidgetWindowController, param2:HabboWindowManagerComponent)
      {
         super();
         UnknownVarFromRoomUserCountWidget_IWidgetWindowController_1 = param1;
         _windowManager = param2;
         UnknownVarFromRoomUserCountWidget_IWindowController_1_1 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("room_user_count_xml").content as XML) as IWindowController_1;
         UnknownVarFromRoomUserCountWidget_IWidgetWindowController_1.rootWindow = UnknownVarFromRoomUserCountWidget_IWindowController_1_1;
         UnknownVarFromRoomUserCountWidget_IWindowController_1_1.width = UnknownVarFromRoomUserCountWidget_IWidgetWindowController_1.width;
         UnknownVarFromRoomUserCountWidget_IWindowController_1_1.height = UnknownVarFromRoomUserCountWidget_IWidgetWindowController_1.height;
      }
      
      public function set userCount(param1:int) : void
      {
      }
      
      public function get properties() : Array
      {
         return null;
      }
      
      public function set properties(param1:Array) : void
      {
      }
      
      public function dispose() : void
      {
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function get iterator() : IIterator
      {
         return null;
      }
   }
}

