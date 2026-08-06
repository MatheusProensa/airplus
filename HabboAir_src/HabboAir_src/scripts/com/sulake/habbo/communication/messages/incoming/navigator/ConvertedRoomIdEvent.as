package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.navigator.ConvertedRoomIdMessageParser;
   
   [SecureSWF(rename="true")]
   public class ConvertedRoomIdEvent extends MessageEvent
   {
      public function ConvertedRoomIdEvent(param1:Function)
      {
         super(param1,ConvertedRoomIdMessageParser);
      }
      
      public function get globalId() : String
      {
         return (this._parser as ConvertedRoomIdMessageParser).globalId;
      }
      
      public function get convertedId() : int
      {
         return (this._parser as ConvertedRoomIdMessageParser).convertedId;
      }
      
      public function getParser() : ConvertedRoomIdMessageParser
      {
         return _parser as ConvertedRoomIdMessageParser;
      }
   }
}

