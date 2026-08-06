package com.sulake.habbo.game.snowwar.utils
{
   public class UnknownHabboGameSnowwarUtils1
   {
      public function UnknownHabboGameSnowwarUtils1()
      {
         super();
      }
      
      public static function javaDiv(param1:Number) : int
      {
         if(param1 >= 0)
         {
            return Math.floor(param1);
         }
         return Math.ceil(param1);
      }
   }
}

