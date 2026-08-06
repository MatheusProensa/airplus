package com.sulake.habbo.communication.messages.parser.groupforums
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ForumThreadsMessageParser implements IMessageParser
   {
      private var _groupId:int;
      
      private var _startIndex:int;
      
      private var _amount:int;
      
      private var _threads:Array;
      
      public function ForumThreadsMessageParser()
      {
         super();
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get startIndex() : int
      {
         return _startIndex;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function get threads() : Array
      {
         return _threads;
      }
      
      public function flush() : Boolean
      {
         _groupId = -1;
         _startIndex = -1;
         _amount = -1;
         _threads = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         _groupId = param1.readInteger();
         _startIndex = param1.readInteger();
         _amount = param1.readInteger();
         _loc2_ = 0;
         while(_loc2_ < amount)
         {
            _threads.push(ThreadData.readFromMessage(param1));
            _loc2_++;
         }
         return true;
      }
   }
}

