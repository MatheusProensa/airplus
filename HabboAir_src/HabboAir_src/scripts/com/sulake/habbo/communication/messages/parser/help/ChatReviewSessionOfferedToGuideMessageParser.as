package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ChatReviewSessionOfferedToGuideMessageParser implements IMessageParser
   {
      private var _acceptanceTimeout:int;
      
      public function ChatReviewSessionOfferedToGuideMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _acceptanceTimeout = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _acceptanceTimeout = param1.readInteger();
         return true;
      }
      
      public function get acceptanceTimeout() : int
      {
         return _acceptanceTimeout;
      }
   }
}

