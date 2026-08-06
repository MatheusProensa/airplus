package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_2;
   import com.sulake.habbo.room.preview.RoomPreviewer;
   import flash.display.BitmapData;
   
   public interface IRoomPreviewerWidget extends IWindowController_2
   {
      function get scale() : int;
      
      function set scale(param1:int) : void;
      
      function get roomPreviewer() : RoomPreviewer;
      
      function showPreview(param1:BitmapData) : void;
      
      function get offsetX() : int;
      
      function set offsetX(param1:int) : void;
      
      function get offsetY() : int;
      
      function set offsetY(param1:int) : void;
      
      function get zoom() : int;
      
      function set zoom(param1:int) : void;
   }
}

