package com.sulake.habbo.communication.messages.parser.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class HabboActivityPointNotificationMessageParser implements IMessageParser
   {
      private var _amount:int = 0;
      
      private var _change:int = 0;
      
      private var _type:int;
      
      public function HabboActivityPointNotificationMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _amount = param1.readInteger();
         _change = param1.readInteger();
         _type = param1.readInteger();
         return true;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function get change() : int
      {
         return _change;
      }
      
      public function get type() : int
      {
         return _type;
      }
   }
}

