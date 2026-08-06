package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ChatReviewSessionVotingStatusMessageParser implements IMessageParser
   {
      public static const UnknownConstFromChatReviewSessionVotingStatusMessageParser_Int_1:int = 0;
      
      public static const UnknownConstFromChatReviewSessionVotingStatusMessageParser_Int_2:int = 1;
      
      public static const UnknownConstFromChatReviewSessionVotingStatusMessageParser_Int_3:int = 2;
      
      public static const UnknownConstFromChatReviewSessionVotingStatusMessageParser_Int_4:int = 3;
      
      public static const UnknownConstFromChatReviewSessionVotingStatusMessageParser_Int_5:int = 4;
      
      public static const UnknownConstFromChatReviewSessionVotingStatusMessageParser_Int_6:int = 5;
      
      private var _status:Array;
      
      public function ChatReviewSessionVotingStatusMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _status = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _status = [];
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _status.push(param1.readInteger());
            _loc3_++;
         }
         return true;
      }
      
      public function get status() : Array
      {
         return _status;
      }
   }
}

