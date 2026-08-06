package com.sulake.habbo.room.utils
{
   import com.sulake.habbo.room.ISelectedRoomObjectData;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   [SecureSWF(rename="true")]
   public class SelectedRoomObjectData implements ISelectedRoomObjectData
   {
      private var _id:int = 0;
      
      private var _category:int = 0;
      
      private var _operation:String = "";
      
      private var _loc:Vector3d = null;
      
      private var _dir:Vector3d = null;
      
      private var _typeId:int = 0;
      
      private var _instanceData:String = null;
      
      private var _stuffData:IStuffData = null;
      
      private var _state:int = -1;
      
      private var _animFrame:int = -1;
      
      private var _posture:String = null;
      
      public function SelectedRoomObjectData(param1:int, param2:int, param3:String, param4:IVector3d, param5:IVector3d, param6:int = 0, param7:String = null, param8:IStuffData = null, param9:int = -1, param10:int = -1, param11:String = null)
      {
         super();
         _id = param1;
         _category = param2;
         _operation = param3;
         _loc = new Vector3d();
         _loc.assign(param4);
         _dir = new Vector3d();
         _dir.assign(param5);
         _typeId = param6;
         _instanceData = param7;
         _stuffData = param8;
         _state = param9;
         _animFrame = param10;
         _posture = param11;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get category() : int
      {
         return _category;
      }
      
      public function get operation() : String
      {
         return _operation;
      }
      
      public function get loc() : Vector3d
      {
         return _loc;
      }
      
      public function get dir() : Vector3d
      {
         return _dir;
      }
      
      public function get typeId() : int
      {
         return _typeId;
      }
      
      public function get instanceData() : String
      {
         return _instanceData;
      }
      
      public function get stuffData() : IStuffData
      {
         return _stuffData;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function get animFrame() : int
      {
         return _animFrame;
      }
      
      public function get posture() : String
      {
         return _posture;
      }
      
      public function dispose() : void
      {
         _loc = null;
         _dir = null;
      }
   }
}

