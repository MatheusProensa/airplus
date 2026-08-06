package com.sulake.room.renderer.cache
{
   import com.sulake.room.renderer.utils.SortableSprite;
   
   [SecureSWF(rename="true")]
   public class RoomObjectSortableSpriteCacheItem
   {
      private var _sprites:Array = [];
      
      private var _updateId1:int = -1;
      
      private var _updateId2:int = -1;
      
      private var _isEmpty:Boolean = false;
      
      public function RoomObjectSortableSpriteCacheItem()
      {
         super();
      }
      
      public function get spriteCount() : int
      {
         return _sprites.length;
      }
      
      public function get isEmpty() : Boolean
      {
         return _isEmpty;
      }
      
      public function dispose() : void
      {
         setSpriteCount(0);
      }
      
      public function addSprite(param1:SortableSprite) : void
      {
         _sprites.push(param1);
      }
      
      public function getSprite(param1:int) : SortableSprite
      {
         return _sprites[param1];
      }
      
      public function get sprites() : Array
      {
         return _sprites;
      }
      
      public function needsUpdate(param1:int, param2:int) : Boolean
      {
         if(param1 != _updateId1 || param2 != _updateId2)
         {
            _updateId1 = param1;
            _updateId2 = param2;
            return true;
         }
         return false;
      }
      
      public function setSpriteCount(param1:int) : void
      {
         var _loc3_:* = 0;
         var _loc2_:SortableSprite = null;
         if(param1 < _sprites.length)
         {
            _loc3_ = param1;
            while(_loc3_ < _sprites.length)
            {
               _loc2_ = _sprites[_loc3_];
               if(_loc2_)
               {
                  _loc2_.dispose();
               }
               _loc3_++;
            }
            _sprites.splice(param1,_sprites.length - param1);
         }
         if(_sprites.length == 0)
         {
            _isEmpty = true;
         }
         else
         {
            _isEmpty = false;
         }
      }
   }
}

