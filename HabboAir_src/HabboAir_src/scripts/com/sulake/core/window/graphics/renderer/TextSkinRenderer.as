package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.utils.ITextFieldContainer;
   import com.sulake.core.window.utils.TextStyleManager;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class TextSkinRenderer extends SkinRenderer
   {
      private static const UnknownConstFromTextSkinRenderer_ColorTransform_1:ColorTransform = new ColorTransform(0,0,0,1,255,255,255,0);
      
      protected var UnknownVarFromTextSkinRenderer_Matrix_1:Matrix;
      
      public function TextSkinRenderer(param1:String)
      {
         super(param1);
         UnknownVarFromTextSkinRenderer_Matrix_1 = new Matrix();
      }
      
      override public function parse(param1:ISoundAsset, param2:XMLList, param3:IAssetLibraryCollection) : void
      {
         var _loc4_:String = param1.content.toString();
         TextStyleManager.setStyles(TextStyleManager.parseCSS(_loc4_));
      }
      
      override public function draw(param1:IWindowModel, param2:BitmapData, param3:Rectangle, param4:uint, param5:Boolean) : void
      {
         var _loc7_:ITextFieldContainer = null;
         var _loc9_:Object = null;
         var _loc11_:ColorTransform = null;
         if(param2 != null)
         {
            _loc7_ = ITextFieldContainer(param1);
            var _loc10_:ITextWindow = ITextWindow(param1);
            var _loc6_:String = _loc10_.autoSize;
            var _loc8_:TextField = _loc7_.textField;
            UnknownVarFromTextSkinRenderer_Matrix_1.tx = _loc7_.margins.left;
            UnknownVarFromTextSkinRenderer_Matrix_1.ty = _loc7_.margins.top;
            if(_loc6_ == "right")
            {
               UnknownVarFromTextSkinRenderer_Matrix_1.tx = Math.floor(param1.width - _loc8_.width - _loc7_.margins.right);
            }
            else if(_loc6_ == "center")
            {
               UnknownVarFromTextSkinRenderer_Matrix_1.tx = Math.floor(param1.width / 2 - _loc8_.width / 2);
            }
            if((_loc10_.etchingColor & 4278190080) != 0)
            {
               UnknownConstFromTextSkinRenderer_ColorTransform_1.redOffset = _loc10_.etchingColor >> 16 & 0xFF;
               UnknownConstFromTextSkinRenderer_ColorTransform_1.greenOffset = _loc10_.etchingColor >> 8 & 0xFF;
               UnknownConstFromTextSkinRenderer_ColorTransform_1.blueOffset = _loc10_.etchingColor & 0xFF;
               UnknownConstFromTextSkinRenderer_ColorTransform_1.alphaMultiplier = (_loc10_.etchingColor >> 24 & 0xFF) / 255;
               _loc9_ = ETCHING_POSITION[_loc10_.etchingPosition];
               if(_loc9_ != null)
               {
                  UnknownVarFromTextSkinRenderer_Matrix_1.tx += _loc9_.x;
                  UnknownVarFromTextSkinRenderer_Matrix_1.ty += _loc9_.y;
                  param2.draw(_loc8_,UnknownVarFromTextSkinRenderer_Matrix_1,UnknownConstFromTextSkinRenderer_ColorTransform_1,null,null,false);
                  UnknownVarFromTextSkinRenderer_Matrix_1.tx -= _loc9_.x;
                  UnknownVarFromTextSkinRenderer_Matrix_1.ty -= _loc9_.y;
               }
            }
            if(param1.dynamicStyleColor)
            {
               _loc11_ = param1.dynamicStyleColor;
            }
            param2.draw(_loc8_,UnknownVarFromTextSkinRenderer_Matrix_1,_loc11_,null,null,false);
         }
      }
      
      override public function isStateDrawable(param1:uint) : Boolean
      {
         return param1 == 0;
      }
   }
}

