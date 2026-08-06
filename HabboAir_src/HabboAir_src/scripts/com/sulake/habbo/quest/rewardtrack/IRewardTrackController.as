package com.sulake.habbo.quest.rewardtrack
{
   public interface IRewardTrackController
   {
      function openRewardTrack(param1:String) : void;
      
      function hasRewardTrack(param1:String) : Boolean;
      
      function isRewardTrackComplete(param1:String) : Boolean;
   }
}

