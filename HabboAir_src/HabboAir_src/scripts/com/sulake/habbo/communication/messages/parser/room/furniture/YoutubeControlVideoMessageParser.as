package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class YoutubeControlVideoMessageParser implements IMessageParser
   {
      private var _furniId:int;
      
      private var _commandId:int;
      
      public function YoutubeControlVideoMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _furniId = param1.readInteger();
         _commandId = param1.readInteger();
         return true;
      }
      
      public function get furniId() : int
      {
         return _furniId;
      }
      
      public function get commandId() : int
      {
         return _commandId;
      }
   }
}

