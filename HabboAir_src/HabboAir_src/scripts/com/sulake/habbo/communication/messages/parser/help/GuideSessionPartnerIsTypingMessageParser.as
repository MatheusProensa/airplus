package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuideSessionPartnerIsTypingMessageParser implements IMessageParser
   {
      private var _isTyping:Boolean;
      
      public function GuideSessionPartnerIsTypingMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _isTyping = param1.readBoolean();
         return true;
      }
      
      public function get isTyping() : Boolean
      {
         return _isTyping;
      }
   }
}

