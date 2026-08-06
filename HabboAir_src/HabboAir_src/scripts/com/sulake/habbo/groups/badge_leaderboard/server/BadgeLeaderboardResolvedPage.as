package com.sulake.habbo.groups.badge_leaderboard.server
{
   import com.sulake.habbo.groups.badge_leaderboard.BadgeLeaderboardPageData;
   
   public class BadgeLeaderboardResolvedPage
   {
      public var data:BadgeLeaderboardPageData;
      
      public var UnknownVarFromBadgeLeaderboardResolvedPage_Int_1:int;
      
      public var chunkSyncTime:int;
      
      public var isStale:Boolean;
      
      public function BadgeLeaderboardResolvedPage(param1:BadgeLeaderboardPageData, param2:int, param3:int, param4:Boolean)
      {
         super();
         this.data = param1;
         this.UnknownVarFromBadgeLeaderboardResolvedPage_Int_1 = param2;
         this.chunkSyncTime = param3;
         this.isStale = param4;
      }
   }
}

