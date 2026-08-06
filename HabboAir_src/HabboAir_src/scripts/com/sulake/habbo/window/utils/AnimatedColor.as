package com.sulake.habbo.window.utils
{
   public class AnimatedColor
   {
      private var _durationMs:Number;
      
      private var UnknownVarFromAnimatedColor_Uint_1:uint;
      
      private var UnknownVarFromAnimatedColor_Number_1:Number = 0;
      
      private var UnknownVarFromAnimatedColor_Uint_2:uint;
      
      private var _value:uint;
      
      public function AnimatedColor(param1:Number)
      {
         super();
         _durationMs = Math.max(0,param1);
      }
      
      public function get value() : uint
      {
         return _value;
      }
      
      public function snapTo(param1:uint, param2:Number) : void
      {
         var _loc3_:uint = normalizeColor(param1);
         UnknownVarFromAnimatedColor_Uint_1 = _loc3_;
         UnknownVarFromAnimatedColor_Number_1 = param2;
         UnknownVarFromAnimatedColor_Uint_2 = _loc3_;
         _value = _loc3_;
      }
      
      public function setTarget(param1:uint, param2:Number) : void
      {
         var _loc3_:uint = normalizeColor(param1);
         if(_loc3_ == UnknownVarFromAnimatedColor_Uint_2)
         {
            return;
         }
         update(param2);
         UnknownVarFromAnimatedColor_Uint_1 = _value;
         UnknownVarFromAnimatedColor_Number_1 = param2;
         UnknownVarFromAnimatedColor_Uint_2 = _loc3_;
      }
      
      public function needsUpdate(param1:Number) : Boolean
      {
         return _value != UnknownVarFromAnimatedColor_Uint_2;
      }
      
      public function update(param1:Number) : Boolean
      {
         var _loc3_:uint = _value;
         if(_durationMs == 0 || param1 >= UnknownVarFromAnimatedColor_Number_1 + _durationMs)
         {
            _value = UnknownVarFromAnimatedColor_Uint_2;
            return _loc3_ != _value;
         }
         var _loc2_:Number = Math.max(0,(param1 - UnknownVarFromAnimatedColor_Number_1) / _durationMs);
         _value = fromRgb(interpolateChannel(UnknownVarFromAnimatedColor_Uint_1 >> 16 & 0xFF,UnknownVarFromAnimatedColor_Uint_2 >> 16 & 0xFF,_loc2_),interpolateChannel(UnknownVarFromAnimatedColor_Uint_1 >> 8 & 0xFF,UnknownVarFromAnimatedColor_Uint_2 >> 8 & 0xFF,_loc2_),interpolateChannel(UnknownVarFromAnimatedColor_Uint_1 & 0xFF,UnknownVarFromAnimatedColor_Uint_2 & 0xFF,_loc2_));
         return _loc3_ != _value;
      }
      
      private function fromRgb(param1:uint, param2:uint, param3:uint) : uint
      {
         return param1 << 16 | param2 << 8 | param3;
      }
      
      private function interpolateChannel(param1:uint, param2:uint, param3:Number) : uint
      {
         return Math.round(param1 + (param2 - param1) * param3);
      }
      
      private function normalizeColor(param1:uint) : uint
      {
         return param1 & 0xFFFFFF;
      }
   }
}

