package com.sulake.habbo.communication.messages.parser.room.chat
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FloodControlMessageParser implements IMessageParser
   {
      private var _seconds:int = 0;
      
      public function FloodControlMessageParser()
      {
         super();
      }
      
      public function get seconds() : int
      {
         return _seconds;
      }
      
      public function flush() : Boolean
      {
         _seconds = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _seconds = param1.readInteger();
         return true;
      }
   }
}

