package com.sulake.habbo.communication.messages.parser.quest.rewardtrack
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class RewardTrackTaskData
   {
      private var _id:String;
      
      private var _actionType:String;
      
      private var _parameter:String;
      
      private var _progressCount:int;
      
      private var _premium:Boolean;
      
      private var _taskRewards:Vector.<RewardTrackTaskLevelData>;
      
      public function RewardTrackTaskData(param1:IMessageDataWrapper)
      {
         var _loc3_:int = 0;
         super();
         _id = param1.readString();
         _actionType = param1.readString();
         _parameter = param1.readString();
         _progressCount = param1.readInteger();
         _premium = param1.readBoolean();
         _taskRewards = new Vector.<RewardTrackTaskLevelData>();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _taskRewards.push(new RewardTrackTaskLevelData(param1));
            _loc3_++;
         }
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get actionType() : String
      {
         return _actionType;
      }
      
      public function get parameter() : String
      {
         return _parameter;
      }
      
      public function get progressCount() : int
      {
         return _progressCount;
      }
      
      public function get premium() : Boolean
      {
         return _premium;
      }
      
      public function get taskRewards() : Vector.<RewardTrackTaskLevelData>
      {
         return _taskRewards;
      }
   }
}

