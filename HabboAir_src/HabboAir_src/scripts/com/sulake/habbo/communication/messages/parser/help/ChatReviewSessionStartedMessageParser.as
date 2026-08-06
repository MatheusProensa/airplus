package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ChatReviewSessionStartedMessageParser implements IMessageParser
   {
      private var _votingTimeout:int;
      
      private var _chatRecord:String;
      
      public function ChatReviewSessionStartedMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _votingTimeout = -1;
         _chatRecord = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _votingTimeout = param1.readInteger();
         _chatRecord = param1.readString();
         return true;
      }
      
      public function get votingTimeout() : int
      {
         return _votingTimeout;
      }
      
      public function get chatRecord() : String
      {
         return _chatRecord;
      }
   }
}

