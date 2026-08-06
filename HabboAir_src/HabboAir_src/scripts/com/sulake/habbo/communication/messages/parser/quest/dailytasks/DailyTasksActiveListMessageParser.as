package com.sulake.habbo.communication.messages.parser.quest.dailytasks
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class DailyTasksActiveListMessageParser implements IMessageParser
   {
      private var _tasks:Vector.<DailyTaskInfo>;
      
      public function DailyTasksActiveListMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _tasks = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _tasks = new Vector.<DailyTaskInfo>();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _tasks.push(new DailyTaskInfo(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get tasks() : Vector.<DailyTaskInfo>
      {
         return _tasks;
      }
   }
}

