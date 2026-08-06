package com.sulake.habbo.avatar.enum
{
   public class UnknownHabboAvatarEnum1
   {
      public static const UnknownConstFromUnknownHabboAvatarEnum1_Uint_1:uint = 0;
      
      public static const UnknownConstFromUnknownHabboAvatarEnum1_Uint_2:uint = 1;
      
      public static const BOT_EDITOR:uint = 2;
      
      public static const DEV_TOOL_EDITOR:uint = 3;
      
      public function UnknownHabboAvatarEnum1()
      {
         super();
      }
      
      public static function isDevelopmentEditor(param1:int) : Boolean
      {
         return param1 == 2 || param1 == 2 || param1 == 3;
      }
   }
}

