package com.sulake.habbo.groups.badge_leaderboard.server
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.communication.messages.incoming.users.BadgeLeaderboardEntryData;
   import com.sulake.habbo.communication.messages.outgoing.users.GetBadgeLeaderboardMessageComposer;
   import com.sulake.habbo.communication.messages.parser.users.BadgeLeaderboardResultMessageParser;
   import com.sulake.habbo.groups.badge_leaderboard.*;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class BadgeLeaderboardDataServer implements IComponentInterfaceQueue
   {
      public static const PAGE_SIZE:int = 10;
      
      private static const UnknownConstFromBadgeLeaderboardDataServer_Int_1:int = 50;
      
      private static const PAGES_PER_FETCH:int = 5;
      
      private static const STALE_AFTER_MS:int = 60000;
      
      private static const PREFETCH_BOUNDARY_DISTANCE:int = 1;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromBadgeLeaderboardDataServer_Function_1:Function;
      
      private var UnknownVarFromBadgeLeaderboardDataServer_Dictionary_1:Dictionary;
      
      private var _activeContextKey:String;
      
      private var UnknownVarFromBadgeLeaderboardDataServer_Int_1:int;
      
      private var _activeCallback:Function;
      
      private var UnknownVarFromBadgeLeaderboardDataServer_Int_2:int;
      
      private var _activeDeliveredChunkSyncTime:int = -1;
      
      private var UnknownVarFromBadgeLeaderboardDataServer_Int_3:int = -1;
      
      public function BadgeLeaderboardDataServer(param1:Function)
      {
         super();
         UnknownVarFromBadgeLeaderboardDataServer_Function_1 = param1;
         UnknownVarFromBadgeLeaderboardDataServer_Dictionary_1 = new Dictionary();
      }
      
      public function requestPage(param1:int, param2:int, param3:int, param4:Function) : void
      {
         var _loc5_:BadgeLeaderboardDataServerContext = null;
         var _loc6_:BadgeLeaderboardResolvedPage = null;
         var _loc7_:int = 0;
         if(_disposed)
         {
            return;
         }
         if(param3 < 0)
         {
            param3 = 0;
         }
         _loc5_ = getContext(param1,param2);
         _activeContextKey = _loc5_.key;
         UnknownVarFromBadgeLeaderboardDataServer_Int_1 = param3;
         _activeCallback = param4;
         UnknownVarFromBadgeLeaderboardDataServer_Int_2++;
         _activeDeliveredChunkSyncTime = -1;
         UnknownVarFromBadgeLeaderboardDataServer_Int_3 = -1;
         _loc6_ = resolvePage(_loc5_,param3);
         if(_loc6_ != null)
         {
            deliverPage(_loc6_);
            if(_loc6_.isStale)
            {
               synchronizeChunk(_loc5_,_loc6_.UnknownVarFromBadgeLeaderboardResolvedPage_Int_1);
            }
         }
         else
         {
            _loc7_ = getChunkIndex(param3);
            if(canChunkExist(_loc5_,_loc7_))
            {
               synchronizeChunk(_loc5_,_loc7_);
            }
            else
            {
               deliverPage(new BadgeLeaderboardResolvedPage(new BadgeLeaderboardPageData(param1,param2,param3,_loc5_.totalEntries,[],_loc5_.ownEntry),_loc7_,-1,false));
            }
         }
         prefetchAroundPage(_loc5_,param3);
      }
      
      public function onBadgeLeaderboardResult(param1:BadgeLeaderboardResultMessageParser) : void
      {
         var _loc3_:BadgeLeaderboardDataServerContext = null;
         var _loc2_:int = 0;
         var _loc4_:BadgeLeaderboardDataServerChunk = null;
         if(_disposed || param1 == null || param1.size != 50)
         {
            return;
         }
         _loc3_ = getContext(param1.type,param1.rarity);
         _loc2_ = getTimer();
         _loc4_ = new BadgeLeaderboardDataServerChunk(param1.page,param1.totalEntries,param1.entries == null ? [] : param1.entries.concat(),param1.ownEntry,_loc2_);
         _loc3_.UnknownVarFromPNGDecoder_Array_1[_loc4_.UnknownVarFromBadgeLeaderboardResolvedPage_Int_1] = _loc4_;
         _loc3_.inFlightChunkIndices[_loc4_.UnknownVarFromBadgeLeaderboardResolvedPage_Int_1] = false;
         _loc3_.totalEntries = param1.totalEntries;
         _loc3_.ownEntry = param1.ownEntry;
         if(_activeContextKey == _loc3_.key)
         {
            deliverActivePageIfAvailable(_loc3_);
            prefetchAroundPage(_loc3_,UnknownVarFromBadgeLeaderboardDataServer_Int_1);
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         UnknownVarFromBadgeLeaderboardDataServer_Function_1 = null;
         UnknownVarFromBadgeLeaderboardDataServer_Dictionary_1 = null;
         _activeContextKey = null;
         _activeCallback = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function deliverActivePageIfAvailable(param1:BadgeLeaderboardDataServerContext) : void
      {
         var _loc2_:BadgeLeaderboardResolvedPage = resolvePage(param1,UnknownVarFromBadgeLeaderboardDataServer_Int_1);
         if(_loc2_ != null)
         {
            deliverPage(_loc2_);
         }
      }
      
      private function deliverPage(param1:BadgeLeaderboardResolvedPage) : void
      {
         if(_activeCallback == null || param1 == null || _disposed)
         {
            return;
         }
         if(param1.data.page != UnknownVarFromBadgeLeaderboardDataServer_Int_1 || getContextKey(param1.data.type,param1.data.rarity) != _activeContextKey)
         {
            return;
         }
         if(UnknownVarFromBadgeLeaderboardDataServer_Int_3 == UnknownVarFromBadgeLeaderboardDataServer_Int_2 && _activeDeliveredChunkSyncTime == param1.chunkSyncTime)
         {
            return;
         }
         UnknownVarFromBadgeLeaderboardDataServer_Int_3 = UnknownVarFromBadgeLeaderboardDataServer_Int_2;
         _activeDeliveredChunkSyncTime = param1.chunkSyncTime;
         _activeCallback(param1.data);
      }
      
      private function resolvePage(param1:BadgeLeaderboardDataServerContext, param2:int) : BadgeLeaderboardResolvedPage
      {
         var _loc9_:int = 0;
         var _loc6_:BadgeLeaderboardDataServerChunk = null;
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc10_:Array = null;
         var _loc7_:int = 0;
         var _loc11_:int = 0;
         var _loc4_:* = false;
         var _loc3_:BadgeLeaderboardEntryData = null;
         _loc9_ = getChunkIndex(param2);
         _loc6_ = param1.UnknownVarFromPNGDecoder_Array_1[_loc9_] as BadgeLeaderboardDataServerChunk;
         if(_loc6_ == null)
         {
            return null;
         }
         _loc5_ = param2 % 5;
         _loc8_ = _loc5_ * 10;
         _loc10_ = [];
         _loc11_ = Math.max(0,Math.min(10,_loc6_.entries.length - _loc8_));
         _loc7_ = 0;
         while(_loc7_ < _loc11_)
         {
            _loc10_.push(_loc6_.entries[_loc8_ + _loc7_]);
            _loc7_++;
         }
         _loc3_ = _loc6_.ownEntry ?? param1.ownEntry;
         _loc4_ = getTimer() - _loc6_.lastSynchronizedAt > 60000;
         return new BadgeLeaderboardResolvedPage(new BadgeLeaderboardPageData(param1.type,param1.rarity,param2,_loc6_.totalEntries,_loc10_,_loc3_),_loc9_,_loc6_.lastSynchronizedAt,_loc4_);
      }
      
      private function prefetchAroundPage(param1:BadgeLeaderboardDataServerContext, param2:int) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:BadgeLeaderboardDataServerChunk = null;
         _loc5_ = getChunkIndex(param2);
         _loc6_ = (_loc5_ + 1) * 5 - 1 - param2;
         if(_loc6_ > 1)
         {
            return;
         }
         _loc4_ = _loc5_ + 1;
         if(!canChunkExist(param1,_loc4_))
         {
            return;
         }
         _loc3_ = param1.UnknownVarFromPNGDecoder_Array_1[_loc4_] as BadgeLeaderboardDataServerChunk;
         if(_loc3_ == null || getTimer() - _loc3_.lastSynchronizedAt > 60000)
         {
            synchronizeChunk(param1,_loc4_);
         }
      }
      
      private function synchronizeChunk(param1:BadgeLeaderboardDataServerContext, param2:int) : void
      {
         if(_disposed || param1 == null || UnknownVarFromBadgeLeaderboardDataServer_Function_1 == null || !canChunkExist(param1,param2) || param1.inFlightChunkIndices[param2])
         {
            return;
         }
         param1.inFlightChunkIndices[param2] = true;
         UnknownVarFromBadgeLeaderboardDataServer_Function_1(new GetBadgeLeaderboardMessageComposer(param1.type,param1.rarity,param2,50));
      }
      
      private function canChunkExist(param1:BadgeLeaderboardDataServerContext, param2:int) : Boolean
      {
         if(param2 < 0)
         {
            return false;
         }
         if(param1.totalEntries < 0)
         {
            return true;
         }
         return param2 * 50 < param1.totalEntries;
      }
      
      private function getContext(param1:int, param2:int) : BadgeLeaderboardDataServerContext
      {
         var _loc4_:String = getContextKey(param1,param2);
         var _loc3_:BadgeLeaderboardDataServerContext = UnknownVarFromBadgeLeaderboardDataServer_Dictionary_1[_loc4_] as BadgeLeaderboardDataServerContext;
         if(_loc3_ == null)
         {
            _loc3_ = new BadgeLeaderboardDataServerContext(param1,param2,_loc4_);
            UnknownVarFromBadgeLeaderboardDataServer_Dictionary_1[_loc4_] = _loc3_;
         }
         return _loc3_;
      }
      
      private function getChunkIndex(param1:int) : int
      {
         return int(param1 / 5);
      }
      
      private function getContextKey(param1:int, param2:int) : String
      {
         return param1.toString() + ":" + param2.toString();
      }
   }
}

