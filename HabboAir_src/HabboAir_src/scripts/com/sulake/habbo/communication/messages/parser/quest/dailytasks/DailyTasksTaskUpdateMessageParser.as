package com.sulake.habbo.communication.messages.parser.quest.dailytasks
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class DailyTasksTaskUpdateMessageParser implements IMessageParser
   {
      private var _taskId:Number;
      
      private var _repeats:int;
      
      private var _status:int;
      
      private var _secondsLeft:int;
      
      public function DailyTasksTaskUpdateMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _taskId = 0;
         _repeats = 0;
         _status = 0;
         _secondsLeft = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _taskId = param1.readLong();
         _repeats = param1.readInteger();
         _status = param1.readByte();
         _secondsLeft = param1.readInteger();
         return true;
      }
      
      public function get taskId() : Number
      {
         return _taskId;
      }
      
      public function get repeats() : int
      {
         return _repeats;
      }
      
      public function get status() : int
      {
         return _status;
      }
      
      public function get secondsLeft() : int
      {
         return _secondsLeft;
      }
   }
}

