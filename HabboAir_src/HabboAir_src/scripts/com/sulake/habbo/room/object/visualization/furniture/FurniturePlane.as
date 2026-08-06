package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.core.utils.Map;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class FurniturePlane
   {
      private var UnknownVarFromFurniturePlane_Int_1:int = -1;
      
      private var UnknownVarFromFurniturePlane_Number_1:Number = 0;
      
      private var UnknownVarFromFurniturePlane_Number_2:Number = 0;
      
      private var UnknownVarFromFurniturePlane_Number_3:Number = 0;
      
      private var UnknownVarFromFurniturePlane_Number_4:Number = 0;
      
      private var _origin:Vector3d = null;
      
      private var _location:Vector3d = null;
      
      private var _leftSide:Vector3d = null;
      
      private var _rightSide:Vector3d = null;
      
      private var UnknownVarFromFurniturePlane_Vector3d_1:Vector3d = null;
      
      private var UnknownVarFromFurniturePlane_Vector3d_2:Vector3d = null;
      
      private var _normal:Vector3d = null;
      
      private var _visible:Boolean = true;
      
      private var _bitmapData:BitmapData = null;
      
      private var _textures:Map = null;
      
      private var _offset:Point = null;
      
      private var _relativeDepth:Number = 0;
      
      private var _color:uint = 0;
      
      private var UnknownVarFromFurniturePlane_Boolean_1:Boolean = false;
      
      private var UnknownVarFromFurniturePlane_String_1:String = null;
      
      private var UnknownVarFromFurniturePlane_Vector3d_3:Vector3d = null;
      
      private var UnknownVarFromFurniturePlane_Vector3d_4:Vector3d = null;
      
      private var UnknownVarFromFurniturePlane_Vector3d_5:Vector3d = null;
      
      private var UnknownVarFromFurniturePlane_Vector3d_6:Vector3d = null;
      
      private var _width:Number = 0;
      
      private var UnknownVarFromFurniturePlane_Number_5:Number = 0;
      
      public function FurniturePlane(param1:IVector3d, param2:IVector3d, param3:IVector3d)
      {
         super();
         _origin = new Vector3d();
         _location = new Vector3d();
         _location.assign(param1);
         _leftSide = new Vector3d();
         _leftSide.assign(param2);
         _rightSide = new Vector3d();
         _rightSide.assign(param3);
         UnknownVarFromFurniturePlane_Vector3d_1 = new Vector3d();
         UnknownVarFromFurniturePlane_Vector3d_1.assign(param2);
         UnknownVarFromFurniturePlane_Vector3d_2 = new Vector3d();
         UnknownVarFromFurniturePlane_Vector3d_2.assign(param3);
         _normal = Vector3d.crossProduct(_leftSide,_rightSide);
         if(_normal.length > 0)
         {
            _normal.mul(1 / _normal.length);
         }
         _offset = new Point();
         UnknownVarFromFurniturePlane_Vector3d_3 = new Vector3d();
         UnknownVarFromFurniturePlane_Vector3d_4 = new Vector3d();
         UnknownVarFromFurniturePlane_Vector3d_5 = new Vector3d();
         UnknownVarFromFurniturePlane_Vector3d_6 = new Vector3d();
         _textures = new Map();
      }
      
      public function get bitmapData() : BitmapData
      {
         if(_visible)
         {
            if(_bitmapData != null)
            {
               return _bitmapData.clone();
            }
         }
         return null;
      }
      
      public function get visible() : Boolean
      {
         return _visible;
      }
      
      public function get offset() : Point
      {
         return _offset;
      }
      
      public function get relativeDepth() : Number
      {
         return _relativeDepth;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function set color(param1:uint) : void
      {
         _color = param1;
      }
      
      public function get leftSide() : IVector3d
      {
         return _leftSide;
      }
      
      public function get rightSide() : IVector3d
      {
         return _rightSide;
      }
      
      public function get location() : IVector3d
      {
         return _location;
      }
      
      public function get normal() : IVector3d
      {
         return _normal;
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BitmapData = null;
         if(_bitmapData != null)
         {
            _bitmapData.dispose();
            _bitmapData = null;
         }
         if(_textures != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _textures.length)
            {
               _loc1_ = _textures.getWithIndex(_loc2_) as BitmapData;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            _textures.dispose();
            _textures = null;
         }
         _origin = null;
         _location = null;
         _leftSide = null;
         _rightSide = null;
         UnknownVarFromFurniturePlane_Vector3d_1 = null;
         UnknownVarFromFurniturePlane_Vector3d_2 = null;
         _normal = null;
         UnknownVarFromFurniturePlane_Vector3d_3 = null;
         UnknownVarFromFurniturePlane_Vector3d_4 = null;
         UnknownVarFromFurniturePlane_Vector3d_5 = null;
         UnknownVarFromFurniturePlane_Vector3d_6 = null;
      }
      
      public function setRotation(param1:Boolean) : void
      {
         if(param1 != UnknownVarFromFurniturePlane_Boolean_1)
         {
            if(!param1)
            {
               _leftSide.assign(UnknownVarFromFurniturePlane_Vector3d_1);
               _rightSide.assign(UnknownVarFromFurniturePlane_Vector3d_2);
            }
            else
            {
               _leftSide.assign(UnknownVarFromFurniturePlane_Vector3d_1);
               _leftSide.mul(UnknownVarFromFurniturePlane_Vector3d_2.length / UnknownVarFromFurniturePlane_Vector3d_1.length);
               _rightSide.assign(UnknownVarFromFurniturePlane_Vector3d_2);
               _rightSide.mul(UnknownVarFromFurniturePlane_Vector3d_1.length / UnknownVarFromFurniturePlane_Vector3d_2.length);
            }
            UnknownVarFromFurniturePlane_Int_1 = -1;
            UnknownVarFromFurniturePlane_Number_1 -= 1;
            UnknownVarFromFurniturePlane_Boolean_1 = param1;
            resetTextureCache();
         }
      }
      
      private function cacheTexture(param1:String, param2:BitmapData) : Boolean
      {
         var _loc3_:BitmapData = _textures.remove(param1) as BitmapData;
         if(_loc3_ != null && param2 != _loc3_)
         {
            _loc3_.dispose();
         }
         _textures.add(param1,param2);
         return true;
      }
      
      private function resetTextureCache() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BitmapData = null;
         if(_textures != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _textures.length)
            {
               _loc1_ = _textures.getWithIndex(_loc2_) as BitmapData;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            _textures.reset();
         }
      }
      
      private function getTextureIdentifier(param1:IRoomGeometry) : String
      {
         if(param1 == null)
         {
            return null;
         }
         return String(param1.scale);
      }
      
      private function needsNewTexture(param1:IRoomGeometry) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:String = getTextureIdentifier(param1);
         var _loc3_:BitmapData = _textures.getValue(_loc2_) as BitmapData;
         if(_width > 0 && UnknownVarFromFurniturePlane_Number_5 > 0)
         {
            if(_loc3_ == null)
            {
               return true;
            }
         }
         return false;
      }
      
      private function getTexture(param1:IRoomGeometry, param2:int) : BitmapData
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc4_:IVector3d = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:String = getTextureIdentifier(param1);
         var _loc5_:BitmapData = null;
         if(needsNewTexture(param1))
         {
            _loc6_ = _leftSide.length * param1.scale;
            _loc7_ = _rightSide.length * param1.scale;
            if(_loc6_ < 1)
            {
               _loc6_ = 1;
            }
            if(_loc7_ < 1)
            {
               _loc7_ = 1;
            }
            _loc4_ = param1.getCoordinatePosition(_normal);
            _loc5_ = _textures.getValue(_loc3_) as BitmapData;
            if(_loc5_ == null)
            {
               _loc5_ = new BitmapData(_loc6_,_loc7_,true,4278190080 | _color);
               if(_loc5_ != null)
               {
                  cacheTexture(_loc3_,_loc5_);
               }
            }
         }
         else
         {
            _loc5_ = _textures.getValue(_loc3_) as BitmapData;
         }
         if(_loc5_ != null)
         {
            return _loc5_;
         }
         return null;
      }
      
      public function update(param1:IRoomGeometry, param2:int) : Boolean
      {
         var _loc6_:IVector3d = null;
         var _loc3_:Number = NaN;
         var _loc4_:IVector3d = null;
         var _loc5_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:BitmapData = null;
         if(param1 == null || _location == null && _origin != null || _leftSide == null || _rightSide == null || _normal == null)
         {
            return false;
         }
         var _loc9_:Boolean = false;
         if(param1.updateId != UnknownVarFromFurniturePlane_Int_1)
         {
            UnknownVarFromFurniturePlane_Int_1 = param1.updateId;
            _loc6_ = param1.direction;
            if(_loc6_ != null && (_loc6_.x != UnknownVarFromFurniturePlane_Number_1 || _loc6_.y != UnknownVarFromFurniturePlane_Number_2 || _loc6_.z != UnknownVarFromFurniturePlane_Number_3 || param1.scale != UnknownVarFromFurniturePlane_Number_4))
            {
               UnknownVarFromFurniturePlane_Number_1 = _loc6_.x;
               UnknownVarFromFurniturePlane_Number_2 = _loc6_.y;
               UnknownVarFromFurniturePlane_Number_3 = _loc6_.z;
               UnknownVarFromFurniturePlane_Number_4 = param1.scale;
               _loc9_ = true;
               _loc3_ = 0;
               _loc3_ = Vector3d.cosAngle(param1.directionAxis,normal);
               if(_loc3_ > -0.001)
               {
                  if(_visible)
                  {
                     _visible = false;
                     return true;
                  }
                  return false;
               }
               updateCorners(param1);
               _loc4_ = param1.getScreenPosition(_origin);
               _loc5_ = _loc4_.z;
               _relativeDepth = _loc7_ = Math.max(UnknownVarFromFurniturePlane_Vector3d_3.z - _loc5_,UnknownVarFromFurniturePlane_Vector3d_4.z - _loc5_,UnknownVarFromFurniturePlane_Vector3d_5.z - _loc5_,UnknownVarFromFurniturePlane_Vector3d_6.z - _loc5_);
               _visible = true;
            }
         }
         if(needsNewTexture(param1) || _loc9_)
         {
            if(_bitmapData == null || _width != _bitmapData.width || UnknownVarFromFurniturePlane_Number_5 != _bitmapData.height)
            {
               if(_bitmapData != null)
               {
                  _bitmapData.dispose();
                  _bitmapData = null;
                  if(_width < 1 || UnknownVarFromFurniturePlane_Number_5 < 1)
                  {
                     return true;
                  }
               }
               else if(_width < 1 || UnknownVarFromFurniturePlane_Number_5 < 1)
               {
                  return false;
               }
               _bitmapData = new BitmapData(_width,UnknownVarFromFurniturePlane_Number_5,true,16777215);
               _bitmapData.lock();
            }
            else
            {
               _bitmapData.lock();
               _bitmapData.fillRect(_bitmapData.rect,16777215);
            }
            _loc8_ = getTexture(param1,param2);
            if(_loc8_ != null)
            {
               renderTexture(param1,_loc8_);
            }
            _bitmapData.unlock();
            return true;
         }
         return false;
      }
      
      private function updateCorners(param1:IRoomGeometry) : void
      {
         UnknownVarFromFurniturePlane_Vector3d_3.assign(param1.getScreenPosition(_location));
         UnknownVarFromFurniturePlane_Vector3d_4.assign(param1.getScreenPosition(Vector3d.sum(_location,_rightSide)));
         UnknownVarFromFurniturePlane_Vector3d_5.assign(param1.getScreenPosition(Vector3d.sum(Vector3d.sum(_location,_leftSide),_rightSide)));
         UnknownVarFromFurniturePlane_Vector3d_6.assign(param1.getScreenPosition(Vector3d.sum(_location,_leftSide)));
         _offset = param1.getScreenPoint(_origin);
         UnknownVarFromFurniturePlane_Vector3d_3.x = Math.round(UnknownVarFromFurniturePlane_Vector3d_3.x);
         UnknownVarFromFurniturePlane_Vector3d_3.y = Math.round(UnknownVarFromFurniturePlane_Vector3d_3.y);
         UnknownVarFromFurniturePlane_Vector3d_4.x = Math.round(UnknownVarFromFurniturePlane_Vector3d_4.x);
         UnknownVarFromFurniturePlane_Vector3d_4.y = Math.round(UnknownVarFromFurniturePlane_Vector3d_4.y);
         UnknownVarFromFurniturePlane_Vector3d_5.x = Math.round(UnknownVarFromFurniturePlane_Vector3d_5.x);
         UnknownVarFromFurniturePlane_Vector3d_5.y = Math.round(UnknownVarFromFurniturePlane_Vector3d_5.y);
         UnknownVarFromFurniturePlane_Vector3d_6.x = Math.round(UnknownVarFromFurniturePlane_Vector3d_6.x);
         UnknownVarFromFurniturePlane_Vector3d_6.y = Math.round(UnknownVarFromFurniturePlane_Vector3d_6.y);
         _offset.x = Math.round(_offset.x);
         _offset.y = Math.round(_offset.y);
         var _loc3_:Number = Math.min(UnknownVarFromFurniturePlane_Vector3d_3.x,UnknownVarFromFurniturePlane_Vector3d_4.x,UnknownVarFromFurniturePlane_Vector3d_5.x,UnknownVarFromFurniturePlane_Vector3d_6.x);
         var _loc5_:Number = Math.max(UnknownVarFromFurniturePlane_Vector3d_3.x,UnknownVarFromFurniturePlane_Vector3d_4.x,UnknownVarFromFurniturePlane_Vector3d_5.x,UnknownVarFromFurniturePlane_Vector3d_6.x);
         var _loc2_:Number = Math.min(UnknownVarFromFurniturePlane_Vector3d_3.y,UnknownVarFromFurniturePlane_Vector3d_4.y,UnknownVarFromFurniturePlane_Vector3d_5.y,UnknownVarFromFurniturePlane_Vector3d_6.y);
         var _loc4_:Number = Math.max(UnknownVarFromFurniturePlane_Vector3d_3.y,UnknownVarFromFurniturePlane_Vector3d_4.y,UnknownVarFromFurniturePlane_Vector3d_5.y,UnknownVarFromFurniturePlane_Vector3d_6.y);
         _loc5_ -= _loc3_;
         _offset.x -= _loc3_;
         UnknownVarFromFurniturePlane_Vector3d_3.x -= _loc3_;
         UnknownVarFromFurniturePlane_Vector3d_4.x -= _loc3_;
         UnknownVarFromFurniturePlane_Vector3d_5.x -= _loc3_;
         UnknownVarFromFurniturePlane_Vector3d_6.x -= _loc3_;
         _loc4_ -= _loc2_;
         _offset.y -= _loc2_;
         UnknownVarFromFurniturePlane_Vector3d_3.y -= _loc2_;
         UnknownVarFromFurniturePlane_Vector3d_4.y -= _loc2_;
         UnknownVarFromFurniturePlane_Vector3d_5.y -= _loc2_;
         UnknownVarFromFurniturePlane_Vector3d_6.y -= _loc2_;
         _width = _loc5_;
         UnknownVarFromFurniturePlane_Number_5 = _loc4_;
      }
      
      private function renderTexture(param1:IRoomGeometry, param2:BitmapData) : void
      {
         if(UnknownVarFromFurniturePlane_Vector3d_3 == null || UnknownVarFromFurniturePlane_Vector3d_4 == null || UnknownVarFromFurniturePlane_Vector3d_5 == null || UnknownVarFromFurniturePlane_Vector3d_6 == null || param2 == null || _bitmapData == null)
         {
            return;
         }
         var _loc8_:Number = UnknownVarFromFurniturePlane_Vector3d_6.x - UnknownVarFromFurniturePlane_Vector3d_5.x;
         var _loc10_:Number = UnknownVarFromFurniturePlane_Vector3d_6.y - UnknownVarFromFurniturePlane_Vector3d_5.y;
         var _loc4_:Number = UnknownVarFromFurniturePlane_Vector3d_4.x - UnknownVarFromFurniturePlane_Vector3d_5.x;
         var _loc3_:Number = UnknownVarFromFurniturePlane_Vector3d_4.y - UnknownVarFromFurniturePlane_Vector3d_5.y;
         if(Math.abs(_loc4_ - param2.width) <= 1)
         {
            _loc4_ = param2.width;
         }
         if(Math.abs(_loc3_ - param2.width) <= 1)
         {
            _loc3_ = param2.width;
         }
         if(Math.abs(_loc8_ - param2.height) <= 1)
         {
            _loc8_ = param2.height;
         }
         if(Math.abs(_loc10_ - param2.height) <= 1)
         {
            _loc10_ = param2.height;
         }
         var _loc5_:Number = _loc4_ / param2.width;
         var _loc6_:Number = _loc3_ / param2.width;
         var _loc7_:Number = _loc8_ / param2.height;
         var _loc9_:Number = _loc10_ / param2.height;
         var _loc11_:Matrix = new Matrix();
         _loc11_.a = _loc5_;
         _loc11_.b = _loc6_;
         _loc11_.c = _loc7_;
         _loc11_.d = _loc9_;
         _loc11_.translate(UnknownVarFromFurniturePlane_Vector3d_5.x,UnknownVarFromFurniturePlane_Vector3d_5.y);
         draw(param2,_loc11_);
      }
      
      private function draw(param1:BitmapData, param2:Matrix) : void
      {
         var _loc4_:int = 0;
         var _loc7_:* = 0;
         var _loc3_:Number = NaN;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         if(_bitmapData != null)
         {
            if(param2.a == 1 && param2.d == 1 && param2.c == 0 && param2.b != 0 && Math.abs(param2.b) <= 1)
            {
               _loc4_ = 0;
               _loc7_ = 0;
               _loc3_ = 0;
               _loc6_ = 0;
               if(param2.b > 0)
               {
                  param2.ty++;
               }
               _loc5_ = 0;
               while(_loc4_ < param1.width)
               {
                  _loc4_++;
                  _loc3_ += Math.abs(param2.b);
                  if(_loc3_ >= 1)
                  {
                     _bitmapData.copyPixels(param1,new Rectangle(_loc7_ + _loc6_,0,_loc4_ - _loc7_,param1.height),new Point(param2.tx + _loc7_,param2.ty + _loc5_),null,null,true);
                     _loc7_ = _loc4_;
                     if(param2.b > 0)
                     {
                        _loc5_++;
                     }
                     else
                     {
                        _loc5_--;
                     }
                     _loc3_ = 0;
                  }
               }
               if(_loc3_ > 0)
               {
                  _bitmapData.copyPixels(param1,new Rectangle(_loc7_,0,_loc4_ - _loc7_,param1.height),new Point(param2.tx + _loc7_,param2.ty + _loc5_),null,null,true);
               }
               return;
            }
            _bitmapData.draw(param1,param2,null,null,null,false);
         }
      }
   }
}

