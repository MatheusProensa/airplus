package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetRoomObjectPlaceEvent extends RoomWidgetRoomObjectUpdateEvent
   {
      public static const UnknownConstFromRoomWidgetRoomObjectPlaceEvent_String_1:String = "RWROUE_OBJECT_PLACED";
      
      private var _wallLocation:String = "";
      
      private var _x:Number = 0;
      
      private var _y:Number = 0;
      
      private var _z:Number = 0;
      
      private var _direction:int = 0;
      
      private var _placedInRoom:Boolean = false;
      
      private var _placedOnFloor:Boolean = false;
      
      private var _placedOnWall:Boolean = false;
      
      private var _instanceData:String = null;
      
      private var _placementSource:String = null;
      
      public function RoomWidgetRoomObjectPlaceEvent(param1:String, param2:int, param3:int, param4:int, param5:String, param6:Number, param7:Number, param8:Number, param9:int, param10:Boolean, param11:Boolean, param12:Boolean, param13:String, param14:String, param15:Boolean = false, param16:Boolean = false)
      {
         super(param1,param2,param3,param4,param15,param16);
         _wallLocation = param5;
         _x = param6;
         _y = param7;
         _z = param8;
         _direction = param9;
         _placedInRoom = param10;
         _placedOnFloor = param11;
         _placedOnWall = param12;
         _instanceData = param13;
         _placementSource = param14;
      }
      
      public function get wallLocation() : String
      {
         return _wallLocation;
      }
      
      public function get x() : Number
      {
         return _x;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function get z() : Number
      {
         return _z;
      }
      
      public function get direction() : int
      {
         return _direction;
      }
      
      public function get placedInRoom() : Boolean
      {
         return _placedInRoom;
      }
      
      public function get placedOnFloor() : Boolean
      {
         return _placedOnFloor;
      }
      
      public function get placedOnWall() : Boolean
      {
         return _placedOnWall;
      }
      
      public function get instanceData() : String
      {
         return _instanceData;
      }
      
      public function get placementSource() : String
      {
         return _placementSource;
      }
   }
}

