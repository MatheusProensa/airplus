package com.sulake.habbo.catalog.habbicons
{
   public class HabbiconPopupMode
   {
      public static const CLAIM:String = "claim";
      
      public static const PURCHASE:String = "purchase";
      
      public static const ADD_FAVORITE:String = "add_favorite";
      
      public static const REMOVE_FAVORITE:String = "remove_favorite";
      
      public static const INFO:String = "info";
      
      public function HabbiconPopupMode()
      {
         super();
      }
      
      public static function resolve(param1:HabbiconEntryModel) : String
      {
         if(!param1)
         {
            return "purchase";
         }
         if(param1.favorite)
         {
            return "remove_favorite";
         }
         if(param1.owned)
         {
            return param1.favorite ? "remove_favorite" : "add_favorite";
         }
         if(param1.claimable)
         {
            return "claim";
         }
         if(param1.isReward || !param1.purchasable)
         {
            return "info";
         }
         return "purchase";
      }
   }
}

