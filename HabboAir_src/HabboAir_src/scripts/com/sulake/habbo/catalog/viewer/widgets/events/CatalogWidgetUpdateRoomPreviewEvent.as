package com.sulake.habbo.catalog.viewer.widgets.events
{
   import flash.events.Event;
   
   public class CatalogWidgetUpdateRoomPreviewEvent extends Event
   {
      private var _wallType:String = "default";
      
      private var _floorType:String = "default";
      
      private var _landscapeType:String = "1.1";
      
      private var _tileSize:int = 64;
      
      public function CatalogWidgetUpdateRoomPreviewEvent(param1:String, param2:String, param3:String, param4:int, param5:Boolean = false, param6:Boolean = false)
      {
         super("UPDATE_ROOM_PREVIEW",param5,param6);
         _floorType = param1;
         _wallType = param2;
         _landscapeType = param3;
         _tileSize = param4;
      }
      
      public function get wallType() : String
      {
         return _wallType;
      }
      
      public function get floorType() : String
      {
         return _floorType;
      }
      
      public function get landscapeType() : String
      {
         return _landscapeType;
      }
      
      public function get tileSize() : int
      {
         return _tileSize;
      }
   }
}

