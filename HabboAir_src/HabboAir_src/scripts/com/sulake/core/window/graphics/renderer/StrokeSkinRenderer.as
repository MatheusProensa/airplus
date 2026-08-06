package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.StrokeController;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public class StrokeSkinRenderer extends SkinRenderer
   {
      private static const SIDE_MASK_ALL:uint = 15;
      
      public function StrokeSkinRenderer(param1:String)
      {
         super(param1);
      }
      
      override public function draw(param1:IWindowModel, param2:BitmapData, param3:Rectangle, param4:uint, param5:Boolean) : void
      {
         var _loc7_:StrokeController = param1 as StrokeController;
         if(_loc7_ == null || param2 == null || param3 == null || param3.width <= 0 || param3.height <= 0)
         {
            return;
         }
         param2.fillRect(param3,0);
         if(_loc7_.strokeThickness <= 0)
         {
            return;
         }
         var _loc6_:int = Math.max(1,Math.round(_loc7_.strokeThickness));
         var _loc8_:uint = _loc7_.sideMask;
         if(_loc6_ <= 0)
         {
            return;
         }
         if(_loc8_ == 15 && _loc7_.radius > 0)
         {
            ShapeSkinRenderer.drawRoundRectStroke(param2,param3.x,param3.y,param3.width,param3.height,_loc7_.radius,_loc6_,param1.color);
            return;
         }
         ShapeSkinRenderer.drawRectStrokeSides(param2,param3.x,param3.y,param3.width,param3.height,_loc6_,param1.color,(_loc8_ & 1) != 0,(_loc8_ & 2) != 0,(_loc8_ & 4) != 0,(_loc8_ & 8) != 0);
      }
      
      override public function isStateDrawable(param1:uint) : Boolean
      {
         return true;
      }
   }
}

