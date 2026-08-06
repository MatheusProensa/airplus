package com.sulake.habbo.catalog.habbicons
{
   public class HabbiconAlbumStats
   {
      public var ownedHabbicons:int = 0;
      
      public var completedSets:int = 0;
      
      public var collected:int = 0;
      
      public var total:int = 0;
      
      public function HabbiconAlbumStats()
      {
         super();
      }
      
      public function get progressRatio() : Number
      {
         return total <= 0 ? 0 : Math.max(0,Math.min(1,collected / total));
      }
   }
}

