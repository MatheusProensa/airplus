package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.window.utils.ChildEntityArray;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils3;
   import flash.geom.Rectangle;
   
   public class SkinLayout extends ChildEntityArray implements ISkinLayout
   {
      protected var _name:String;
      
      protected var _width:uint;
      
      protected var _height:uint;
      
      protected var _blendMode:String;
      
      protected var _transparent:Boolean;
      
      public function SkinLayout(param1:String, param2:Boolean, param3:String)
      {
         super();
         _name = param1;
         _width = 0;
         _height = 0;
         _blendMode = param3;
         _transparent = param2;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get width() : uint
      {
         return _width;
      }
      
      public function get height() : uint
      {
         return _height;
      }
      
      public function get blendMode() : String
      {
         return _blendMode;
      }
      
      public function get transparent() : Boolean
      {
         return _transparent;
      }
      
      public function dispose() : void
      {
         var _loc2_:* = 0;
         var _loc1_:uint = uint(numChildren);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            SkinLayoutEntity(removeChildAt(0)).dispose();
            _loc2_++;
         }
      }
      
      public function calculateActualRect(param1:Rectangle) : void
      {
         var _loc5_:SkinLayoutEntity = null;
         var _loc3_:* = 0;
         var _loc4_:Rectangle = null;
         var _loc2_:uint = uint(numChildren);
         param1.x = 4294967295;
         param1.y = 4294967295;
         param1.width = 0;
         param1.height = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = getChildAt(_loc3_) as SkinLayoutEntity;
            _loc4_ = _loc5_.region;
            if(_loc4_.left < param1.left)
            {
               param1.left = _loc4_.left;
            }
            if(_loc4_.top < param1.top)
            {
               param1.top = _loc4_.top;
            }
            if(_loc4_.right > param1.right)
            {
               param1.right = _loc4_.right;
            }
            if(_loc4_.bottom > param1.bottom)
            {
               param1.bottom = _loc4_.bottom;
            }
            _loc3_++;
         }
      }
      
      public function isFixedWidth() : Boolean
      {
         var _loc2_:* = 0;
         var _loc1_:uint = uint(numChildren);
         if(_loc1_ == 0)
         {
            return false;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(SkinLayoutEntity(getChildAt(_loc2_)).scaleH != 0)
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      public function calculateWidth() : uint
      {
         var _loc4_:Rectangle = null;
         var _loc3_:* = 0;
         var _loc2_:uint = 0;
         var _loc1_:uint = uint(numChildren);
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            _loc4_ = SkinLayoutEntity(getChildAt(_loc3_)).region;
            if(_loc4_.right > _loc2_)
            {
               _loc2_ = _loc4_.right;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function isFixedHeight() : Boolean
      {
         var _loc2_:* = 0;
         var _loc1_:uint = uint(numChildren);
         if(_loc1_ == 0)
         {
            return false;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(SkinLayoutEntity(getChildAt(_loc2_)).scaleV != 0)
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      public function calculateHeight() : uint
      {
         var _loc3_:Rectangle = null;
         var _loc2_:* = 0;
         var _loc4_:uint = 0;
         var _loc1_:uint = uint(numChildren);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = SkinLayoutEntity(getChildAt(_loc2_)).region;
            if(_loc3_.bottom > _loc4_)
            {
               _loc4_ = _loc3_.bottom;
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      public function getDefaultRegion(param1:String, param2:Rectangle) : void
      {
         var _loc3_:SkinLayoutEntity = getChildByName(param1) as SkinLayoutEntity;
         if(_loc3_ == null)
         {
            throw new Error("Entity not found: " + param1 + "!");
         }
         param2.x = _loc3_.region.x;
         param2.y = _loc3_.region.y;
         param2.width = _loc3_.region.width;
         param2.height = _loc3_.region.height;
      }
      
      override public function addChild(param1:UnknownICoreWindowUtils3) : UnknownICoreWindowUtils3
      {
         var _loc2_:SkinLayoutEntity = SkinLayoutEntity(param1);
         _width = _loc2_.region.right > _width ? _loc2_.region.right : _width;
         _height = _loc2_.region.bottom > _height ? _loc2_.region.bottom : _height;
         return super.addChild(param1);
      }
      
      override public function addChildAt(param1:UnknownICoreWindowUtils3, param2:int) : UnknownICoreWindowUtils3
      {
         var _loc3_:SkinLayoutEntity = SkinLayoutEntity(param1);
         _width = _loc3_.region.right > _width ? _loc3_.region.right : _width;
         _height = _loc3_.region.bottom > _height ? _loc3_.region.bottom : _height;
         return super.addChildAt(param1,param2);
      }
      
      override public function removeChild(param1:UnknownICoreWindowUtils3) : UnknownICoreWindowUtils3
      {
         super.removeChild(param1);
         _width = calculateWidth();
         _height = calculateHeight();
         return param1;
      }
      
      override public function removeChildAt(param1:int) : UnknownICoreWindowUtils3
      {
         var _loc2_:UnknownICoreWindowUtils3 = super.removeChildAt(param1);
         _width = calculateWidth();
         _height = calculateHeight();
         return _loc2_;
      }
   }
}

