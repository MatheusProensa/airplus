package com.sulake.habbo.friendbar.groupforums
{
   import com.sulake.habbo.communication.messages.parser.groupforums.MessageData;
   import flash.utils.Dictionary;
   
   public class MessagesListData
   {
      private var _threadId:int;
      
      private var _startIndex:int;
      
      private var _totalMessages:int;
      
      private var _messages:Array;
      
      private var _messagesById:Dictionary;
      
      public function MessagesListData(param1:int, param2:int, param3:int, param4:Array)
      {
         var _loc5_:int = 0;
         var _loc6_:MessageData = null;
         super();
         _threadId = param1;
         _startIndex = param3;
         _totalMessages = param2;
         _messages = param4;
         _messagesById = new Dictionary();
         _loc5_ = 0;
         while(_loc5_ < param4.length)
         {
            _loc6_ = param4[_loc5_];
            _messagesById[_loc6_.messageId] = _loc6_;
            _loc5_++;
         }
      }
      
      public function get threadId() : int
      {
         return _threadId;
      }
      
      public function get startIndex() : int
      {
         return _startIndex;
      }
      
      public function get totalMessages() : int
      {
         return _totalMessages;
      }
      
      public function get messages() : Array
      {
         return _messages;
      }
      
      public function get messagesById() : Dictionary
      {
         return _messagesById;
      }
      
      public function get size() : int
      {
         return _messages.length;
      }
   }
}

