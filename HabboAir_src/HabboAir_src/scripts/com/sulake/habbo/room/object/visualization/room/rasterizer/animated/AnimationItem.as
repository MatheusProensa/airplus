package com.sulake.habbo.room.object.visualization.room.rasterizer.animated
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class AnimationItem
   {
      private var UnknownVarFromAnimationItem_Number_1:Number = 0;
      
      private var UnknownVarFromAnimationItem_Number_2:Number = 0;
      
      private var UnknownVarFromAnimationItem_Number_3:Number = 0;
      
      private var UnknownVarFromAnimationItem_Number_4:Number = 0;
      
      private var _bitmapData:BitmapData = null;
      
      public function AnimationItem(param1:Number, param2:Number, param3:Number, param4:Number, param5:BitmapData)
      {
         super();
         UnknownVarFromAnimationItem_Number_1 = param1;
         UnknownVarFromAnimationItem_Number_2 = param2;
         UnknownVarFromAnimationItem_Number_3 = param3;
         UnknownVarFromAnimationItem_Number_4 = param4;
         if(isNaN(UnknownVarFromAnimationItem_Number_1))
         {
            UnknownVarFromAnimationItem_Number_1 = 0;
         }
         if(isNaN(UnknownVarFromAnimationItem_Number_2))
         {
            UnknownVarFromAnimationItem_Number_2 = 0;
         }
         if(isNaN(UnknownVarFromAnimationItem_Number_3))
         {
            UnknownVarFromAnimationItem_Number_3 = 0;
         }
         if(isNaN(UnknownVarFromAnimationItem_Number_4))
         {
            UnknownVarFromAnimationItem_Number_4 = 0;
         }
         _bitmapData = param5;
      }
      
      public function get bitmapData() : BitmapData
      {
         return _bitmapData;
      }
      
      public function dispose() : void
      {
         _bitmapData = null;
      }
      
      public function getPosition(param1:int, param2:int, param3:Number, param4:Number, param5:int) : Point
      {
         var _loc6_:Number = UnknownVarFromAnimationItem_Number_1;
         var _loc7_:Number = UnknownVarFromAnimationItem_Number_2;
         if(param3 > 0)
         {
            _loc6_ += UnknownVarFromAnimationItem_Number_3 / param3 * param5 / 1000;
         }
         if(param4 > 0)
         {
            _loc7_ += UnknownVarFromAnimationItem_Number_4 / param4 * param5 / 1000;
         }
         var _loc8_:int = _loc6_ % 1 * param1;
         var _loc9_:int = _loc7_ % 1 * param2;
         return new Point(_loc8_,_loc9_);
      }
   }
}

