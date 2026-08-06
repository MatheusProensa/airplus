package com.sulake.habbo.ui.widget.furniture.trophy
{
   public class TrophyTheme
   {
      public static const UnknownConstFromTrophyTheme_Int_1:int = 0;
      
      public static const SILVER:int = 1;
      
      public static const BRONZE:int = 2;
      
      public static const DEFAULT_BACKGROUND_TINT:uint = 16777215;
      
      private static const BACKGROUND_ASSET_NAMES:Array = ["trophy_bg_gold","trophy_bg_silver","trophy_bg_bronze"];
      
      private static const HEADER_COLORS:Array = [4293707079,4291411404,4290279476];
      
      public function TrophyTheme()
      {
         super();
      }
      
      public static function normalize(param1:int) : int
      {
         if(param1 < 0 || param1 > 2)
         {
            return 0;
         }
         return param1;
      }
      
      public static function getBackgroundAssetName(param1:int) : String
      {
         return BACKGROUND_ASSET_NAMES[normalize(param1)];
      }
      
      public static function getHeaderColor(param1:int) : uint
      {
         return uint(HEADER_COLORS[normalize(param1)]);
      }
   }
}

