package com.sulake.habbo.ui.widget.roomtools
{
   public class RoomVisitHistory
   {
      private static const MAX_HISTORY_LENGTH:int = 20;
      
      private static const _shared:RoomVisitHistory = new RoomVisitHistory();
      
      private var _history:Vector.<RoomVisitHistoryEntry> = new Vector.<RoomVisitHistoryEntry>();
      
      private var _currentIndex:int = -1;
      
      public function RoomVisitHistory()
      {
         super();
      }
      
      public static function get shared() : RoomVisitHistory
      {
         return _shared;
      }
      
      public function get currentIndex() : int
      {
         return _currentIndex;
      }
      
      public function get length() : int
      {
         return _history.length;
      }
      
      public function get currentRoom() : RoomVisitHistoryEntry
      {
         if(_currentIndex < 0 || _currentIndex >= _history.length)
         {
            return null;
         }
         return _history[_currentIndex];
      }
      
      public function canGoBack() : Boolean
      {
         return _currentIndex > 0 && _history.length > 0;
      }
      
      public function canGoForward() : Boolean
      {
         return _currentIndex >= 0 && _currentIndex < _history.length - 1;
      }
      
      public function goBack() : RoomVisitHistoryEntry
      {
         if(!canGoBack())
         {
            return null;
         }
         _currentIndex--;
         return _history[_currentIndex];
      }
      
      public function goForward() : RoomVisitHistoryEntry
      {
         if(!canGoForward())
         {
            return null;
         }
         _currentIndex++;
         return _history[_currentIndex];
      }
      
      public function updateRoomName(param1:int, param2:String) : void
      {
         for each(var _loc3_ in _history)
         {
            if(_loc3_.flatId == param1)
            {
               _loc3_.roomName = param2;
            }
         }
      }
      
      public function onRoomEntered(param1:int, param2:String) : void
      {
         updateRoomName(param1,param2);
         if(_history.length == 0)
         {
            appendEntry(param1,param2);
            return;
         }
         normalizeCurrentIndex();
         var _loc3_:RoomVisitHistoryEntry = currentRoom;
         if(_loc3_ != null && _loc3_.flatId == param1)
         {
            _loc3_.roomName = param2;
            return;
         }
         if(_currentIndex < _history.length - 1)
         {
            reverseSuffix(_currentIndex,_history.length - 1);
         }
         var _loc4_:RoomVisitHistoryEntry = _history.length > 0 ? _history[_history.length - 1] : null;
         if(_loc4_ != null && _loc4_.flatId == param1)
         {
            _loc4_.roomName = param2;
            _currentIndex = _history.length - 1;
            return;
         }
         appendEntry(param1,param2);
      }
      
      public function getRawHistory() : Vector.<RoomVisitHistoryEntry>
      {
         return copyEntries(_history);
      }
      
      public function getHistoryView() : Vector.<RoomVisitHistoryEntry>
      {
         var _loc3_:int = 0;
         var _loc2_:RoomVisitHistoryEntry = null;
         var _loc4_:String = null;
         var _loc1_:Vector.<RoomVisitHistoryEntry> = new Vector.<RoomVisitHistoryEntry>();
         var _loc5_:Object = {};
         _loc3_ = _history.length - 1;
         while(_loc3_ >= 0)
         {
            _loc2_ = _history[_loc3_];
            _loc4_ = String(_loc2_.flatId);
            if(!_loc5_[_loc4_])
            {
               _loc5_[_loc4_] = true;
               _loc1_.unshift(_loc2_.copy());
            }
            _loc3_--;
         }
         return _loc1_;
      }
      
      private function appendEntry(param1:int, param2:String) : void
      {
         _history.push(new RoomVisitHistoryEntry(param1,param2));
         _currentIndex = _history.length - 1;
         trimToMaxLength();
      }
      
      private function trimToMaxLength() : void
      {
         while(_history.length > 20)
         {
            _history.shift();
            _currentIndex--;
         }
         normalizeCurrentIndex();
      }
      
      private function normalizeCurrentIndex() : void
      {
         if(_history.length == 0)
         {
            _currentIndex = -1;
         }
         else if(_currentIndex < 0)
         {
            _currentIndex = 0;
         }
         else if(_currentIndex >= _history.length)
         {
            _currentIndex = _history.length - 1;
         }
      }
      
      private function reverseSuffix(param1:int, param2:int) : void
      {
         var _loc3_:RoomVisitHistoryEntry = null;
         if(_history.length == 0)
         {
            return;
         }
         param1 = Math.max(0,param1);
         param2 = Math.min(param2,_history.length - 1);
         while(param1 < param2)
         {
            _loc3_ = _history[param1];
            _history[param1] = _history[param2];
            _history[param2] = _loc3_;
            param1++;
            param2--;
         }
      }
      
      private function copyEntries(param1:Vector.<RoomVisitHistoryEntry>) : Vector.<RoomVisitHistoryEntry>
      {
         var _loc2_:Vector.<RoomVisitHistoryEntry> = new Vector.<RoomVisitHistoryEntry>();
         for each(var _loc3_ in param1)
         {
            _loc2_.push(_loc3_.copy());
         }
         return _loc2_;
      }
   }
}

