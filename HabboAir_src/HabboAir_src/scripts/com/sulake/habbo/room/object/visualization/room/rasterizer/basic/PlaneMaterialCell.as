package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.habbo.room.object.visualization.room.utils.Randomizer;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import com.sulake.room.utils.IVector3d;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class PlaneMaterialCell
   {
      private var UnknownVarFromPlaneMaterialCell_BitmapData_1:BitmapData = null;
      
      private var UnknownVarFromPlaneMaterialCell_PlaneTexture_1:PlaneTexture;
      
      private var UnknownVarFromPlaneMaterialCell_Array_1:Array;
      
      private var UnknownVarFromPlaneMaterialCell_Array_2:Array;
      
      private var UnknownVarFromPlaneMaterialCell_Int_1:int = 0;
      
      public function PlaneMaterialCell(param1:PlaneTexture, param2:Array = null, param3:Array = null, param4:int = 0)
      {
         var _loc6_:int = 0;
         var _loc7_:IGraphicAsset = null;
         var _loc5_:Point = null;
         UnknownVarFromPlaneMaterialCell_Array_1 = [];
         UnknownVarFromPlaneMaterialCell_Array_2 = [];
         super();
         UnknownVarFromPlaneMaterialCell_PlaneTexture_1 = param1;
         if(param2 != null && param2.length > 0 && param4 > 0)
         {
            _loc6_ = 0;
            _loc6_ = 0;
            while(_loc6_ < param2.length)
            {
               _loc7_ = param2[_loc6_] as IGraphicAsset;
               if(_loc7_ != null)
               {
                  UnknownVarFromPlaneMaterialCell_Array_2.push(_loc7_);
               }
               _loc6_++;
            }
            if(UnknownVarFromPlaneMaterialCell_Array_2.length > 0)
            {
               if(param3 != null)
               {
                  _loc6_ = 0;
                  while(_loc6_ < param3.length)
                  {
                     _loc5_ = param3[_loc6_] as Point;
                     if(_loc5_ != null)
                     {
                        UnknownVarFromPlaneMaterialCell_Array_1.push(new Point(_loc5_.x,_loc5_.y));
                     }
                     _loc6_++;
                  }
               }
               UnknownVarFromPlaneMaterialCell_Int_1 = param4;
            }
         }
      }
      
      public function get isStatic() : Boolean
      {
         return UnknownVarFromPlaneMaterialCell_Int_1 == 0;
      }
      
      public function dispose() : void
      {
         if(UnknownVarFromPlaneMaterialCell_PlaneTexture_1 != null)
         {
            UnknownVarFromPlaneMaterialCell_PlaneTexture_1.dispose();
            UnknownVarFromPlaneMaterialCell_PlaneTexture_1 = null;
         }
         if(UnknownVarFromPlaneMaterialCell_BitmapData_1 != null)
         {
            UnknownVarFromPlaneMaterialCell_BitmapData_1.dispose();
            UnknownVarFromPlaneMaterialCell_BitmapData_1 = null;
         }
         UnknownVarFromPlaneMaterialCell_Array_2 = null;
         UnknownVarFromPlaneMaterialCell_Array_1 = null;
      }
      
      public function clearCache() : void
      {
         if(UnknownVarFromPlaneMaterialCell_BitmapData_1 != null)
         {
            UnknownVarFromPlaneMaterialCell_BitmapData_1.dispose();
            UnknownVarFromPlaneMaterialCell_BitmapData_1 = null;
         }
      }
      
      public function getHeight(param1:IVector3d) : int
      {
         var _loc2_:BitmapData = null;
         if(UnknownVarFromPlaneMaterialCell_PlaneTexture_1 != null)
         {
            _loc2_ = UnknownVarFromPlaneMaterialCell_PlaneTexture_1.getBitmap(param1);
            if(_loc2_ != null)
            {
               return _loc2_.height;
            }
         }
         return 0;
      }
      
      public function render(param1:IVector3d, param2:int, param3:int) : BitmapData
      {
         var _loc16_:BitmapData = null;
         var _loc4_:BitmapData = null;
         var _loc20_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:Array = null;
         var _loc11_:int = 0;
         var _loc8_:Point = null;
         var _loc6_:IGraphicAsset = null;
         var _loc13_:BitmapDataAsset = null;
         var _loc14_:BitmapData = null;
         var _loc10_:Point = null;
         var _loc9_:Matrix = null;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc12_:* = 0;
         if(UnknownVarFromPlaneMaterialCell_PlaneTexture_1 != null)
         {
            _loc16_ = UnknownVarFromPlaneMaterialCell_PlaneTexture_1.getBitmap(param1);
            try
            {
               if(_loc16_ != null && (param2 != 0 || param3 != 0))
               {
                  _loc4_ = new BitmapData(_loc16_.width * 2,_loc16_.height * 2,_loc16_.transparent);
                  _loc4_.copyPixels(_loc16_,_loc16_.rect,new Point());
                  _loc4_.copyPixels(_loc16_,_loc16_.rect,new Point(_loc16_.width,0));
                  _loc4_.copyPixels(_loc16_,_loc16_.rect,new Point(0,_loc16_.height));
                  _loc4_.copyPixels(_loc16_,_loc16_.rect,new Point(_loc16_.width,_loc16_.height));
                  _loc16_ = new BitmapData(_loc16_.width,_loc16_.height,_loc16_.transparent);
                  while(param2 < 0)
                  {
                     param2 += _loc16_.width;
                  }
                  while(param3 < 0)
                  {
                     param3 += _loc16_.height;
                  }
                  _loc16_.copyPixels(_loc4_,new Rectangle(param2 % _loc16_.width,param3 % _loc16_.height,_loc16_.width,_loc16_.height),new Point());
               }
            }
            catch(e:Error)
            {
               return null;
            }
            if(_loc16_ != null)
            {
               if(!isStatic)
               {
                  if(UnknownVarFromPlaneMaterialCell_BitmapData_1 != null)
                  {
                     if(UnknownVarFromPlaneMaterialCell_BitmapData_1.width != _loc16_.width || UnknownVarFromPlaneMaterialCell_BitmapData_1.height != _loc16_.height)
                     {
                        UnknownVarFromPlaneMaterialCell_BitmapData_1.dispose();
                        UnknownVarFromPlaneMaterialCell_BitmapData_1 = null;
                     }
                     else
                     {
                        UnknownVarFromPlaneMaterialCell_BitmapData_1.copyPixels(_loc16_,_loc16_.rect,new Point(0,0));
                     }
                  }
                  if(UnknownVarFromPlaneMaterialCell_BitmapData_1 == null)
                  {
                     UnknownVarFromPlaneMaterialCell_BitmapData_1 = _loc16_.clone();
                  }
                  _loc20_ = Math.min(UnknownVarFromPlaneMaterialCell_Int_1,UnknownVarFromPlaneMaterialCell_Array_1.length);
                  _loc5_ = Math.max(UnknownVarFromPlaneMaterialCell_Int_1,UnknownVarFromPlaneMaterialCell_Array_1.length);
                  _loc7_ = Randomizer.getArray(UnknownVarFromPlaneMaterialCell_Int_1,_loc5_);
                  _loc11_ = 0;
                  while(_loc11_ < _loc20_)
                  {
                     _loc8_ = UnknownVarFromPlaneMaterialCell_Array_1[_loc7_[_loc11_]] as Point;
                     _loc6_ = UnknownVarFromPlaneMaterialCell_Array_2[_loc11_ % UnknownVarFromPlaneMaterialCell_Array_2.length] as IGraphicAsset;
                     if(_loc8_ != null && _loc6_ != null)
                     {
                        _loc13_ = _loc6_.asset as BitmapDataAsset;
                        if(_loc13_ != null)
                        {
                           _loc14_ = _loc13_.content as BitmapData;
                           if(_loc14_ != null)
                           {
                              _loc10_ = new Point(_loc8_.x + _loc6_.offsetX,_loc8_.y + _loc6_.offsetY);
                              _loc9_ = new Matrix();
                              _loc18_ = 1;
                              _loc19_ = 1;
                              _loc17_ = 0;
                              _loc15_ = 0;
                              if(_loc6_.flipH)
                              {
                                 _loc18_ = -1;
                                 _loc17_ = _loc14_.width;
                              }
                              if(_loc6_.flipV)
                              {
                                 _loc19_ = -1;
                                 _loc15_ = _loc14_.height;
                              }
                              _loc12_ = _loc10_.x + _loc17_;
                              _loc12_ = _loc12_ >> 1 << 1;
                              _loc9_.scale(_loc18_,_loc19_);
                              _loc9_.translate(_loc12_,_loc10_.y + _loc15_);
                              UnknownVarFromPlaneMaterialCell_BitmapData_1.draw(_loc14_,_loc9_);
                           }
                        }
                     }
                     _loc11_++;
                  }
                  return UnknownVarFromPlaneMaterialCell_BitmapData_1;
               }
               return _loc16_;
            }
         }
         return null;
      }
      
      public function getAssetName(param1:IVector3d) : String
      {
         return UnknownVarFromPlaneMaterialCell_PlaneTexture_1 == null ? null : UnknownVarFromPlaneMaterialCell_PlaneTexture_1.getAssetName(param1);
      }
   }
}

