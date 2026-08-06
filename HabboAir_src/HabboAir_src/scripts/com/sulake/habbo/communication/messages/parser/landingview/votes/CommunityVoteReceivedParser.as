package com.sulake.habbo.communication.messages.parser.landingview.votes
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CommunityVoteReceivedParser implements IMessageParser
   {
      private var _acknowledged:Boolean;
      
      public function CommunityVoteReceivedParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _acknowledged = param1.readBoolean();
         return true;
      }
      
      public function get acknowledged() : Boolean
      {
         return _acknowledged;
      }
   }
}

