package com.sulake.habbo.communication.messages.incoming.room.furniture
{
   [SecureSWF(rename="true")]
   public class RoomDimmerPresetsMessageData
   {
      private var _id:int = 0;
      
      private var _type:int = 0;
      
      private var _color:uint = 0;
      
      private var _light:uint = 0;
      
      private var UnknownVarFromRoomDimmerPresetsMessageData_Boolean_1:Boolean = false;
      
      public function RoomDimmerPresetsMessageData(param1:int)
      {
         super();
         _id = param1;
      }
      
      public function setReadOnly() : void
      {
         UnknownVarFromRoomDimmerPresetsMessageData_Boolean_1 = true;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         if(!UnknownVarFromRoomDimmerPresetsMessageData_Boolean_1)
         {
            _type = param1;
         }
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function set color(param1:uint) : void
      {
         if(!UnknownVarFromRoomDimmerPresetsMessageData_Boolean_1)
         {
            _color = param1;
         }
      }
      
      public function get light() : int
      {
         return _light;
      }
      
      public function set light(param1:int) : void
      {
         if(!UnknownVarFromRoomDimmerPresetsMessageData_Boolean_1)
         {
            _light = param1;
         }
      }
   }
}

