package com.sulake.habbo.roomevents.wired_setup.addons.levelupper
{
   import com.sulake.core.utils.Map;
   
   public class InterpolateLevelUpper extends AbstractLevelUpConfig
   {
      private var UnknownVarFromInterpolateLevelUpper_Map_1:Map;
      
      public function InterpolateLevelUpper(param1:Map)
      {
         super();
         this.UnknownVarFromInterpolateLevelUpper_Map_1 = generateTree(param1);
      }
      
      private static function generateTree(param1:Map) : Map
      {
         var _loc3_:int = 0;
         var _loc4_:Map = new Map();
         _loc4_.add(0,1);
         for each(var _loc2_ in param1.getKeys())
         {
            _loc3_ = param1.getValue(_loc2_);
            _loc4_.add(_loc3_,_loc2_);
         }
         return _loc4_;
      }
      
      override public function xpForLevel(param1:int) : Number
      {
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc6_:Number = NaN;
         var _loc8_:int = 0;
         if(param1 <= 1)
         {
            return 0;
         }
         var _loc4_:int = 0;
         for each(var _loc7_ in UnknownVarFromInterpolateLevelUpper_Map_1.getKeys())
         {
            _loc5_ = UnknownVarFromInterpolateLevelUpper_Map_1.getValue(_loc7_);
            if(_loc5_ == param1)
            {
               return _loc7_;
            }
            if(_loc5_ > param1)
            {
               _loc2_ = UnknownVarFromInterpolateLevelUpper_Map_1.getValue(getLowerEntryKey(_loc7_));
               _loc3_ = int(getLowerEntryKey(_loc7_));
               _loc9_ = _loc5_ - _loc2_;
               _loc10_ = _loc7_ - _loc3_;
               _loc6_ = _loc10_ / _loc9_;
               _loc8_ = param1 - _loc2_;
               return _loc3_ + int(_loc6_ * _loc8_);
            }
            _loc4_ = _loc7_;
         }
         return _loc4_;
      }
      
      override public function get maxLevel() : int
      {
         return UnknownVarFromInterpolateLevelUpper_Map_1[int(getLowerEntryKey(2147483647))];
      }
      
      private function getLowerEntryKey(param1:int) : Object
      {
         var _loc2_:Object = null;
         for each(var _loc3_ in UnknownVarFromInterpolateLevelUpper_Map_1.getKeys())
         {
            if(_loc3_ < param1 && (_loc2_ == null || _loc3_ > _loc2_))
            {
               _loc2_ = _loc3_;
            }
         }
         return _loc2_;
      }
   }
}

