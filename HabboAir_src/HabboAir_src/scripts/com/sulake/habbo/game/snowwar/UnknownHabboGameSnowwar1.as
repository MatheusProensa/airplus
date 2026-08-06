package com.sulake.habbo.game.snowwar
{
   public class UnknownHabboGameSnowwar1
   {
      public static const UnknownConstFromUnknownHabboGameSnowwar1_Int_1:int = 0;
      
      public static const THROW_FAST_BALL:int = 1;
      
      public static const THROW_LONG_LOB_BALL:int = 2;
      
      public static const THROW_SHORT_LOB_BALL:int = 3;
      
      public static const THROW_DEFAULT:int = 4;
      
      public function UnknownHabboGameSnowwar1()
      {
         super();
      }
      
      public static function getClickTypeOnTile(param1:Boolean, param2:Boolean) : int
      {
         if(param1)
         {
            if(param2)
            {
               return 3;
            }
            return 2;
         }
         if(param2)
         {
            return 1;
         }
         return 0;
      }
      
      public static function getClickTypeOnOpponent(param1:Boolean, param2:Boolean) : int
      {
         if(param1)
         {
            if(param2)
            {
               return 3;
            }
            return 2;
         }
         if(param2)
         {
            return 1;
         }
         return 4;
      }
   }
}

