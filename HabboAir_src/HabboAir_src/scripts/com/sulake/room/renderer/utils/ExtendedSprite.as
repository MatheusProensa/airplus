package com.sulake.room.renderer.utils
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   [SecureSWF(rename="true")]
   public class ExtendedSprite extends Bitmap
   {
      private var _alphaTolerance:int = 128;
      
      private var _basePoint:Point;
      
      private var _tag:String = "";
      
      private var _identifier:String = "";
      
      private var _clickHandling:Boolean = false;
      
      private var _skipMouseHandling:Boolean = false;
      
      private var _varyingDepth:Boolean = false;
      
      private var _bitmapData:ExtendedBitmapData = null;
      
      private var _width:int = 0;
      
      private var UnknownVarFromExtendedSprite_Int_1:int = 0;
      
      private var _updateID1:int = -1;
      
      private var _updateID2:int = -1;
      
      private var _offsetRefX:int = 0;
      
      private var _offsetRefY:int = 0;
      
      public function ExtendedSprite()
      {
         super();
         _basePoint = new Point();
         cacheAsBitmap = false;
      }
      
      public function get alphaTolerance() : int
      {
         return _alphaTolerance;
      }
      
      public function set alphaTolerance(param1:int) : void
      {
         _alphaTolerance = param1;
      }
      
      public function get tag() : String
      {
         return _tag;
      }
      
      public function set tag(param1:String) : void
      {
         _tag = param1;
      }
      
      public function get identifier() : String
      {
         return _identifier;
      }
      
      public function set identifier(param1:String) : void
      {
         _identifier = param1;
      }
      
      public function get varyingDepth() : Boolean
      {
         return _varyingDepth;
      }
      
      public function set varyingDepth(param1:Boolean) : void
      {
         _varyingDepth = param1;
      }
      
      public function get clickHandling() : Boolean
      {
         return _clickHandling;
      }
      
      public function set clickHandling(param1:Boolean) : void
      {
         _clickHandling = param1;
      }
      
      public function get skipMouseHandling() : Boolean
      {
         return _skipMouseHandling;
      }
      
      public function set skipMouseHandling(param1:Boolean) : void
      {
         _skipMouseHandling = param1;
      }
      
      public function get offsetRefX() : int
      {
         return _offsetRefX;
      }
      
      public function set offsetRefX(param1:int) : void
      {
         _offsetRefX = param1;
      }
      
      public function get offsetRefY() : int
      {
         return _offsetRefY;
      }
      
      public function set offsetRefY(param1:int) : void
      {
         _offsetRefY = param1;
      }
      
      public function dispose() : void
      {
         if(_bitmapData != null)
         {
            _bitmapData.dispose();
            _bitmapData = null;
         }
      }
      
      override public function set bitmapData(param1:BitmapData) : void
      {
         var _loc2_:ExtendedBitmapData = null;
         if(param1 == bitmapData)
         {
            return;
         }
         if(_bitmapData != null)
         {
            _bitmapData.dispose();
            _bitmapData = null;
         }
         if(param1 != null)
         {
            _width = param1.width;
            UnknownVarFromExtendedSprite_Int_1 = param1.height;
            _loc2_ = param1 as ExtendedBitmapData;
            if(_loc2_ != null)
            {
               _loc2_.addReference();
               _bitmapData = _loc2_;
            }
         }
         else
         {
            _width = 0;
            UnknownVarFromExtendedSprite_Int_1 = 0;
            _updateID1 = -1;
            _updateID2 = -1;
         }
         super.bitmapData = param1;
      }
      
      public function needsUpdate(param1:int, param2:int) : Boolean
      {
         if(param1 != _updateID1 || param2 != _updateID2)
         {
            _updateID1 = param1;
            _updateID2 = param2;
            return true;
         }
         if(_bitmapData != null && _bitmapData.disposed)
         {
            return true;
         }
         return false;
      }
      
      override public function hitTestPoint(param1:Number, param2:Number, param3:Boolean = false) : Boolean
      {
         return hitTest(param1,param2);
      }
      
      public function hitTest(param1:Number, param2:Number) : Boolean
      {
         if(_alphaTolerance > 255 || bitmapData == null)
         {
            return false;
         }
         if(param1 < 0 || param2 < 0 || param1 >= _width || param2 >= UnknownVarFromExtendedSprite_Int_1)
         {
            return false;
         }
         return hitTestBitmapData(int(param1),int(param2));
      }
      
      private function hitTestBitmapData(param1:int, param2:int) : Boolean
      {
         var _loc4_:* = 0;
         var _loc3_:* = false;
         try
         {
            _loc4_ = bitmapData.getPixel32(param1,param2);
            _loc4_ = uint(_loc4_ >> 24);
            _loc3_ = _loc4_ > _alphaTolerance;
         }
         catch(e:Error)
         {
         }
         return _loc3_;
      }
   }
}

