package com.sulake.habbo.communication.messages.parser.room.bots
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BotErrorParser implements IMessageParser
   {
      private var _errorCode:int;
      
      public function BotErrorParser()
      {
         super();
      }
      
      public function get errorCode() : int
      {
         return _errorCode;
      }
      
      public function flush() : Boolean
      {
         _errorCode = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _errorCode = param1.readInteger();
         return true;
      }
   }
}

