package com.sulake.habbo.communication.messages.parser.chatstyles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UserNftChatStylesMessageParser implements IMessageParser
   {
      private var _chatStyleIds:Vector.<int>;
      
      public function UserNftChatStylesMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _chatStyleIds = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _chatStyleIds = new Vector.<int>();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _chatStyleIds.push(param1.readInteger());
            _loc3_ += 1;
         }
         return true;
      }
      
      public function get chatStyleIds() : Vector.<int>
      {
         return _chatStyleIds;
      }
   }
}

