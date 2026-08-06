package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class IssueCloseNotificationMessageParser implements IMessageParser
   {
      private var _closeReason:int;
      
      private var _messageText:String;
      
      public function IssueCloseNotificationMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _closeReason = param1.readInteger();
         _messageText = param1.readString();
         return true;
      }
      
      public function get closeReason() : int
      {
         return _closeReason;
      }
      
      public function get messageText() : String
      {
         return _messageText;
      }
   }
}

