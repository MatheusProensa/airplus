package com.sulake.habbo.communication.messages.parser.room.action
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class SleepMessageParser implements IMessageParser
   {
      private var _userId:int = 0;
      
      private var _sleeping:Boolean = false;
      
      public function SleepMessageParser()
      {
         super();
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get sleeping() : Boolean
      {
         return _sleeping;
      }
      
      public function flush() : Boolean
      {
         _userId = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _userId = param1.readInteger();
         _sleeping = param1.readBoolean();
         return true;
      }
   }
}

