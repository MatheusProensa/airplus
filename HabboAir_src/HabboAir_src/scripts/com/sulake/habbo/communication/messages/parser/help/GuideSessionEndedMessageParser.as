package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuideSessionEndedMessageParser implements IMessageParser
   {
      private var _endReason:int = 0;
      
      public function GuideSessionEndedMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _endReason = param1.readInteger();
         return true;
      }
      
      public function get endReason() : int
      {
         return _endReason;
      }
   }
}

