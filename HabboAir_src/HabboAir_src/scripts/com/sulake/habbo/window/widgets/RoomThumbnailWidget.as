package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   
   public class RoomThumbnailWidget implements IRoomThumbnailWidget
   {
      public static const TYPE:String = "room_thumbnail";
      
      private var UnknownVarFromRoomThumbnailWidget_IWidgetWindowController_1:IWidgetWindowController;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var UnknownVarFromRoomThumbnailWidget_IWindowController_1_1:IWindowController_1;
      
      public function RoomThumbnailWidget(param1:IWidgetWindowController, param2:HabboWindowManagerComponent)
      {
         super();
         UnknownVarFromRoomThumbnailWidget_IWidgetWindowController_1 = param1;
         _windowManager = param2;
         UnknownVarFromRoomThumbnailWidget_IWindowController_1_1 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("room_thumbnail_xml").content as XML) as IWindowController_1;
         UnknownVarFromRoomThumbnailWidget_IWidgetWindowController_1.rootWindow = UnknownVarFromRoomThumbnailWidget_IWindowController_1_1;
         UnknownVarFromRoomThumbnailWidget_IWindowController_1_1.width = UnknownVarFromRoomThumbnailWidget_IWidgetWindowController_1.width;
         UnknownVarFromRoomThumbnailWidget_IWindowController_1_1.height = UnknownVarFromRoomThumbnailWidget_IWidgetWindowController_1.height;
      }
      
      public function reset() : void
      {
      }
      
      public function set flatId(param1:int) : void
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

