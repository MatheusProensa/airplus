package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.users.BadgeLeaderboardEntryData;
   
   [SecureSWF(rename="true")]
   public class BadgeLeaderboardResultMessageParser implements IMessageParser
   {
      private var _type:int;
      
      private var _rarity:int;
      
      private var _page:int;
      
      private var _size:int;
      
      private var _totalEntries:int;
      
      private var _entries:Array;
      
      private var _ownEntry:BadgeLeaderboardEntryData;
      
      public function BadgeLeaderboardResultMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _type = 0;
         _rarity = -1;
         _page = 0;
         _size = 0;
         _totalEntries = 0;
         _entries = [];
         _ownEntry = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _type = param1.readInteger();
         _rarity = param1.readInteger();
         _page = param1.readInteger();
         _size = param1.readInteger();
         _totalEntries = param1.readInteger();
         _entries = [];
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _entries.push(new BadgeLeaderboardEntryData(param1));
            _loc3_++;
         }
         if(param1.readBoolean())
         {
            _ownEntry = new BadgeLeaderboardEntryData(param1);
         }
         return true;
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
      
      public function get size() : int
      {
         return _size;
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

