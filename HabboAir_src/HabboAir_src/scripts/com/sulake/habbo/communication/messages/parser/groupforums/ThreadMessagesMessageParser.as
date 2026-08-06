package com.sulake.habbo.communication.messages.parser.groupforums
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ThreadMessagesMessageParser implements IMessageParser
   {
      private var _groupId:int;
      
      private var _threadId:int;
      
      private var _startIndex:int;
      
      private var _amount:int;
      
      private var _messages:Array;
      
      public function ThreadMessagesMessageParser()
      {
         super();
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get threadId() : int
      {
         return _threadId;
      }
      
      public function get startIndex() : int
      {
         return _startIndex;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function get messages() : Array
      {
         return _messages;
      }
      
      public function flush() : Boolean
      {
         _groupId = -1;
         _threadId = -1;
         _startIndex = -1;
         _amount = -1;
         _messages = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:MessageData = null;
         _groupId = param1.readInteger();
         _threadId = param1.readInteger();
         _startIndex = param1.readInteger();
         _amount = param1.readInteger();
         _loc2_ = 0;
         while(_loc2_ < _amount)
         {
            _loc3_ = MessageData.readFromMessage(param1);
            _loc3_.groupID = _groupId;
            _loc3_.threadId = _threadId;
            _messages.push(_loc3_);
            _loc2_++;
         }
         return true;
      }
   }
}

