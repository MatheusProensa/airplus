package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.object.data.LegacyStuffData;
   
   [SecureSWF(rename="true")]
   public class ObjectMessageData
   {
      private var _id:int = 0;
      
      private var _x:Number = 0;
      
      private var _y:Number = 0;
      
      private var _z:Number = 0;
      
      private var _dir:int = 0;
      
      private var _sizeX:int = 0;
      
      private var _sizeY:int = 0;
      
      private var _sizeZ:Number = 0;
      
      private var _type:int = 0;
      
      private var _extra:int = -1;
      
      private var _state:int = 0;
      
      private var _data:IStuffData = new LegacyStuffData();
      
      private var _expiryTime:int = 0;
      
      private var _usagePolicy:int;
      
      private var _ownerId:int = 0;
      
      private var _ownerName:String = "";
      
      private var _staticClass:String = null;
      
      private var UnknownVarFromObjectMessageData_Boolean_1:Boolean = false;
      
      private var _trustedSender:Boolean = false;
      
      public function ObjectMessageData(param1:int)
      {
         super();
         _id = param1;
      }
      
      public function setReadOnly() : void
      {
         UnknownVarFromObjectMessageData_Boolean_1 = true;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get x() : Number
      {
         return _x;
      }
      
      public function set x(param1:Number) : void
      {
         if(!UnknownVarFromObjectMessageData_Boolean_1)
         {
            _x = param1;
         }
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function set y(param1:Number) : void
      {
         if(!UnknownVarFromObjectMessageData_Boolean_1)
         {
            _y = param1;
         }
      }
      
      public function get z() : Number
      {
         return _z;
      }
      
      public function set z(param1:Number) : void
      {
         if(!UnknownVarFromObjectMessageData_Boolean_1)
         {
            _z = param1;
         }
      }
      
      public function get dir() : int
      {
         return _dir;
      }
      
      public function set dir(param1:int) : void
      {
         if(!UnknownVarFromObjectMessageData_Boolean_1)
         {
            _dir = param1;
         }
      }
      
      public function get sizeX() : int
      {
         return _sizeX;
      }
      
      public function set sizeX(param1:int) : void
      {
         if(!UnknownVarFromObjectMessageData_Boolean_1)
         {
            _sizeX = param1;
         }
      }
      
      public function get sizeY() : int
      {
         return _sizeY;
      }
      
      public function set sizeY(param1:int) : void
      {
         if(!UnknownVarFromObjectMessageData_Boolean_1)
         {
            _sizeY = param1;
         }
      }
      
      public function get sizeZ() : Number
      {
         return _sizeZ;
      }
      
      public function set sizeZ(param1:Number) : void
      {
         if(!UnknownVarFromObjectMessageData_Boolean_1)
         {
            _sizeZ = param1;
         }
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         if(!UnknownVarFromObjectMessageData_Boolean_1)
         {
            _type = param1;
         }
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         if(!UnknownVarFromObjectMessageData_Boolean_1)
         {
            _state = param1;
         }
      }
      
      public function get data() : IStuffData
      {
         return _data;
      }
      
      public function set data(param1:IStuffData) : void
      {
         if(!UnknownVarFromObjectMessageData_Boolean_1)
         {
            _data = param1;
         }
      }
      
      public function get staticClass() : String
      {
         return _staticClass;
      }
      
      public function set staticClass(param1:String) : void
      {
         if(!UnknownVarFromObjectMessageData_Boolean_1)
         {
            _staticClass = param1;
         }
      }
      
      public function get extra() : int
      {
         return _extra;
      }
      
      public function set extra(param1:int) : void
      {
         if(!UnknownVarFromObjectMessageData_Boolean_1)
         {
            _extra = param1;
         }
      }
      
      public function get expiryTime() : int
      {
         return _expiryTime;
      }
      
      public function set expiryTime(param1:int) : void
      {
         if(!UnknownVarFromObjectMessageData_Boolean_1)
         {
            _expiryTime = param1;
         }
      }
      
      public function get usagePolicy() : int
      {
         return _usagePolicy;
      }
      
      public function set usagePolicy(param1:int) : void
      {
         _usagePolicy = param1;
      }
      
      public function get ownerId() : int
      {
         return _ownerId;
      }
      
      public function set ownerId(param1:int) : void
      {
         _ownerId = param1;
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function set ownerName(param1:String) : void
      {
         _ownerName = param1;
      }
      
      public function get trustedSender() : Boolean
      {
         return _trustedSender;
      }
      
      public function set trustedSender(param1:Boolean) : void
      {
         _trustedSender = param1;
      }
   }
}

