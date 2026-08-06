package com.sulake.habbo.groups.badge_leaderboard
{
   import com.sulake.habbo.communication.messages.incoming.users.BadgeLeaderboardEntryData;
   
   public class BadgeLeaderboardPageData
   {
      private var _type:int;
      
      private var _rarity:int;
      
      private var _page:int;
      
      private var _totalEntries:int;
      
      private var _entries:Array;
      
      private var _ownEntry:BadgeLeaderboardEntryData;
      
      public function BadgeLeaderboardPageData(param1:int, param2:int, param3:int, param4:int, param5:Array, param6:BadgeLeaderboardEntryData)
      {
         super();
         _type = param1;
         _rarity = param2;
         _page = param3;
         _totalEntries = param4;
         _entries = param5 == null ? [] : param5.concat();
         _ownEntry = param6;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get rarity() : int
      {
         return _rarity;
      }
      
      public function get page() : int
      {
         return _page;
      }
      
      public function get totalEntries() : int
      {
         return _totalEntries;
      }
      
      public function get entries() : Array
      {
         return _entries;
      }
      
      public function get ownEntry() : BadgeLeaderboardEntryData
      {
         return _ownEntry;
      }
   }
}

