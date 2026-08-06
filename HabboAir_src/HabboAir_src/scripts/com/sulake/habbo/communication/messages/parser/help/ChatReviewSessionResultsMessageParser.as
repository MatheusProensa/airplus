package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ChatReviewSessionResultsMessageParser implements IMessageParser
   {
      private var _winningVoteCode:int;
      
      private var _ownVoteCode:int;
      
      private var _finalStatus:Array;
      
      public function ChatReviewSessionResultsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _winningVoteCode = -1;
         _ownVoteCode = -1;
         _finalStatus = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _winningVoteCode = param1.readInteger();
         _ownVoteCode = param1.readInteger();
         _finalStatus = [];
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _finalStatus.push(param1.readInteger());
            _loc3_++;
         }
         return true;
      }
      
      public function get winningVoteCode() : int
      {
         return _winningVoteCode;
      }
      
      public function get ownVoteCode() : int
      {
         return _ownVoteCode;
      }
      
      public function get finalStatus() : Array
      {
         return _finalStatus;
      }
   }
}

