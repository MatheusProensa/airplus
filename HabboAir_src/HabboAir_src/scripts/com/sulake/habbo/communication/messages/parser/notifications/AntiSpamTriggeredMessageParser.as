package com.sulake.habbo.communication.messages.parser.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class AntiSpamTriggeredMessageParser implements IMessageParser
   {
      private var _triggeringMessageId:int = 0;
      
      public function AntiSpamTriggeredMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _triggeringMessageId = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _triggeringMessageId = param1.readInteger();
         return true;
      }
      
      public function get triggeringMessageId() : int
      {
         return _triggeringMessageId;
      }
   }
}

