package com.sulake.habbo.roomevents.wired_setup.common
{
   public class NeighborhoodFloor
   {
      public static var RADIUS:int = 10;
      
      public static var SMALL_RADIUS:int = 5;
      
      public static var UnknownVarFromNeighborhoodFloor_Int_1:int = RADIUS * 2 + 1;
      
      private var _floorPlanCache:Array;
      
      private var _floorPlanCacheBuffer:Array = null;
      
      private var _smallMode:Boolean = false;
      
      private var UnknownVarFromNeighborhoodFloor_Function_1:Function = null;
      
      public function NeighborhoodFloor(param1:Array, param2:Boolean, param3:Function)
      {
         super();
         _floorPlanCache = param1;
         _smallMode = param2;
         UnknownVarFromNeighborhoodFloor_Function_1 = param3;
      }
      
      public function get floorPlanCache() : Array
      {
         return _floorPlanCache;
      }
      
      public function setOccupied(param1:int, param2:int, param3:Boolean) : void
      {
         _floorPlanCache[param1][param2] = param3;
      }
      
      public function isOccupied(param1:int, param2:int) : Boolean
      {
         return _floorPlanCache[param1][param2];
      }
      
      public function occupationHasChanged() : void
      {
         if(UnknownVarFromNeighborhoodFloor_Function_1 != null)
         {
            UnknownVarFromNeighborhoodFloor_Function_1();
         }
      }
      
      public function set smallMode(param1:Boolean) : void
      {
         _smallMode = param1;
      }
      
      public function smallModeAllowed() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = -RADIUS;
         while(_loc1_ <= RADIUS)
         {
            _loc2_ = -RADIUS;
            while(_loc2_ <= RADIUS)
            {
               if(_loc1_ < -SMALL_RADIUS || _loc1_ > SMALL_RADIUS || _loc2_ < -SMALL_RADIUS || _loc2_ > SMALL_RADIUS)
               {
                  if(isOccupied(_loc1_ + RADIUS,_loc2_ + RADIUS))
                  {
                     return false;
                  }
               }
               _loc2_ += 1;
            }
            _loc1_ += 1;
         }
         return true;
      }
      
      public function get visualizingRadius() : int
      {
         if(_smallMode)
         {
            return SMALL_RADIUS;
         }
         return RADIUS;
      }
      
      public function get visualizingDimension() : int
      {
         return visualizingRadius * 2 + 1;
      }
      
      public function initTemporaryCache() : void
      {
         _floorPlanCacheBuffer = _floorPlanCache;
         clearTemporaryCache();
      }
      
      public function clearTemporaryCache() : void
      {
         var _loc1_:int = 0;
         if(_floorPlanCacheBuffer != null)
         {
            _floorPlanCache = [];
            _loc1_ = 0;
            while(_loc1_ < _floorPlanCacheBuffer.length)
            {
               _floorPlanCache.push(_floorPlanCacheBuffer[_loc1_].concat());
               _loc1_++;
            }
         }
      }
      
      public function submitTemporaryCache() : void
      {
         _floorPlanCacheBuffer = null;
      }
   }
}

