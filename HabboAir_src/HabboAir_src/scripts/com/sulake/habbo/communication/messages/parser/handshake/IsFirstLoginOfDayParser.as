package com.sulake.habbo.communication.messages.parser.handshake
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class IsFirstLoginOfDayParser implements IMessageParser
   {
      private var _isFirstLoginOfDay:Boolean;
      
      public function IsFirstLoginOfDayParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return false;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._isFirstLoginOfDay = param1.readBoolean();
         return true;
      }
      
      public function get isFirstLoginOfDay() : Boolean
      {
         return _isFirstLoginOfDay;
      }
   }
}

