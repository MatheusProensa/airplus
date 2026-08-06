package com.sulake.habbo.catalog.marketplace
{
   public class UnknownHabboCatalogMarketplace1
   {
      public static const OPEN:int = 1;
      
      public static const SOLD:int = 2;
      
      public static const EXPIRED:int = 3;
      
      public function UnknownHabboCatalogMarketplace1()
      {
         super();
      }
      
      public static function isClearable(param1:int) : Boolean
      {
         return param1 == 2 || param1 == 3;
      }
   }
}

