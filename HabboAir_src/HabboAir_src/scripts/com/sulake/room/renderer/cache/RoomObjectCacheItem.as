package com.sulake.room.renderer.cache
{
   [SecureSWF(rename="true")]
   public class RoomObjectCacheItem
   {
      private var _objectId:int;
      
      private var _location:RoomObjectLocationCacheItem = null;
      
      private var _sprites:RoomObjectSortableSpriteCacheItem = null;
      
      public function RoomObjectCacheItem(param1:String)
      {
         super();
         _location = new RoomObjectLocationCacheItem(param1);
         _sprites = new RoomObjectSortableSpriteCacheItem();
      }
      
      public function get location() : RoomObjectLocationCacheItem
      {
         return _location;
      }
      
      public function get sprites() : RoomObjectSortableSpriteCacheItem
      {
         return _sprites;
      }
      
      public function dispose() : void
      {
         if(_location != null)
         {
            _location.dispose();
            _location = null;
         }
         if(_sprites != null)
         {
            _sprites.dispose();
            _sprites = null;
         }
      }
      
      public function set objectId(param1:int) : void
      {
         _objectId = param1;
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
   }
}

