package com.sulake.habbo.communication.messages.parser.availability
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class InfoHotelClosedMessageParser implements IMessageParser
   {
      private var _openHour:int;
      
      private var _openMinute:int;
      
      private var _userThrownOutAtClose:Boolean;
      
      public function InfoHotelClosedMessageParser()
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
      
      public function get userThrownOutAtClose() : Boolean
      {
         return _userThrownOutAtClose;
      }
      
      public function flush() : Boolean
      {
         _openHour = 0;
         _openMinute = 0;
         _userThrownOutAtClose = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _openHour = param1.readInteger();
         _openMinute = param1.readInteger();
         _userThrownOutAtClose = param1.readBoolean();
         return true;
      }
   }
}

