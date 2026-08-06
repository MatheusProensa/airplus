package com.sulake.habbo.groups
{
   public class UnknownHabboGroups1
   {
      public static const LINK_ID:String = "badge_leaderboard";
      
      public static const LINK_PATTERN:String = "badge_leaderboard/";
      
      public static const UnknownConstFromUnknownHabboGroups1_Int_1:int = 1000;
      
      public static const DEFAULT_RARITY:int = -1;
      
      public static const DEFAULT_PAGE:int = 0;
      
      public static const PAGE_SIZE:int = 10;
      
      public static const TOTAL_BADGES:int = 0;
      
      public static const BADGES_BY_RARITY:int = 1;
      
      public static const ACHIEVEMENT_LEVEL:int = 2;
      
      public static const FRAME_STYLE_TOTAL_BADGES:int = 10000;
      
      public static const FRAME_STYLE_ACHIEVEMENT_LEVEL:int = 10001;
      
      public static const FRAME_STYLE_RARE:int = 10002;
      
      public static const FRAME_STYLE_VERY_RARE:int = 10003;
      
      public static const FRAME_STYLE_MYTHICAL:int = 10004;
      
      public static const FRAME_STYLE_LEGENDARY:int = 10005;
      
      public static const FRAME_STYLE_UNIQUE:int = 10006;
      
      public static const FRAME_STYLE_UNCOMMON:int = 10007;
      
      public function UnknownHabboGroups1()
      {
         super();
      }
      
      public static function getLink(param1:int, param2:int = -1, param3:int = 0) : String
      {
         return "badge_leaderboard/" + param1 + "/" + param2 + "/" + param3;
      }
      
      public static function getPageForRank(param1:int) : int
      {
         if(param1 < 0)
         {
            return 0;
         }
         return int(Math.max(0,param1 - 1) / 10);
      }
      
      public static function formatOwnerCount(param1:int) : String
      {
         if(param1 >= 1000)
         {
            return "1000+";
         }
         return param1.toString();
      }
      
      public static function shouldShowOwnerCount(param1:int) : Boolean
      {
         return param1 > 0 && param1 < 1000;
      }
   }
}

