package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.graphics.UnknownCoreWindowGraphics2;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class BitmapSkinRenderer extends SkinRenderer implements ISkinRenderer
   {
      protected static const UnknownConstFromBitmapSkinRenderer_Rectangle_1:Rectangle = new Rectangle();
      
      protected static const UnknownConstFromBitmapSkinRenderer_Point_1:Point = new Point();
      
      protected var _bitmapCache:Dictionary;
      
      protected var UnknownVarFromBitmapSkinRenderer_Matrix_1:Matrix;
      
      protected var UnknownVarFromBitmapSkinRenderer_ColorTransform_1:ColorTransform;
      
      public function BitmapSkinRenderer(param1:String)
      {
         super(param1);
         _bitmapCache = new Dictionary(false);
         UnknownVarFromBitmapSkinRenderer_Matrix_1 = new Matrix();
         UnknownVarFromBitmapSkinRenderer_ColorTransform_1 = new ColorTransform();
      }
      
      override public function parse(param1:ISoundAsset, param2:XMLList, param3:IAssetLibraryCollection) : void
      {
         UnknownCoreWindowGraphics2.parseSkinDescription(param1.content as XML,param2,this,name,param3);
      }
      
      override public function dispose() : void
      {
         var _loc2_:String = null;
         var _loc1_:BitmapData = null;
         if(!disposed)
         {
            super.dispose();
            UnknownVarFromBitmapSkinRenderer_Matrix_1 = null;
            UnknownVarFromBitmapSkinRenderer_ColorTransform_1 = null;
            for(_loc2_ in _bitmapCache)
            {
               _loc1_ = _bitmapCache[_loc2_] as BitmapData;
               _loc1_.dispose();
               delete _bitmapCache[_loc2_];
            }
            _bitmapCache = null;
         }
      }
      
      override public function isStateDrawable(param1:uint) : Boolean
      {
         return UnknownVarFromSkinRenderer_Dictionary_1[param1] != null;
      }
      
      protected function configureWindowColorTransform(param1:uint) : void
      {
         UnknownVarFromBitmapSkinRenderer_ColorTransform_1.redMultiplier = ((param1 & 0xFF0000) >> 16) / 255;
         UnknownVarFromBitmapSkinRenderer_ColorTransform_1.greenMultiplier = ((param1 & 0xFF00) >> 8) / 255;
         UnknownVarFromBitmapSkinRenderer_ColorTransform_1.blueMultiplier = (param1 & 0xFF) / 255;
         UnknownVarFromBitmapSkinRenderer_ColorTransform_1.alphaMultiplier = 1;
         UnknownVarFromBitmapSkinRenderer_ColorTransform_1.redOffset = 0;
         UnknownVarFromBitmapSkinRenderer_ColorTransform_1.greenOffset = 0;
         UnknownVarFromBitmapSkinRenderer_ColorTransform_1.blueOffset = 0;
         UnknownVarFromBitmapSkinRenderer_ColorTransform_1.alphaOffset = 0;
      }
      
      override public function draw(param1:IWindowModel, param2:BitmapData, param3:Rectangle, param4:uint, param5:Boolean) : void
      {
         var _loc13_:* = 0;
         var _loc8_:ISkinTemplateEntity = null;
         var _loc16_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc22_:* = 0;
         var _loc24_:SkinLayoutEntity = null;
         var _loc14_:BitmapData = null;
         var _loc20_:Boolean = false;
         var _loc26_:int = 0;
         var _loc29_:* = 0;
         var _loc28_:int = 0;
         var _loc18_:BitmapData = null;
         var _loc25_:ISkinLayout = UnknownVarFromSkinRenderer_Dictionary_2[param4];
         var _loc6_:ISkinTemplate = UnknownVarFromSkinRenderer_Dictionary_1[param4];
         if(_loc25_ == null)
         {
            _loc25_ = UnknownVarFromSkinRenderer_Dictionary_2[0];
            _loc6_ = UnknownVarFromSkinRenderer_Dictionary_1[0];
         }
         _loc13_ = uint(_loc25_.numChildren);
         if(_loc25_ != null && _loc13_ > 0)
         {
            var _loc10_:int = param3.width - _loc25_.width;
            var _loc30_:int = param3.height - _loc25_.height;
            var _loc12_:Boolean = !param1.background && (param1.color & 0xFFFFFF) < 16777215;
            var _loc15_:* = false;
            if(_loc12_)
            {
               configureWindowColorTransform(param1.color);
            }
            _loc22_ = 0;
            while(_loc22_ < _loc13_)
            {
               _loc24_ = _loc25_.getChildAt(_loc22_) as SkinLayoutEntity;
               _loc8_ = _loc6_.getChildByName(_loc24_.name) as ISkinTemplateEntity;
               if(_loc8_ != null)
               {
                  _loc14_ = getBitmapFromCache(_loc6_,_loc24_.name);
                  _loc20_ = false;
                  try
                  {
                     if(!param1.background && _loc24_.colorize && _loc24_.colorizeMethod == "hsv_layer")
                     {
                        _loc14_ = _loc14_.clone();
                        _loc20_ = true;
                        HsvLayerColor.configureTransform(UnknownVarFromBitmapSkinRenderer_ColorTransform_1,param1.color,_loc24_.shade);
                        _loc14_.colorTransform(_loc14_.rect,UnknownVarFromBitmapSkinRenderer_ColorTransform_1);
                        _loc15_ = _loc12_;
                     }
                     else if(_loc12_ && _loc24_.colorize)
                     {
                        if(_loc15_)
                        {
                           configureWindowColorTransform(param1.color);
                           _loc15_ = false;
                        }
                        _loc14_ = _loc14_.clone();
                        _loc20_ = true;
                        _loc14_.colorTransform(_loc14_.rect,UnknownVarFromBitmapSkinRenderer_ColorTransform_1);
                     }
                     _loc16_ = false;
                     _loc9_ = false;
                     UnknownConstFromBitmapSkinRenderer_Rectangle_1.x = _loc24_.region.x + param3.x;
                     UnknownConstFromBitmapSkinRenderer_Rectangle_1.y = _loc24_.region.y + param3.y;
                     UnknownConstFromBitmapSkinRenderer_Rectangle_1.width = _loc24_.region.width;
                     UnknownConstFromBitmapSkinRenderer_Rectangle_1.height = _loc24_.region.height;
                     if(_loc24_.scaleH == 1)
                     {
                        UnknownConstFromBitmapSkinRenderer_Rectangle_1.x += _loc10_;
                     }
                     else if(_loc24_.scaleH == 2)
                     {
                        _loc16_ = true;
                        UnknownConstFromBitmapSkinRenderer_Rectangle_1.right += _loc10_;
                        if(UnknownConstFromBitmapSkinRenderer_Rectangle_1.width < 1)
                        {
                           break;
                        }
                     }
                     else if(_loc24_.scaleH == 4)
                     {
                        _loc16_ = true;
                        UnknownConstFromBitmapSkinRenderer_Rectangle_1.right += _loc10_;
                        if(UnknownConstFromBitmapSkinRenderer_Rectangle_1.width < 1)
                        {
                           break;
                        }
                     }
                     else if(_loc24_.scaleH == 8)
                     {
                        UnknownConstFromBitmapSkinRenderer_Rectangle_1.x = param3.width / 2 - UnknownConstFromBitmapSkinRenderer_Rectangle_1.width / 2;
                     }
                     if(_loc24_.scaleV == 1)
                     {
                        UnknownConstFromBitmapSkinRenderer_Rectangle_1.y += _loc30_;
                     }
                     else if(_loc24_.scaleV == 2)
                     {
                        _loc9_ = true;
                        UnknownConstFromBitmapSkinRenderer_Rectangle_1.bottom += _loc30_;
                        if(UnknownConstFromBitmapSkinRenderer_Rectangle_1.height < 1)
                        {
                           break;
                        }
                     }
                     else if(_loc24_.scaleV == 4)
                     {
                        _loc9_ = true;
                        UnknownConstFromBitmapSkinRenderer_Rectangle_1.bottom += _loc30_;
                        if(UnknownConstFromBitmapSkinRenderer_Rectangle_1.height < 1)
                        {
                           break;
                        }
                     }
                     else if(_loc24_.scaleV == 8)
                     {
                        UnknownConstFromBitmapSkinRenderer_Rectangle_1.y = param3.height / 2 - UnknownConstFromBitmapSkinRenderer_Rectangle_1.height / 2;
                     }
                     if(!_loc16_ && !_loc9_)
                     {
                        param2.copyPixels(_loc14_,_loc14_.rect,UnknownConstFromBitmapSkinRenderer_Rectangle_1.topLeft,null,null,true);
                     }
                     else if(_loc24_.scaleV == 4 || _loc24_.scaleH == 4)
                     {
                        _loc26_ = _loc14_.width;
                        var _loc21_:int = _loc14_.height;
                        var _loc11_:int = UnknownConstFromBitmapSkinRenderer_Rectangle_1.width / _loc26_;
                        var _loc31_:int = UnknownConstFromBitmapSkinRenderer_Rectangle_1.height / _loc21_;
                        var _loc17_:int = UnknownConstFromBitmapSkinRenderer_Rectangle_1.width % _loc26_;
                        var _loc7_:int = UnknownConstFromBitmapSkinRenderer_Rectangle_1.height % _loc21_;
                        var _loc27_:Point = new Point(UnknownConstFromBitmapSkinRenderer_Rectangle_1.x,UnknownConstFromBitmapSkinRenderer_Rectangle_1.y);
                        var _loc19_:Rectangle = new Rectangle(0,0,_loc17_,_loc14_.height);
                        var _loc23_:Rectangle = new Rectangle(0,0,_loc14_.width,_loc7_);
                        _loc29_ = 0;
                        while(_loc29_ < _loc31_)
                        {
                           _loc27_.x = UnknownConstFromBitmapSkinRenderer_Rectangle_1.x;
                           _loc28_ = 0;
                           while(_loc28_ < _loc11_)
                           {
                              param2.copyPixels(_loc14_,_loc14_.rect,_loc27_,null,null,true);
                              _loc27_.x += _loc26_;
                              _loc28_++;
                           }
                           if(_loc17_ > 0)
                           {
                              param2.copyPixels(_loc14_,_loc19_,_loc27_,null,null,true);
                           }
                           _loc27_.y += _loc21_;
                           _loc29_++;
                        }
                        if(_loc7_ > 0)
                        {
                           _loc27_.x = UnknownConstFromBitmapSkinRenderer_Rectangle_1.x;
                           _loc29_ = 0;
                           while(_loc29_ < _loc11_)
                           {
                              param2.copyPixels(_loc14_,_loc23_,_loc27_,null,null,true);
                              _loc27_.x += _loc26_;
                              _loc29_++;
                           }
                        }
                     }
                     else if(_loc14_.width == 1 && _loc14_.height == 1)
                     {
                        UnknownVarFromBitmapSkinRenderer_Matrix_1.a = UnknownConstFromBitmapSkinRenderer_Rectangle_1.width;
                        UnknownVarFromBitmapSkinRenderer_Matrix_1.d = UnknownConstFromBitmapSkinRenderer_Rectangle_1.height;
                        UnknownVarFromBitmapSkinRenderer_Matrix_1.tx = UnknownConstFromBitmapSkinRenderer_Rectangle_1.x;
                        UnknownVarFromBitmapSkinRenderer_Matrix_1.ty = UnknownConstFromBitmapSkinRenderer_Rectangle_1.y;
                        param2.draw(_loc14_,UnknownVarFromBitmapSkinRenderer_Matrix_1);
                     }
                     else
                     {
                        if(UnknownConstFromBitmapSkinRenderer_Rectangle_1.width < 1)
                        {
                           break;
                        }
                        if(UnknownConstFromBitmapSkinRenderer_Rectangle_1.height < 1)
                        {
                           break;
                        }
                        UnknownVarFromBitmapSkinRenderer_Matrix_1.a = UnknownConstFromBitmapSkinRenderer_Rectangle_1.width / _loc14_.width;
                        UnknownVarFromBitmapSkinRenderer_Matrix_1.d = UnknownConstFromBitmapSkinRenderer_Rectangle_1.height / _loc14_.height;
                        UnknownVarFromBitmapSkinRenderer_Matrix_1.tx = 0;
                        UnknownVarFromBitmapSkinRenderer_Matrix_1.ty = 0;
                        _loc18_ = new BitmapData(UnknownConstFromBitmapSkinRenderer_Rectangle_1.width,UnknownConstFromBitmapSkinRenderer_Rectangle_1.height,true,0);
                        _loc18_.draw(_loc14_,UnknownVarFromBitmapSkinRenderer_Matrix_1);
                        param2.copyPixels(_loc18_,_loc18_.rect,UnknownConstFromBitmapSkinRenderer_Rectangle_1.topLeft,null,null,true);
                        _loc18_.dispose();
                     }
                  }
                  finally
                  {
                     if(_loc20_)
                     {
                        _loc14_.dispose();
                     }
                  }
               }
               _loc22_++;
            }
         }
      }
      
      protected function drawStaticLayoutEntity(param1:BitmapData, param2:Rectangle, param3:ISkinLayout, param4:SkinLayoutEntity, param5:ISkinTemplate, param6:ISkinTemplateEntity) : void
      {
         var _loc7_:BitmapData = null;
         var _loc8_:Rectangle = param4.region.clone();
         _loc8_.x = _loc8_.x + param2.x;
         _loc8_.y += param2.y;
         switch(param6.type)
         {
            case "bitmap":
               _loc7_ = getBitmapFromCache(param5,param4.name);
               if(param4.scaleH == 1)
               {
                  _loc8_.x += param2.width - param3.width;
               }
               if(param4.scaleV == 1)
               {
                  _loc8_.y += param2.height - param3.height;
               }
               param1.copyPixels(_loc7_,_loc7_.rect,_loc8_.topLeft,null,null,true);
               break;
            case "fill":
               param1.fillRect(_loc8_,param4.color);
         }
      }
      
      protected function getBitmapFromCache(param1:ISkinTemplate, param2:String) : BitmapData
      {
         var _loc5_:String = null;
         var _loc6_:ISkinTemplateEntity = null;
         var _loc4_:BitmapData = null;
         _loc5_ = param2 + "@" + param1.name;
         var _loc3_:BitmapData = _bitmapCache[_loc5_];
         if(_loc3_ == null)
         {
            _loc6_ = param1.getChildByName(param2) as ISkinTemplateEntity;
            if(_loc6_ == null)
            {
               throw new Error("Template entity" + param2 + "not found!");
            }
            _loc4_ = param1.asset.content as BitmapData;
            if(_loc4_ == null)
            {
               throw new Error("Asset " + param1.asset + " not found!");
            }
            _loc3_ = new TrackedBitmapData(this,_loc6_.region.width,_loc6_.region.height,true);
            _loc3_.copyPixels(_loc4_,_loc6_.region,UnknownConstFromBitmapSkinRenderer_Point_1);
            _bitmapCache[_loc5_] = _loc3_;
         }
         return _loc3_;
      }
      
      private function drawBorders(param1:BitmapData, param2:Rectangle, param3:uint) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = param2.bottom - 1;
         _loc4_ = param2.left;
         while(_loc4_ < param2.right - 1)
         {
            param1.setPixel32(_loc4_,0,param3);
            param1.setPixel32(_loc4_,_loc5_,param3);
            _loc4_++;
         }
         _loc5_ = param2.top;
         while(_loc5_ < param2.bottom - 1)
         {
            param1.setPixel32(0,_loc5_,param3);
            param1.setPixel32(_loc4_,_loc5_,param3);
            _loc5_++;
         }
      }
   }
}

