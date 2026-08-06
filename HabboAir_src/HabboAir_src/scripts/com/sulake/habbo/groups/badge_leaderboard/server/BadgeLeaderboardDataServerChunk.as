package com.sulake.habbo.groups.badge_leaderboard.server
{
   import com.sulake.habbo.communication.messages.incoming.users.BadgeLeaderboardEntryData;
   
   public class BadgeLeaderboardDataServerChunk
   {
      public var UnknownVarFromBadgeLeaderboardResolvedPage_Int_1:int;
      
      public var totalEntries:int;
      
      public var entries:Array;
      
      public var ownEntry:BadgeLeaderboardEntryData;
      
      public var lastSynchronizedAt:int;
      
      public function BadgeLeaderboardDataServerChunk(param1:int, param2:int, param3:Array, param4:BadgeLeaderboardEntryData, param5:int)
      {
         super();
         this.UnknownVarFromBadgeLeaderboardResolvedPage_Int_1 = param1;
         this.totalEntries = param2;
         this.entries = param3 == null ? [] : param3;
         this.ownEntry = param4;
         this.lastSynchronizedAt = param5;
      }
   }
}

