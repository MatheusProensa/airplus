package com.sulake.habbo.communication.messages.parser.availability
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class AvailabilityTimeMessageParser implements IMessageParser
   {
      private var _isOpen:Boolean;
      
      private var _minutesUntilChange:int;
      
      public function AvailabilityTimeMessageParser()
      {
         super();
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function get minutesUntilChange() : int
      {
         return _minutesUntilChange;
      }
      
      public function flush() : Boolean
      {
         _isOpen = false;
         _minutesUntilChange = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _isOpen = param1.readInteger() > 0;
         _minutesUntilChange = param1.readInteger();
         return true;
      }
   }
}

