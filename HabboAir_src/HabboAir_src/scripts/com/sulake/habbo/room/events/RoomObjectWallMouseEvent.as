package com.sulake.habbo.room.events
{
   import com.sulake.room.events.RoomObjectMouseEvent;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   public class RoomObjectWallMouseEvent extends RoomObjectMouseEvent
   {
      private var _x:Number;
      
      private var _y:Number;
      
      private var _direction:Number;
      
      private var _wallLocation:Vector3d = null;
      
      private var _wallWidth:Vector3d = null;
      
      private var _wallHeight:Vector3d = null;
      
      public function RoomObjectWallMouseEvent(param1:String, param2:IRoomObject, param3:String, param4:IVector3d, param5:IVector3d, param6:IVector3d, param7:Number, param8:Number, param9:Number, param10:Boolean = false, param11:Boolean = false, param12:Boolean = false, param13:Boolean = false, param14:Boolean = false, param15:Boolean = false)
      {
         super(param1,param2,param3,param10,param11,param12,param13,param14,param15);
         _wallLocation = new Vector3d();
         _wallLocation.assign(param4);
         _wallWidth = new Vector3d();
         _wallWidth.assign(param5);
         _wallHeight = new Vector3d();
         _wallHeight.assign(param6);
         _x = param7;
         _y = param8;
         _direction = param9;
      }
      
      public function get wallLocation() : IVector3d
      {
         return _wallLocation;
      }
      
      public function get wallWidth() : IVector3d
      {
         return _wallWidth;
      }
      
      public function get wallHeight() : IVector3d
      {
         return _wallHeight;
      }
      
      public function get x() : Number
      {
         return _x;
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function get direction() : Number
      {
         return _direction;
      }
   }
}

