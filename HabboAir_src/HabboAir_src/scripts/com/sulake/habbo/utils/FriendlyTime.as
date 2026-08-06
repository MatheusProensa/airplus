package com.sulake.habbo.utils
{
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   
   public class FriendlyTime
   {
      private static const UnknownConstFromFriendlyTime_Uint_1:uint = 60;
      
      private static const UnknownConstFromFriendlyTime_Uint_2:uint = 3600;
      
      private static const UnknownConstFromFriendlyTime_Uint_3:uint = 86400;
      
      private static const UnknownConstFromFriendlyTime_Uint_4:uint = 604800;
      
      private static const MONTH_IN_SECONDS:uint = 2592000;
      
      private static const YEAR_IN_SECONDS:uint = 31536000;
      
      public function FriendlyTime()
      {
         super();
      }
      
      public static function getFriendlyTime(param1:IHabboLocalizationManager, param2:Number, param3:String = "", param4:int = 3) : String
      {
         if(param2 > param4 * 31536000)
         {
            return getLocalization(param1,"friendlytime.years" + param3,Math.round(param2 / 31536000));
         }
         if(param2 > param4 * 2592000)
         {
            return getLocalization(param1,"friendlytime.months" + param3,Math.round(param2 / 2592000));
         }
         if(param2 > param4 * 86400)
         {
            return getLocalization(param1,"friendlytime.days" + param3,Math.round(param2 / 86400));
         }
         if(param2 > param4 * 3600)
         {
            return getLocalization(param1,"friendlytime.hours" + param3,Math.round(param2 / 3600));
         }
         if(param2 > param4 * 60)
         {
            return getLocalization(param1,"friendlytime.minutes" + param3,Math.round(param2 / 60));
         }
         return getLocalization(param1,"friendlytime.seconds" + param3,Math.round(param2));
      }
      
      public static function getShortFriendlyTime(param1:IHabboLocalizationManager, param2:Number, param3:String = "", param4:int = 3) : String
      {
         if(param2 > param4 * 31536000)
         {
            return getLocalization(param1,"friendlytime.years.short" + param3,Math.round(param2 / 31536000));
         }
         if(param2 > param4 * 2592000)
         {
            return getLocalization(param1,"friendlytime.months.short" + param3,Math.round(param2 / 2592000));
         }
         if(param2 > param4 * 86400)
         {
            return getLocalization(param1,"friendlytime.days.short" + param3,Math.round(param2 / 86400));
         }
         if(param2 > param4 * 3600)
         {
            return getLocalization(param1,"friendlytime.hours.short" + param3,Math.round(param2 / 3600));
         }
         if(param2 > param4 * 60)
         {
            return getLocalization(param1,"friendlytime.minutes.short" + param3,Math.round(param2 / 60));
         }
         return getLocalization(param1,"friendlytime.seconds.short" + param3,Math.round(param2));
      }
      
      public static function getLocalization(param1:IHabboLocalizationManager, param2:String, param3:int) : String
      {
         return param1.getLocalizationWithParams(param2,param2,"amount",param3.toString());
      }
   }
}

