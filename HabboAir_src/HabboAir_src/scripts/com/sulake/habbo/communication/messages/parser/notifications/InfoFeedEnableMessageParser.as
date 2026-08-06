package com.sulake.habbo.communication.messages.parser.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class InfoFeedEnableMessageParser implements IMessageParser
   {
      private var _enabled:Boolean;
      
      public function InfoFeedEnableMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _enabled = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _enabled = param1.readBoolean();
         return true;
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
   }
}

