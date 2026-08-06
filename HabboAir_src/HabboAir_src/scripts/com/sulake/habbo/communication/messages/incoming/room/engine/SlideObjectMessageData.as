package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.room.utils.Vector3d;
   
   [SecureSWF(rename="true")]
   public class SlideObjectMessageData
   {
      public static const UnknownConstFromSlideObjectMessageData_String_1:String = "mv";
      
      public static const UnknownConstFromSlideObjectMessageData_String_2:String = "sld";
      
      private var _id:int = 0;
      
      private var _loc:Vector3d;
      
      private var _target:Vector3d;
      
      private var _moveType:String;
      
      private var UnknownVarFromSlideObjectMessageData_Boolean_1:Boolean = false;
      
      public function SlideObjectMessageData(param1:int, param2:Vector3d, param3:Vector3d, param4:String = null)
      {
         super();
         _id = param1;
         _loc = param2;
         _target = param3;
         _moveType = param4;
      }
      
      public function setReadOnly() : void
      {
         UnknownVarFromSlideObjectMessageData_Boolean_1 = true;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get loc() : Vector3d
      {
         return _loc;
      }
      
      public function set loc(param1:Vector3d) : void
      {
         if(!UnknownVarFromSlideObjectMessageData_Boolean_1)
         {
            _loc = param1;
         }
      }
      
      public function get target() : Vector3d
      {
         return _target;
      }
      
      public function set target(param1:Vector3d) : void
      {
         if(!UnknownVarFromSlideObjectMessageData_Boolean_1)
         {
            _target = param1;
         }
      }
      
      public function get moveType() : String
      {
         return _moveType;
      }
      
      public function set moveType(param1:String) : void
      {
         if(!UnknownVarFromSlideObjectMessageData_Boolean_1)
         {
            _moveType = param1;
         }
      }
   }
}

