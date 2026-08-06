package com.sulake.habbo.communication.messages.parser.nux
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class SelectInitialRoomMessageParser implements IMessageParser
   {
      private var _status:int;
      
      private var _roomId:int;
      
      public function SelectInitialRoomMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _status = param1.readShort();
         _roomId = param1.readInteger();
         return true;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
   }
}

