package com.sulake.habbo.room.messages
{
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   
   public class RoomObjectDataUpdateMessage extends RoomObjectUpdateMessage
   {
      private var _state:int;
      
      private var _data:IStuffData = null;
      
      private var _extra:Number = NaN;
      
      public function RoomObjectDataUpdateMessage(param1:int, param2:IStuffData, param3:Number = NaN)
      {
         super(null,null);
         _state = param1;
         _data = param2;
         _extra = param3;
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
   }
}

