package com.sulake.habbo.communication.messages.parser.quest.rewardtrack
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RewardTrackProgressMessageParser implements IMessageParser
   {
      private var _trackId:String;
      
      private var _taskId:String;
      
      private var _progressCount:int;
      
      private var _points:int;
      
      public function RewardTrackProgressMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _trackId = null;
         _taskId = null;
         _progressCount = 0;
         _points = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _trackId = param1.readString();
         _taskId = param1.readString();
         _progressCount = param1.readInteger();
         _points = param1.readInteger();
         return true;
      }
      
      public function get trackId() : String
      {
         return _trackId;
      }
      
      public function get taskId() : String
      {
         return _taskId;
      }
      
      public function get progressCount() : int
      {
         return _progressCount;
      }
      
      public function get points() : int
      {
         return _points;
      }
   }
}

