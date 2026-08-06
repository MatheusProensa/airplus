package com.sulake.habbo.room.utils
{
   import com.sulake.room.utils.IVector3d;
   
   [SecureSWF(rename="true")]
   public class RoomData
   {
      private var _roomId:int;
      
      private var _data:XML;
      
      private var _floorType:String = null;
      
      private var _wallType:String = null;
      
      private var _landscapeType:String = null;
      
      private var _cameraInitPosition:IVector3d;
      
      public function RoomData(param1:int, param2:XML)
      {
         super();
         _roomId = param1;
         _data = param2;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get data() : XML
      {
         return _data;
      }
      
      public function get floorType() : String
      {
         return _floorType;
      }
      
      public function set floorType(param1:String) : void
      {
         _floorType = param1;
      }
      
      public function get wallType() : String
      {
         return _wallType;
      }
      
      public function set wallType(param1:String) : void
      {
         _wallType = param1;
      }
      
      public function get landscapeType() : String
      {
         return _landscapeType;
      }
      
      public function set landscapeType(param1:String) : void
      {
         _landscapeType = param1;
      }
      
      public function get cameraInitPosition() : IVector3d
      {
         return _cameraInitPosition;
      }
      
      public function set cameraInitPosition(param1:IVector3d) : void
      {
         _cameraInitPosition = param1;
      }
   }
}

