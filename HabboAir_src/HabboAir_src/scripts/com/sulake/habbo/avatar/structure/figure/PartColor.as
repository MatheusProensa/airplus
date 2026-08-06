package com.sulake.habbo.avatar.structure.figure
{
   import flash.geom.ColorTransform;
   
   public class PartColor implements IPartColor
   {
      private var _id:int;
      
      private var _index:int;
      
      private var _clubLevel:int;
      
      private var _isSelectable:Boolean = false;
      
      private var _rgb:uint;
      
      private var _r:uint;
      
      private var _g:uint;
      
      private var _b:uint;
      
      private var _redMultiplier:Number;
      
      private var _greenMultiplier:Number;
      
      private var _blueMultiplier:Number;
      
      private var _colorTransform:ColorTransform;
      
      public function PartColor(param1:XML)
      {
         super();
         _id = parseInt(param1.@id);
         _index = parseInt(param1.@index);
         _clubLevel = parseInt(param1.@club);
         _isSelectable = Boolean(parseInt(param1.@selectable));
         var _loc2_:String = param1.text();
         _rgb = parseInt(_loc2_,16);
         _r = _rgb >> 16 & 0xFF;
         _g = _rgb >> 8 & 0xFF;
         _b = _rgb >> 0 & 0xFF;
         _redMultiplier = _r / 255 * 1;
         _greenMultiplier = _g / 255 * 1;
         _blueMultiplier = _b / 255 * 1;
         _colorTransform = new ColorTransform(_redMultiplier,_greenMultiplier,_blueMultiplier);
      }
      
      public function get colorTransform() : ColorTransform
      {
         return _colorTransform;
      }
      
      public function get redMultiplier() : Number
      {
         return _redMultiplier;
      }
      
      public function get greenMultiplier() : Number
      {
         return _greenMultiplier;
      }
      
      public function get blueMultiplier() : Number
      {
         return _blueMultiplier;
      }
      
      public function get rgb() : uint
      {
         return _rgb;
      }
      
      public function get r() : uint
      {
         return _r;
      }
      
      public function get g() : uint
      {
         return _g;
      }
      
      public function get b() : uint
      {
         return _b;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function get clubLevel() : int
      {
         return _clubLevel;
      }
      
      public function get isSelectable() : Boolean
      {
         return _isSelectable;
      }
   }
}

