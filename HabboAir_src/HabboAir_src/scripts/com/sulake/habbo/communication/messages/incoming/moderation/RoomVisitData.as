package com.sulake.habbo.communication.messages.incoming.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class RoomVisitData
   {
      private var _roomId:int;
      
      private var _roomName:String;
      
      private var _enterHour:int;
      
      private var _enterMinute:int;
      
      public function RoomVisitData(param1:IMessageDataWrapper)
      {
         super();
         _roomId = param1.readInteger();
         _roomName = param1.readString();
         _enterHour = param1.readInteger();
         _enterMinute = param1.readInteger();
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get roomName() : String
      {
         return _roomName;
      }
      
      public function get enterHour() : int
      {
         return _enterHour;
      }
      
      public function get enterMinute() : int
      {
         return _enterMinute;
      }
   }
}

