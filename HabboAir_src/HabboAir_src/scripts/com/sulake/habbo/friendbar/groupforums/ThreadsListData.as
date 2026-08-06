package com.sulake.habbo.friendbar.groupforums
{
   import com.sulake.habbo.communication.messages.parser.groupforums.ThreadData;
   import flash.utils.Dictionary;
   
   public class ThreadsListData
   {
      public static const PAGE_SIZE:int = 20;
      
      private var _totalThreads:int;
      
      private var _startIndex:int;
      
      private var _threads:Array;
      
      private var _threadsById:Dictionary;
      
      public function ThreadsListData(param1:int, param2:int, param3:Array)
      {
         var _loc4_:int = 0;
         var _loc5_:ThreadData = null;
         super();
         _totalThreads = param1;
         _startIndex = param2;
         _threads = param3;
         _threadsById = new Dictionary();
         _loc4_ = 0;
         while(_loc4_ < param3.length)
         {
            _loc5_ = param3[_loc4_];
            _threadsById[_loc5_.threadId] = _loc5_;
            _loc4_++;
         }
      }
      
      public function get totalThreads() : int
      {
         return _totalThreads;
      }
      
      public function get startIndex() : int
      {
         return _startIndex;
      }
      
      public function get threads() : Array
      {
         return _threads;
      }
      
      public function get threadsById() : Dictionary
      {
         return _threadsById;
      }
      
      public function get size() : int
      {
         return _threads.length;
      }
      
      public function updateThread(param1:ThreadData) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:ThreadData = null;
         threadsById[param1.threadId] = param1;
         _loc3_ = 0;
         while(_loc3_ < threads.length)
         {
            _loc2_ = threads[_loc3_];
            if(_loc2_.threadId == param1.threadId)
            {
               threads[_loc3_] = param1;
               return true;
            }
            _loc3_++;
         }
         return false;
      }
   }
}

