package com.sulake.habbo.communication.messages.incoming.users
{
   [SecureSWF(rename="true")]
   public class RoomEntryData
   {
      private var _roomId:int;
      
      private var _roomName:String;
      
      private var _hasControllers:Boolean = false;
      
      public function RoomEntryData(param1:int, param2:String, param3:Boolean)
      {
         super();
         _roomId = param1;
         _roomName = param2;
         _hasControllers = param3;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get roomName() : String
      {
         return _roomName;
      }
      
      public function get hasControllers() : Boolean
      {
         return _hasControllers;
      }
   }
}

