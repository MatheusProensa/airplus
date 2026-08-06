package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class IssueDeletedMessageParser implements IMessageParser
   {
      private var _issueId:int;
      
      public function IssueDeletedMessageParser()
      {
         super();
      }
      
      public function get issueId() : int
      {
         return _issueId;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _issueId = parseInt(param1.readString());
         return true;
      }
   }
}

