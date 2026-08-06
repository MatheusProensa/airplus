package com.sulake.habbo.communication.messages.parser.quest.rewardtrack
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class RewardTrackData
   {
      private var _id:String;
      
      private var _theme:String;
      
      private var _points:int;
      
      private var _hasPremiumConfig:Boolean;
      
      private var _taskPointsBoost:Number;
      
      private var _instantPoints:int;
      
      private var _costDiamonds:int;
      
      private var _costCredits:int;
      
      private var _premium:Boolean;
      
      private var _complete:Boolean;
      
      private var _premiumComplete:Boolean;
      
      private var _tasks:Vector.<RewardTrackTaskData>;
      
      private var _prizes:Vector.<RewardTrackPrizeData>;
      
      public function RewardTrackData(param1:IMessageDataWrapper)
      {
         var _loc4_:int = 0;
         super();
         _id = param1.readString();
         _theme = param1.readString();
         _points = param1.readInteger();
         _hasPremiumConfig = param1.readBoolean();
         if(_hasPremiumConfig)
         {
            _taskPointsBoost = param1.readDouble();
            _instantPoints = param1.readInteger();
            _costDiamonds = param1.readInteger();
            _costCredits = param1.readInteger();
         }
         _premium = param1.readBoolean();
         _complete = param1.readBoolean();
         _premiumComplete = param1.readBoolean();
         _tasks = new Vector.<RewardTrackTaskData>();
         var _loc2_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _tasks.push(new RewardTrackTaskData(param1));
            _loc4_++;
         }
         _prizes = new Vector.<RewardTrackPrizeData>();
         var _loc3_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _prizes.push(new RewardTrackPrizeData(param1));
            _loc4_++;
         }
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get theme() : String
      {
         return _theme;
      }
      
      public function get points() : int
      {
         return _points;
      }
      
      public function get hasPremiumConfig() : Boolean
      {
         return _hasPremiumConfig;
      }
      
      public function get taskPointsBoost() : Number
      {
         return _taskPointsBoost;
      }
      
      public function get instantPoints() : int
      {
         return _instantPoints;
      }
      
      public function get costDiamonds() : int
      {
         return _costDiamonds;
      }
      
      public function get costCredits() : int
      {
         return _costCredits;
      }
      
      public function get premium() : Boolean
      {
         return _premium;
      }
      
      public function get complete() : Boolean
      {
         return _complete;
      }
      
      public function get premiumComplete() : Boolean
      {
         return _premiumComplete;
      }
      
      public function get tasks() : Vector.<RewardTrackTaskData>
      {
         return _tasks;
      }
      
      public function get prizes() : Vector.<RewardTrackPrizeData>
      {
         return _prizes;
      }
   }
}

