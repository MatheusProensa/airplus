package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomUseHabbiconMessageParser implements IMessageParser
   {
      private var _roomIndex:int;
      
      private var _habbiconId:int;
      
      public function RoomUseHabbiconMessageParser()
      {
         super();
      }
      
      public function get roomIndex() : int
      {
         return _roomIndex;
      }
      
      public function get habbiconId() : int
      {
         return _habbiconId;
      }
      
      public function flush() : Boolean
      {
         _roomIndex = 0;
         _habbiconId = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _roomIndex = param1.readInteger();
         _habbiconId = param1.readInteger();
         return true;
      }
   }
}

