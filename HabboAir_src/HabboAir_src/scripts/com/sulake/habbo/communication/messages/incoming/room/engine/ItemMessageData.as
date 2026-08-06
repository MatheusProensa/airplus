package com.sulake.habbo.communication.messages.incoming.room.engine
{
   [SecureSWF(rename="true")]
   public class ItemMessageData
   {
      private var _id:int = 0;
      
      private var _isOldFormat:Boolean = false;
      
      private var _wallX:int = 0;
      
      private var _wallY:int = 0;
      
      private var _localX:int = 0;
      
      private var _localY:int = 0;
      
      private var _y:Number = 0;
      
      private var _z:Number = 0;
      
      private var _dir:String = "";
      
      private var _type:int = 0;
      
      private var _state:int = 0;
      
      private var _data:String = "";
      
      private var UnknownVarFromItemMessageData_Boolean_1:Boolean = false;
      
      private var _usagePolicy:int = 0;
      
      private var _ownerId:int = 0;
      
      private var _ownerName:String = "";
      
      private var _secondsToExpiration:int;
      
      public function ItemMessageData(param1:int, param2:int, param3:Boolean)
      {
         super();
         _id = param1;
         _type = param2;
         _isOldFormat = param3;
      }
      
      public function setReadOnly() : void
      {
         UnknownVarFromItemMessageData_Boolean_1 = true;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get isOldFormat() : Boolean
      {
         return _isOldFormat;
      }
      
      public function get wallX() : Number
      {
         return _wallX;
      }
      
      public function set wallX(param1:Number) : void
      {
         if(!UnknownVarFromItemMessageData_Boolean_1)
         {
            _wallX = param1;
         }
      }
      
      public function get wallY() : Number
      {
         return _wallY;
      }
      
      public function set wallY(param1:Number) : void
      {
         if(!UnknownVarFromItemMessageData_Boolean_1)
         {
            _wallY = param1;
         }
      }
      
      public function get localX() : Number
      {
         return _localX;
      }
      
      public function set localX(param1:Number) : void
      {
         if(!UnknownVarFromItemMessageData_Boolean_1)
         {
            _localX = param1;
         }
      }
      
      public function get localY() : Number
      {
         return _localY;
      }
      
      public function set localY(param1:Number) : void
      {
         if(!UnknownVarFromItemMessageData_Boolean_1)
         {
            _localY = param1;
         }
      }
      
      public function get y() : Number
      {
         return _y;
      }
      
      public function set y(param1:Number) : void
      {
         if(!UnknownVarFromItemMessageData_Boolean_1)
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
         if(!UnknownVarFromItemMessageData_Boolean_1)
         {
            _z = param1;
         }
      }
      
      public function get dir() : String
      {
         return _dir;
      }
      
      public function set dir(param1:String) : void
      {
         if(!UnknownVarFromItemMessageData_Boolean_1)
         {
            _dir = param1;
         }
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         if(!UnknownVarFromItemMessageData_Boolean_1)
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
         if(!UnknownVarFromItemMessageData_Boolean_1)
         {
            _state = param1;
         }
      }
      
      public function get data() : String
      {
         return _data;
      }
      
      public function set data(param1:String) : void
      {
         if(!UnknownVarFromItemMessageData_Boolean_1)
         {
            _data = param1;
         }
      }
      
      public function get usagePolicy() : int
      {
         return _usagePolicy;
      }
      
      public function set usagePolicy(param1:int) : void
      {
         if(!UnknownVarFromItemMessageData_Boolean_1)
         {
            _usagePolicy = param1;
         }
      }
      
      public function get ownerId() : int
      {
         return _ownerId;
      }
      
      public function set ownerId(param1:int) : void
      {
         if(!UnknownVarFromItemMessageData_Boolean_1)
         {
            _ownerId = param1;
         }
      }
      
      public function get ownerName() : String
      {
         return _ownerName;
      }
      
      public function set ownerName(param1:String) : void
      {
         if(!UnknownVarFromItemMessageData_Boolean_1)
         {
            _ownerName = param1;
         }
      }
      
      public function get secondsToExpiration() : int
      {
         return _secondsToExpiration;
      }
      
      public function set secondsToExpiration(param1:int) : void
      {
         if(!UnknownVarFromItemMessageData_Boolean_1)
         {
            _secondsToExpiration = param1;
         }
      }
   }
}

