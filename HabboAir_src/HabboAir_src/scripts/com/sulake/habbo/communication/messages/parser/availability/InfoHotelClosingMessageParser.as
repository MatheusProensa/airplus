package com.sulake.habbo.communication.messages.parser.availability
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class InfoHotelClosingMessageParser implements IMessageParser
   {
      private var _minutesUntilClosing:int;
      
      public function InfoHotelClosingMessageParser()
      {
         super();
      }
      
      public function get minutesUntilClosing() : int
      {
         return _minutesUntilClosing;
      }
      
      public function flush() : Boolean
      {
         _minutesUntilClosing = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _minutesUntilClosing = param1.readInteger();
         return true;
      }
   }
}

