package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.TextLabelController;
   import com.sulake.core.window.utils.TextFieldCache;
   import com.sulake.core.window.utils.UnknownCoreWindowUtils3;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class LabelRenderer extends SkinRenderer
   {
      private static const UnknownConstFromLabelRenderer_ColorTransform_1:ColorTransform = new ColorTransform(0,0,0,1,255,255,255,0);
      
      protected var UnknownVarFromLabelRenderer_Matrix_1:Matrix;
      
      protected var UnknownVarFromLabelRenderer_UnknownCoreWindowUtils3_1:UnknownCoreWindowUtils3;
      
      protected var UnknownVarFromLabelRenderer_TextField_1:TextField;
      
      public function LabelRenderer(param1:String)
      {
         super(param1);
         UnknownVarFromLabelRenderer_Matrix_1 = new Matrix();
      }
      
      override public function draw(param1:IWindowModel, param2:BitmapData, param3:Rectangle, param4:uint, param5:Boolean) : void
      {
         var _loc9_:TextLabelController = null;
         var _loc6_:* = 0;
         var _loc7_:Object = null;
         var _loc10_:ColorTransform = null;
         if(param2 != null)
         {
            _loc9_ = TextLabelController(param1);
            var _loc8_:UnknownCoreWindowUtils3 = _loc9_.textStyle;
            if(_loc8_ != UnknownVarFromLabelRenderer_UnknownCoreWindowUtils3_1)
            {
               UnknownVarFromLabelRenderer_TextField_1 = TextFieldCache.getTextFieldByStyle(_loc8_);
               UnknownVarFromLabelRenderer_UnknownCoreWindowUtils3_1 = _loc8_;
            }
            UnknownVarFromLabelRenderer_Matrix_1.tx = _loc9_.drawOffsetX;
            UnknownVarFromLabelRenderer_Matrix_1.ty = _loc9_.drawOffsetY;
            UnknownVarFromLabelRenderer_TextField_1.text = _loc9_.text;
            _loc6_ = uint(_loc8_.color);
            UnknownVarFromLabelRenderer_TextField_1.textColor = _loc9_.hasTextColor ? _loc9_.textColor : _loc6_;
            UnknownVarFromLabelRenderer_TextField_1.antiAliasType = "advanced";
            UnknownVarFromLabelRenderer_TextField_1.gridFitType = "pixel";
            if(_loc9_.vertical)
            {
               UnknownVarFromLabelRenderer_Matrix_1.a = 0;
               UnknownVarFromLabelRenderer_Matrix_1.b = -1;
               UnknownVarFromLabelRenderer_Matrix_1.c = 1;
               UnknownVarFromLabelRenderer_Matrix_1.d = 0;
               UnknownVarFromLabelRenderer_Matrix_1.ty += _loc9_.height;
            }
            if((uint(_loc8_.etchingColor) & 4278190080) != 0)
            {
               UnknownConstFromLabelRenderer_ColorTransform_1.redOffset = uint(_loc8_.etchingColor) >> 16 & 0xFF;
               UnknownConstFromLabelRenderer_ColorTransform_1.greenOffset = uint(_loc8_.etchingColor) >> 8 & 0xFF;
               UnknownConstFromLabelRenderer_ColorTransform_1.blueOffset = uint(_loc8_.etchingColor) & 0xFF;
               _loc7_ = ETCHING_POSITION[_loc8_.etchingPosition];
               if(_loc7_ != null)
               {
                  if(_loc9_.vertical)
                  {
                     UnknownVarFromLabelRenderer_Matrix_1.tx += _loc7_.y;
                     UnknownVarFromLabelRenderer_Matrix_1.ty -= _loc7_.x;
                     param2.draw(UnknownVarFromLabelRenderer_TextField_1,UnknownVarFromLabelRenderer_Matrix_1,UnknownConstFromLabelRenderer_ColorTransform_1,null,null,false);
                     UnknownVarFromLabelRenderer_Matrix_1.tx -= _loc7_.y;
                     UnknownVarFromLabelRenderer_Matrix_1.ty += _loc7_.x;
                  }
                  else
                  {
                     UnknownVarFromLabelRenderer_Matrix_1.tx += _loc7_.x;
                     UnknownVarFromLabelRenderer_Matrix_1.ty += _loc7_.y;
                     param2.draw(UnknownVarFromLabelRenderer_TextField_1,UnknownVarFromLabelRenderer_Matrix_1,UnknownConstFromLabelRenderer_ColorTransform_1,null,null,false);
                     UnknownVarFromLabelRenderer_Matrix_1.tx -= _loc7_.x;
                     UnknownVarFromLabelRenderer_Matrix_1.ty -= _loc7_.y;
                  }
               }
            }
            if(param1.dynamicStyleColor)
            {
               _loc10_ = param1.dynamicStyleColor;
            }
            param2.draw(UnknownVarFromLabelRenderer_TextField_1,UnknownVarFromLabelRenderer_Matrix_1,_loc10_,null,null,false);
            if(_loc9_.vertical)
            {
               UnknownVarFromLabelRenderer_Matrix_1.a = 1;
               UnknownVarFromLabelRenderer_Matrix_1.b = 0;
               UnknownVarFromLabelRenderer_Matrix_1.c = 0;
               UnknownVarFromLabelRenderer_Matrix_1.d = 1;
               UnknownVarFromLabelRenderer_Matrix_1.ty -= _loc9_.height;
            }
            UnknownVarFromLabelRenderer_TextField_1.textColor = _loc6_;
         }
      }
      
      override public function isStateDrawable(param1:uint) : Boolean
      {
         return param1 == 0;
      }
   }
}

