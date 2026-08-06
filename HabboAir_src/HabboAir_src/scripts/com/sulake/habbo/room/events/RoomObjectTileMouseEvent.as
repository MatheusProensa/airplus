package com.sulake.habbo.room.events
{
   import com.sulake.room.events.RoomObjectMouseEvent;
   import com.sulake.room.object.IRoomObject;
   
   public class RoomObjectTileMouseEvent extends RoomObjectMouseEvent
   {
      private var _tileX:Number;
      
      private var _tileY:Number;
      
      private var _tileZ:Number;
      
      public function RoomObjectTileMouseEvent(param1:String, param2:IRoomObject, param3:String, param4:Number, param5:Number, param6:Number, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false, param10:Boolean = false, param11:Boolean = false, param12:Boolean = false)
      {
         super(param1,param2,param3,param7,param8,param9,param10,param11,param12);
         _tileX = param4;
         _tileY = param5;
         _tileZ = param6;
      }
      
      public function get tileX() : Number
      {
         return _tileX;
      }
      
      public function get tileY() : Number
      {
         return _tileY;
      }
      
      public function get tileZ() : Number
      {
         return _tileZ;
      }
      
      public function get tileXAsInt() : int
      {
         return _tileX + 0.499;
      }
      
      public function get tileYAsInt() : int
      {
         return _tileY + 0.499;
      }
      
      public function get tileZAsInt() : int
      {
         return _tileZ + 0.499;
      }
   }
}

