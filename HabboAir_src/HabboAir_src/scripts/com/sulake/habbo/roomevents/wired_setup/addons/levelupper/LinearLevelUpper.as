package com.sulake.habbo.roomevents.wired_setup.addons.levelupper
{
   public class LinearLevelUpper extends AbstractLevelUpConfig
   {
      private var UnknownVarFromLinearLevelUpper_Int_1:int;
      
      private var _maxLevel:int;
      
      public function LinearLevelUpper(param1:int, param2:int)
      {
         super();
         this.UnknownVarFromLinearLevelUpper_Int_1 = param1;
         this._maxLevel = param2;
      }
      
      override public function get maxLevel() : int
      {
         return _maxLevel;
      }
      
      override public function xpForLevel(param1:int) : Number
      {
         if(param1 <= 1)
         {
            return 0;
         }
         return UnknownVarFromLinearLevelUpper_Int_1 * (param1 - 1);
      }
   }
}

