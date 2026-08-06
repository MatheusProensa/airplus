package com.sulake.habbo.communication.messages.parser.handshake
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class NoobnessLevelMessageEventMessageParser implements IMessageParser
   {
      private var _noobnessLevel:int;
      
      public function NoobnessLevelMessageEventMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _noobnessLevel = param1.readInteger();
         return true;
      }
      
      public function get noobnessLevel() : int
      {
         return _noobnessLevel;
      }
   }
}

