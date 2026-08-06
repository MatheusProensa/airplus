package com.sulake.habbo.communication.enum
{
   [SecureSWF(rename="true")]
   public class BadgeRarity
   {
      public static const COMMON:int = 0;
      
      public static const UnknownConstFromBadgeRarity_Int_1:int = 1;
      
      public static const RARE:int = 2;
      
      public static const VERY_RARE:int = 3;
      
      public static const MYTHICAL:int = 4;
      
      public static const UnknownConstFromBadgeRarity_Int_2:int = 5;
      
      public static const UnknownConstFromBadgeRarity_Int_3:int = 6;
      
      private static const UnknownConstFromBadgeRarity_Uint_1:uint = 11759111;
      
      public function BadgeRarity()
      {
         super();
      }
      
      public static function isRareOrHigher(param1:int) : Boolean
      {
         return param1 >= 2;
      }
      
      public static function isStandaloneTier(param1:int, param2:Boolean = false) : Boolean
      {
         return isRareOrHigher(param1) || param2 && param1 == 1;
      }
      
      public static function getLocalizationKey(param1:int, param2:Boolean = false) : String
      {
         switch(param1 - 1)
         {
            case 0:
               return param2 ? "badge.rarity.uncommon" : "";
            case 1:
               return "badge.rarity.rare";
            case 2:
               return "badge.rarity.epic";
            case 3:
               return "badge.rarity.mythical";
            case 4:
               return "badge.rarity.legendary";
            case 5:
               return "badge.rarity.unique";
            default:
               return "";
         }
      }
      
      public static function getLabelLocalizationKey(param1:int, param2:Boolean = false) : String
      {
         return isStandaloneTier(param1,param2) ? getLocalizationKey(param1,param2) : "badge.rarity.common";
      }
      
      public static function getDisplayColor(param1:int, param2:Boolean = false) : uint
      {
         switch(param1 - 1)
         {
            case 0:
               return param2 ? 16758605 : 0;
            case 1:
               return 8780159;
            case 2:
               return 6732543;
            case 3:
               return 12809942;
            case 4:
               return 14036772;
            case 5:
               return 13406720;
            default:
               return 0;
         }
      }
      
      public static function getGlowColor(param1:int, param2:Boolean = false) : uint
      {
         return param2 && param1 == 1 ? 11759111 : getDisplayColor(param1,param2);
      }
      
      public static function getWhiteBackgroundTagColor(param1:int, param2:Boolean = false) : uint
      {
         switch(param1)
         {
            case 0:
               return 7829367;
            case 1:
               return param2 ? getDisplayColor(param1,param2) : 7829367;
            case 2:
               return darkenColor(getDisplayColor(param1,param2),0.35);
            case 3:
               return darkenColor(getDisplayColor(param1,param2),0.2);
            case 4:
               return darkenColor(getDisplayColor(param1,param2),0.15);
            case 5:
               return darkenColor(getDisplayColor(param1,param2),0.1);
            default:
               return getDisplayColor(param1,param2);
         }
      }
      
      private static function darkenColor(param1:uint, param2:Number) : uint
      {
         var _loc6_:Number = 1 - param2;
         var _loc3_:uint = uint(param1 >> 16 & 0xFF);
         var _loc4_:uint = uint(param1 >> 8 & 0xFF);
         var _loc5_:uint = uint(param1 & 0xFF);
         _loc3_ *= _loc6_;
         _loc4_ *= _loc6_;
         _loc5_ *= _loc6_;
         return _loc3_ << 16 | _loc4_ << 8 | _loc5_;
      }
   }
}

