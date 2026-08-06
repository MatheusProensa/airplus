package com.sulake.habbo.avatar.animation
{
   import com.sulake.core.utils.Map;
   import flash.geom.ColorTransform;
   
   public class AvatarDataContainer implements IAvatarDataContainer
   {
      private var _ink:int;
      
      private var UnknownVarFromAvatarDataContainer_Uint_1:uint;
      
      private var UnknownVarFromAvatarDataContainer_Uint_2:uint;
      
      private var _colorTransform:ColorTransform;
      
      private var UnknownVarFromAvatarDataContainer_Uint_3:uint;
      
      private var _r:uint;
      
      private var _g:uint;
      
      private var _b:uint;
      
      private var UnknownVarFromAvatarDataContainer_Number_1:Number = 1;
      
      private var UnknownVarFromAvatarDataContainer_Number_2:Number = 1;
      
      private var UnknownVarFromAvatarDataContainer_Number_3:Number = 1;
      
      private var UnknownVarFromAvatarDataContainer_Number_4:Number = 1;
      
      private var UnknownVarFromAvatarDataContainer_Map_1:Map;
      
      private var _paletteIsGrayscale:Boolean = true;
      
      public function AvatarDataContainer(param1:XML)
      {
         super();
         _ink = parseInt(param1.@ink);
         var _loc2_:String = String(param1.@foreground);
         _loc2_ = _loc2_.replace("#","");
         var _loc3_:String = String(param1.@background);
         _loc3_ = _loc3_.replace("#","");
         UnknownVarFromAvatarDataContainer_Uint_1 = parseInt(_loc2_,16);
         UnknownVarFromAvatarDataContainer_Uint_2 = parseInt(_loc3_,16);
         UnknownVarFromAvatarDataContainer_Uint_3 = parseInt(_loc2_,16);
         _r = UnknownVarFromAvatarDataContainer_Uint_3 >> 16 & 0xFF;
         _g = UnknownVarFromAvatarDataContainer_Uint_3 >> 8 & 0xFF;
         _b = UnknownVarFromAvatarDataContainer_Uint_3 >> 0 & 0xFF;
         UnknownVarFromAvatarDataContainer_Number_1 = _r / 255 * 1;
         UnknownVarFromAvatarDataContainer_Number_2 = _g / 255 * 1;
         UnknownVarFromAvatarDataContainer_Number_3 = _b / 255 * 1;
         if(_ink == 37)
         {
            UnknownVarFromAvatarDataContainer_Number_4 = 0.5;
            _paletteIsGrayscale = false;
         }
         _colorTransform = new ColorTransform(UnknownVarFromAvatarDataContainer_Number_1,UnknownVarFromAvatarDataContainer_Number_2,UnknownVarFromAvatarDataContainer_Number_3,UnknownVarFromAvatarDataContainer_Number_4);
         UnknownVarFromAvatarDataContainer_Map_1 = generatePaletteMapForGrayscale(UnknownVarFromAvatarDataContainer_Uint_2,UnknownVarFromAvatarDataContainer_Uint_1);
      }
      
      public function get ink() : int
      {
         return _ink;
      }
      
      public function get colorTransform() : ColorTransform
      {
         return _colorTransform;
      }
      
      public function get reds() : Array
      {
         return UnknownVarFromAvatarDataContainer_Map_1.getValue("reds") as Array;
      }
      
      public function get greens() : Array
      {
         return UnknownVarFromAvatarDataContainer_Map_1.getValue("greens") as Array;
      }
      
      public function get blues() : Array
      {
         return UnknownVarFromAvatarDataContainer_Map_1.getValue("blues") as Array;
      }
      
      public function get alphas() : Array
      {
         return UnknownVarFromAvatarDataContainer_Map_1.getValue("alphas") as Array;
      }
      
      public function get paletteIsGrayscale() : Boolean
      {
         return _paletteIsGrayscale;
      }
      
      private function generatePaletteMapForGrayscale(param1:uint, param2:uint) : Map
      {
         var _loc9_:int = 0;
         var _loc15_:* = param1 >> 24 & 0xFF;
         var _loc24_:* = param1 >> 16 & 0xFF;
         var _loc10_:* = param1 >> 8 & 0xFF;
         var _loc14_:* = param1 >> 0 & 0xFF;
         var _loc17_:* = param2 >> 24 & 0xFF;
         var _loc3_:* = param2 >> 16 & 0xFF;
         var _loc11_:* = param2 >> 8 & 0xFF;
         var _loc16_:* = param2 >> 0 & 0xFF;
         var _loc21_:Number = (_loc17_ - _loc15_) / 255;
         var _loc12_:Number = (_loc3_ - _loc24_) / 255;
         var _loc6_:Number = (_loc11_ - _loc10_) / 255;
         var _loc23_:Number = (_loc16_ - _loc14_) / 255;
         var _loc22_:Map = new Map();
         var _loc19_:Array = [];
         var _loc8_:Array = [];
         var _loc13_:Array = [];
         var _loc20_:Array = [];
         var _loc4_:Number = _loc15_;
         var _loc18_:Number = _loc24_;
         var _loc7_:Number = _loc10_;
         var _loc5_:Number = _loc14_;
         _loc9_ = 0;
         while(_loc9_ < 256)
         {
            if(_loc18_ == _loc24_ && _loc7_ == _loc10_ && _loc5_ == _loc14_)
            {
               _loc4_ = 0;
            }
            _loc4_ += _loc21_;
            _loc18_ += _loc12_;
            _loc7_ += _loc6_;
            _loc5_ += _loc23_;
            _loc20_.push(_loc4_ << 24);
            _loc19_.push(_loc4_ << 24 | _loc18_ << 16 | _loc7_ << 8 | _loc5_);
            _loc8_.push(_loc4_ << 24 | _loc18_ << 16 | _loc7_ << 8 | _loc5_);
            _loc13_.push(_loc4_ << 24 | _loc18_ << 16 | _loc7_ << 8 | _loc5_);
            _loc9_++;
         }
         _loc22_.add("alphas",_loc19_);
         _loc22_.add("reds",_loc19_);
         _loc22_.add("greens",_loc8_);
         _loc22_.add("blues",_loc13_);
         return _loc22_;
      }
   }
}

