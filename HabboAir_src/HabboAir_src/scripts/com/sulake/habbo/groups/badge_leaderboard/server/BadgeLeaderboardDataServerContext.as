package com.sulake.habbo.groups.badge_leaderboard.server
{
   import com.sulake.habbo.communication.messages.incoming.users.BadgeLeaderboardEntryData;
   import flash.utils.Dictionary;
   
   public class BadgeLeaderboardDataServerContext
   {
      public var type:int;
      
      public var rarity:int;
      
      public var key:String;
      
      public var totalEntries:int = -1;
      
      public var ownEntry:BadgeLeaderboardEntryData;
      
      public var UnknownVarFromPNGDecoder_Array_1:Dictionary = new Dictionary();
      
      public var inFlightChunkIndices:Dictionary = new Dictionary();
      
      public function BadgeLeaderboardDataServerContext(param1:int, param2:int, param3:String)
      {
         super();
         this.type = param1;
         this.rarity = param2;
         this.key = param3;
      }
   }
}

