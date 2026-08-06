package com.sulake.room.renderer.cache
{
   import com.sulake.core.utils.Map;
   import com.sulake.room.renderer.utils.ExtendedBitmapData;
   import flash.display.BitmapData;
   
   [SecureSWF(rename="true")]
   public class BitmapDataCache
   {
      private var UnknownVarFromBitmapDataCache_Map_1:Map;
      
      private var _memUsage:int = 0;
      
      private var _memLimit:int = 0;
      
      private var UnknownVarFromBitmapDataCache_Int_1:int = 0;
      
      private var UnknownVarFromBitmapDataCache_Int_2:int = 0;
      
      public function BitmapDataCache(param1:int, param2:int, param3:int = 1)
      {
         super();
         UnknownVarFromBitmapDataCache_Map_1 = new Map();
         _memLimit = param1 * 1024 * 1024;
         UnknownVarFromBitmapDataCache_Int_1 = param2 * 1024 * 1024;
         UnknownVarFromBitmapDataCache_Int_2 = param3 * 1024 * 1024;
         if(UnknownVarFromBitmapDataCache_Int_2 < 0)
         {
            UnknownVarFromBitmapDataCache_Int_2 = 0;
         }
      }
      
      public function get memUsage() : int
      {
         return _memUsage;
      }
      
      public function get memLimit() : int
      {
         return _memLimit;
      }
      
      public function dispose() : void
      {
         var _loc1_:Array = null;
         if(UnknownVarFromBitmapDataCache_Map_1 != null)
         {
            _loc1_ = UnknownVarFromBitmapDataCache_Map_1.getKeys();
            for each(var _loc2_ in _loc1_)
            {
               if(!removeItem(_loc2_))
               {
                  Logger.log("Failed to remove item " + _loc2_ + " from room canvas bitmap cache!");
               }
            }
            UnknownVarFromBitmapDataCache_Map_1.dispose();
            UnknownVarFromBitmapDataCache_Map_1 = null;
         }
      }
      
      public function compress() : void
      {
         var _loc1_:Array = null;
         var _loc2_:BitmapDataCacheItem = null;
         var _loc3_:int = 0;
         if(memUsage > memLimit)
         {
            _loc1_ = UnknownVarFromBitmapDataCache_Map_1.getValues();
            _loc1_.sortOn("useCount",16);
            _loc1_.reverse();
            _loc3_ = _loc1_.length - 1;
            while(_loc3_ >= 0)
            {
               _loc2_ = _loc1_[_loc3_] as BitmapDataCacheItem;
               if(_loc2_.useCount > 1)
               {
                  break;
               }
               removeItem(_loc2_.name);
               _loc3_--;
            }
            increaseMemoryLimit();
         }
      }
      
      private function increaseMemoryLimit() : void
      {
         _memLimit += UnknownVarFromBitmapDataCache_Int_2;
         if(_memLimit > UnknownVarFromBitmapDataCache_Int_1)
         {
            _memLimit = UnknownVarFromBitmapDataCache_Int_1;
         }
      }
      
      private function removeItem(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:BitmapDataCacheItem = UnknownVarFromBitmapDataCache_Map_1.getValue(param1) as BitmapDataCacheItem;
         if(_loc2_ != null)
         {
            if(_loc2_.useCount <= 1)
            {
               UnknownVarFromBitmapDataCache_Map_1.remove(_loc2_.name);
               _memUsage -= _loc2_.memUsage;
               _loc2_.dispose();
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function getBitmapData(param1:String) : ExtendedBitmapData
      {
         var _loc2_:BitmapDataCacheItem = UnknownVarFromBitmapDataCache_Map_1.getValue(param1) as BitmapDataCacheItem;
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:ExtendedBitmapData = _loc2_.bitmapData;
         if(_loc3_ != null && _loc3_.disposed)
         {
            UnknownVarFromBitmapDataCache_Map_1.remove(_loc2_.name);
            _memUsage -= _loc2_.memUsage;
            _loc2_.dispose();
            return null;
         }
         return _loc3_;
      }
      
      public function addBitmapData(param1:String, param2:ExtendedBitmapData) : void
      {
         var _loc4_:BitmapData = null;
         if(param2 == null || param2.width <= 0 || param2.height <= 0)
         {
            return;
         }
         if(param2.disposed)
         {
            return;
         }
         var _loc3_:BitmapDataCacheItem = UnknownVarFromBitmapDataCache_Map_1.getValue(param1) as BitmapDataCacheItem;
         if(_loc3_ != null)
         {
            if(_loc3_.bitmapData == param2)
            {
               return;
            }
            _loc4_ = _loc3_.bitmapData;
            if(_loc4_ != null)
            {
               _memUsage -= _loc4_.width * _loc4_.height * 4;
            }
            _loc3_.bitmapData = param2;
         }
         else
         {
            _loc3_ = new BitmapDataCacheItem(param2,param1);
            UnknownVarFromBitmapDataCache_Map_1.add(param1,_loc3_);
         }
         _memUsage += param2.width * param2.height * 4;
      }
   }
}

