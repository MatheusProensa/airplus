package com.sulake.habbo.room.utils
{
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   [SecureSWF(rename="true")]
   public class FurnitureData
   {
      private var _id:int = 0;
      
      private var _typeId:int = 0;
      
      private var _type:String = null;
      
      private var _loc:Vector3d = new Vector3d();
      
      private var _dir:Vector3d = new Vector3d();
      
      private var _state:int = 0;
      
      private var _data:IStuffData = null;
      
      private var _extra:Number = NaN;
      
      private var _expiryTime:int = -1;
      
      private var _usagePolicy:int = 0;
      
      private var _ownerId:int = 0;
      
      private var _ownerName:String = "";
      
      private var _synchronized:Boolean = true;
      
      private var _realRoomObject:Boolean = true;
      
      private var _sizeZ:Number;
      
      public function FurnitureData(param1:int, param2:int, param3:String, param4:IVector3d, param5:IVector3d, param6:int, param7:IStuffData, param8:Number = NaN, param9:int = -1, param10:int = 0, param11:int = 0, param12:String = "", param13:Boolean = true, param14:Boolean = true, param15:Number = -1)
      {
         super();
         _id = param1;
         _typeId = param2;
         _type = param3;
         _loc.assign(param4);
         _dir.assign(param5);
         _state = param6;
         _data = param7;
         _extra = param8;
         _expiryTime = param9;
         _usagePolicy = param10;
         _ownerId = param11;
         _ownerName = param12;
         _synchronized = param13;
         _realRoomObject = param14;
         _sizeZ = param15;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get typeId() : int
      {
         return _typeId;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get loc() : IVector3d
      {
         return _loc;
      }
      
      public function get dir() : IVector3d
      {
         return _dir;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function get data() : IStuffData
      {
         return _data;
      }
      
      public function get extra() : Number
      {
         return _extra;
      }
      
      public function get expiryTime() : int
      {
         return _expiryTime;
      }
      
      public function get usagePolicy() : int
      {
         return _usagePolicy;
      }
      
      public function get ownerId() : int
      {
         return _ownerId;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function get synchronized() : Boolean
      {
         return _synchronized;
      }
      
      public function get realRoomObject() : Boolean
      {
         return _realRoomObject;
      }
      
      public function get sizeZ() : Number
      {
         return _sizeZ;
      }
   }
}

