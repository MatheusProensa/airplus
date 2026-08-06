package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RespectNotificationMessageParser implements IMessageParser
   {
      private var _userId:int = 0;
      
      private var _respectTotal:int = 0;
      
      public function RespectNotificationMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _userId = param1.readInteger();
         _respectTotal = param1.readInteger();
         return true;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get respectTotal() : int
      {
         return _respectTotal;
      }
   }
}

