package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CustomUserNotificationMessageParser implements IMessageParser
   {
      private var _code:int = 0;
      
      public function CustomUserNotificationMessageParser()
      {
         super();
      }
      
      public function get code() : int
      {
         return _code;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _code = param1.readInteger();
         return true;
      }
   }
}

