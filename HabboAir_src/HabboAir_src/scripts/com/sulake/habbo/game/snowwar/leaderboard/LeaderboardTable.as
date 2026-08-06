package com.sulake.habbo.game.snowwar.leaderboard
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.game.score.Game2GetFriendsLeaderboardComposer;
   import com.sulake.habbo.communication.messages.parser.game.score.LeaderboardEntry;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   
   public class LeaderboardTable
   {
      public static const SCROLL_DOWN:int = 0;
      
      public static const SCROLL_UP:int = 1;
      
      protected var UnknownVarFromLeaderboardTable_SnowWarEngine_1:SnowWarEngine;
      
      protected var UnknownVarFromLeaderboardTable_Boolean_1:Boolean;
      
      protected var UnknownVarFromLeaderboardTable_Int_1:int;
      
      protected var _favouriteGroupId:int = -1;
      
      protected var _disposed:Boolean;
      
      protected var _entries:Array;
      
      protected var UnknownVarFromLeaderboardTable_Int_2:int = -1;
      
      protected var UnknownVarFromLeaderboardTable_Int_3:int;
      
      protected var _viewSize:int = 8;
      
      protected var UnknownVarFromLeaderboardTable_Int_4:int = 50;
      
      protected var UnknownVarFromLeaderboardTable_Boolean_2:Boolean = true;
      
      protected var UnknownVarFromLeaderboardTable_Int_5:int;
      
      public function LeaderboardTable(param1:SnowWarEngine)
      {
         super();
         UnknownVarFromLeaderboardTable_SnowWarEngine_1 = param1;
         UnknownVarFromLeaderboardTable_Int_1 = UnknownVarFromLeaderboardTable_SnowWarEngine_1.sessionDataManager.userId;
         _viewSize = UnknownVarFromLeaderboardTable_SnowWarEngine_1.config.getInteger("games.highscores.viewSize",8);
         UnknownVarFromLeaderboardTable_Int_4 = UnknownVarFromLeaderboardTable_SnowWarEngine_1.config.getInteger("games.highscores.windowSize",50);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         disposeTable();
         UnknownVarFromLeaderboardTable_SnowWarEngine_1 = null;
         _entries = null;
         _disposed = true;
      }
      
      public function disposeTable() : void
      {
         UnknownVarFromLeaderboardTable_Int_2 = -1;
         _entries = null;
         UnknownVarFromLeaderboardTable_Int_3 = -1;
         UnknownVarFromLeaderboardTable_Boolean_2 = true;
      }
      
      public function addEntries(param1:Array, param2:int) : void
      {
         UnknownVarFromLeaderboardTable_Int_3 = param2;
         if(!_entries)
         {
            _entries = param1;
            initializeList();
         }
         else
         {
            _entries = param1;
            updateCurrentIndex();
         }
         UnknownVarFromLeaderboardTable_Boolean_2 = false;
      }
      
      public function addGroupEntries(param1:Array, param2:int, param3:int) : void
      {
         _favouriteGroupId = param3;
         UnknownVarFromLeaderboardTable_Int_3 = param2;
         if(!_entries)
         {
            _entries = param1;
            initializeList();
         }
         else
         {
            _entries = param1;
            updateCurrentIndex();
         }
         UnknownVarFromLeaderboardTable_Boolean_2 = false;
      }
      
      protected function initializeList() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = false;
         var _loc2_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < _entries.length)
         {
            _loc1_ = (_entries[_loc3_] as LeaderboardEntry).gender == "g";
            if(!_loc1_ && (_entries[_loc3_] as LeaderboardEntry).userId == UnknownVarFromLeaderboardTable_Int_1)
            {
               _loc2_ = _loc3_;
               break;
            }
            if(_loc1_ && (_entries[_loc3_] as LeaderboardEntry).userId == _favouriteGroupId)
            {
               _loc2_ = _loc3_;
               break;
            }
            _loc3_++;
         }
         if(_loc2_ >= _viewSize)
         {
            UnknownVarFromLeaderboardTable_Int_2 = _loc2_ - _viewSize / 2;
         }
         else
         {
            UnknownVarFromLeaderboardTable_Int_2 = 0;
         }
      }
      
      private function updateCurrentIndex() : void
      {
         if(UnknownVarFromLeaderboardTable_Int_2 < 0)
         {
            UnknownVarFromLeaderboardTable_Int_2 += UnknownVarFromLeaderboardTable_Int_4;
         }
         else
         {
            UnknownVarFromLeaderboardTable_Int_2 -= UnknownVarFromLeaderboardTable_Int_4;
         }
      }
      
      public function isInitialized() : Boolean
      {
         return _entries != null;
      }
      
      public function scrollUp() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:IMessageComposer = null;
         if(UnknownVarFromLeaderboardTable_Boolean_2)
         {
            return false;
         }
         UnknownVarFromLeaderboardTable_Int_2 -= _viewSize;
         if(UnknownVarFromLeaderboardTable_Int_2 < 0)
         {
            if(_entries[0].rank > 1)
            {
               _loc2_ = Math.max(1,_entries[0].rank - UnknownVarFromLeaderboardTable_Int_4);
               _loc1_ = getMessageComposer(UnknownVarFromLeaderboardTable_Int_5,_loc2_,1);
               UnknownVarFromLeaderboardTable_SnowWarEngine_1.communication.connection.send(_loc1_);
               UnknownVarFromLeaderboardTable_Boolean_2 = true;
               return false;
            }
            UnknownVarFromLeaderboardTable_Int_2 = 0;
         }
         return true;
      }
      
      protected function getMessageComposer(param1:int, param2:int, param3:int) : IMessageComposer
      {
         return new Game2GetFriendsLeaderboardComposer(param1,param2,param3,_viewSize,UnknownVarFromLeaderboardTable_Int_4);
      }
      
      public function scrollDown() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:IMessageComposer = null;
         if(UnknownVarFromLeaderboardTable_Boolean_2)
         {
            return false;
         }
         UnknownVarFromLeaderboardTable_Int_2 += _viewSize;
         if(UnknownVarFromLeaderboardTable_Int_2 + _viewSize >= _entries.length)
         {
            if(_entries[_entries.length - 1].rank < UnknownVarFromLeaderboardTable_Int_3)
            {
               _loc2_ = _entries[_entries.length - 1].rank + 1;
               _loc1_ = getMessageComposer(UnknownVarFromLeaderboardTable_Int_5,_loc2_,0);
               UnknownVarFromLeaderboardTable_SnowWarEngine_1.communication.connection.send(_loc1_);
               UnknownVarFromLeaderboardTable_Boolean_2 = true;
               return false;
            }
         }
         return true;
      }
      
      public function revertToDefaultView(param1:int) : void
      {
         disposeTable();
         var _loc2_:IMessageComposer = getMessageComposer(param1,-1,0);
         UnknownVarFromLeaderboardTable_SnowWarEngine_1.communication.connection.send(_loc2_);
         UnknownVarFromLeaderboardTable_Boolean_2 = true;
         UnknownVarFromLeaderboardTable_Int_5 = param1;
      }
      
      public function getVisibleEntries() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         if(!_entries)
         {
            return _loc1_;
         }
         var _loc3_:int = Math.min(_entries.length,UnknownVarFromLeaderboardTable_Int_2 + _viewSize);
         _loc2_ = UnknownVarFromLeaderboardTable_Int_2;
         while(_loc2_ < _loc3_)
         {
            _loc1_.push(_entries[_loc2_]);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function canScrollUp() : Boolean
      {
         if(UnknownVarFromLeaderboardTable_Boolean_2 || !_entries || _entries.length == 0)
         {
            return false;
         }
         if(_entries[0].rank == 1 && UnknownVarFromLeaderboardTable_Int_2 <= 0)
         {
            return false;
         }
         return true;
      }
      
      public function canScrollDown() : Boolean
      {
         if(UnknownVarFromLeaderboardTable_Boolean_2 || !_entries || _entries.length == 0)
         {
            return false;
         }
         if(_entries[_entries.length - 1].rank >= UnknownVarFromLeaderboardTable_Int_3 && UnknownVarFromLeaderboardTable_Int_2 + _viewSize >= _entries.length)
         {
            return false;
         }
         return true;
      }
      
      public function get viewSize() : int
      {
         return _viewSize;
      }
      
      public function get favouriteGroupId() : int
      {
         return _favouriteGroupId;
      }
   }
}

