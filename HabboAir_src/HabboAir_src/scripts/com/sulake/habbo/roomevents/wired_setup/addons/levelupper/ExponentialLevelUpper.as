package com.sulake.habbo.roomevents.wired_setup.addons.levelupper
{
   public class ExponentialLevelUpper extends AbstractLevelUpConfig
   {
      private var UnknownVarFromExponentialLevelUpper_Int_1:int;
      
      private var _strength:Number;
      
      private var _maxLevel:int;
      
      public function ExponentialLevelUpper(param1:int, param2:int, param3:int)
      {
         super();
         UnknownVarFromExponentialLevelUpper_Int_1 = param1;
         _strength = param2 / 100;
         _maxLevel = param3;
      }
      
      override public function get maxLevel() : int
      {
         return _maxLevel;
      }
      
      override public function xpForLevel(param1:int) : Number
      {
         if(param1 < 1)
         {
            return 0;
         }
         return UnknownVarFromExponentialLevelUpper_Int_1 * ((Math.pow(1 + _strength,param1 - 1) - 1 + 1e-9) / _strength);
      }
   }
}

