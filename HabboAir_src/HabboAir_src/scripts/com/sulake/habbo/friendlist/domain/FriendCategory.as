package com.sulake.habbo.friendlist.domain
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   
   public class FriendCategory implements IComponentInterfaceQueue
   {
      public static const PAGE_SIZE:int = 100;
      
      public static const CATID_ONLINE:int = 0;
      
      public static const CATID_OFFLINE:int = -1;
      
      private var _id:int;
      
      private var _name:String;
      
      private var _open:Boolean;
      
      private var UnknownVarFromFriendCategory_Map_1:Map = new Map();
      
      private var UnknownVarFromFriendCategory_Map_2:Map = null;
      
      private var _received:Boolean;
      
      private var _disposed:Boolean;
      
      private var _view:IWindowController_1;
      
      private var _pageIndex:int;
      
      private var _filter:String = "";
      
      public function FriendCategory(param1:int, param2:String)
      {
         super();
         _id = param1;
         _name = param2;
         _open = _id != -1;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         _view = null;
      }
      
      public function addFriend(param1:Friend) : void
      {
         removeFriend(param1.id);
         UnknownVarFromFriendCategory_Map_1.add(param1.id,param1);
         if(UnknownVarFromFriendCategory_Map_2 != null && acceptFilter(param1))
         {
            UnknownVarFromFriendCategory_Map_2.add(param1.id,param1);
         }
      }
      
      public function sort() : void
      {
         var _loc2_:Array = UnknownVarFromFriendCategory_Map_1.getValues();
         _loc2_.sortOn("name",1);
         UnknownVarFromFriendCategory_Map_1 = new Map();
         for each(var _loc1_ in _loc2_)
         {
            UnknownVarFromFriendCategory_Map_1.add(_loc1_.id,_loc1_);
         }
         updateFilteredFriends();
      }
      
      public function getSelectedFriends(param1:Array) : void
      {
         for each(var _loc2_ in UnknownVarFromFriendCategory_Map_1.getValues())
         {
            if(_loc2_.selected)
            {
               param1.push(_loc2_);
            }
         }
      }
      
      public function getFriendCount(param1:Boolean, param2:Boolean = false) : int
      {
         if(!param1 && !param2)
         {
            return UnknownVarFromFriendCategory_Map_1.length;
         }
         var _loc3_:int = 0;
         for each(var _loc4_ in UnknownVarFromFriendCategory_Map_1.getValues())
         {
            if((!param1 || _loc4_.online) && (!param2 || _loc4_.followingAllowed))
            {
               _loc3_ += 1;
            }
         }
         return _loc3_;
      }
      
      public function removeFriend(param1:int) : Friend
      {
         var _loc2_:Friend = UnknownVarFromFriendCategory_Map_1.remove(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         if(UnknownVarFromFriendCategory_Map_2 != null && acceptFilter(_loc2_))
         {
            UnknownVarFromFriendCategory_Map_2.remove(param1);
         }
         return _loc2_;
      }
      
      private function checkPageIndex() : void
      {
         if(this._pageIndex >= this.getPageCount())
         {
            this._pageIndex = Math.max(0,this.getPageCount() - 1);
         }
      }
      
      public function getPageCount() : int
      {
         return Math.ceil(filteredFriends.length / 100);
      }
      
      public function getStartFriendIndex() : int
      {
         checkPageIndex();
         return this._pageIndex * 100;
      }
      
      public function getEndFriendIndex() : int
      {
         checkPageIndex();
         return Math.min((this._pageIndex + 1) * 100,filteredFriends.length);
      }
      
      public function setOpen(param1:Boolean) : void
      {
         _open = param1;
         if(!param1)
         {
            for each(var _loc2_ in UnknownVarFromFriendCategory_Map_1.getValues())
            {
               _loc2_.selected = false;
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get received() : Boolean
      {
         return _received;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get friends() : Array
      {
         return UnknownVarFromFriendCategory_Map_1.getValues();
      }
      
      public function get view() : IWindowController_1
      {
         return _view;
      }
      
      public function get open() : Boolean
      {
         return _open;
      }
      
      public function get pageIndex() : int
      {
         return _pageIndex;
      }
      
      public function set id(param1:int) : void
      {
         _id = param1;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function set view(param1:IWindowController_1) : void
      {
         _view = param1;
      }
      
      public function set received(param1:Boolean) : void
      {
         _received = param1;
      }
      
      public function set pageIndex(param1:int) : void
      {
         _pageIndex = param1;
      }
      
      public function get filter() : String
      {
         return _filter;
      }
      
      public function set filter(param1:String) : void
      {
         if(param1 != _filter)
         {
            _filter = param1;
            updateFilteredFriends();
         }
      }
      
      private function acceptFilter(param1:Friend) : Boolean
      {
         return _filter.length == 0 || param1.name.toLowerCase().indexOf(_filter) != -1;
      }
      
      private function updateFilteredFriends() : void
      {
         if(UnknownVarFromFriendCategory_Map_1 == null)
         {
            return;
         }
         if(_filter.length == 0)
         {
            UnknownVarFromFriendCategory_Map_2 = null;
            return;
         }
         UnknownVarFromFriendCategory_Map_2 = new Map();
         for each(var _loc1_ in UnknownVarFromFriendCategory_Map_1.getValues())
         {
            if(acceptFilter(_loc1_))
            {
               UnknownVarFromFriendCategory_Map_2.add(_loc1_.id,_loc1_);
            }
         }
      }
      
      public function get filteredFriends() : Array
      {
         return UnknownVarFromFriendCategory_Map_2 == null ? UnknownVarFromFriendCategory_Map_1.getValues() : UnknownVarFromFriendCategory_Map_2.getValues();
      }
   }
}

