package com.sulake.habbo.communication.messages.parser.availability
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class LoginFailedHotelClosedMessageParser implements IMessageParser
   {
      private var _openHour:int;
      
      private var _openMinute:int;
      
      public function LoginFailedHotelClosedMessageParser()
      {
         super();
      }
      
      public function get openHour() : int
      {
         return _openHour;
      }
      
      public function get openMinute() : int
      {
         return _openMinute;
      }
      
      public function flush() : Boolean
      {
         _openHour = 0;
         _openMinute = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _openHour = param1.readInteger();
         _openMinute = param1.readInteger();
         return true;
      }
   }
}

