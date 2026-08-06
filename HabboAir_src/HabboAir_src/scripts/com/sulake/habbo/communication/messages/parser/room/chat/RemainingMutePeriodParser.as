package com.sulake.habbo.communication.messages.parser.room.chat
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RemainingMutePeriodParser implements IMessageParser
   {
      private var _secondsRemaining:int = 0;
      
      public function RemainingMutePeriodParser()
      {
         super();
      }
      
      public function get secondsRemaining() : int
      {
         return _secondsRemaining;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _secondsRemaining = param1.readInteger();
         return true;
      }
   }
}

