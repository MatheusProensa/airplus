package com.sulake.habbo.window.utils
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class LimitedItemOverlayNumberBitmapGenerator
   {
      private static const GLYPH_ASSET_PREFIX:String = "unique_item_number_glyph_";
      
      public function LimitedItemOverlayNumberBitmapGenerator()
      {
         super();
      }
      
      public static function createBitmap(param1:IAssetLibraryCollection, param2:int, param3:int, param4:int) : BitmapData
      {
         var _loc16_:BitmapDataAsset = null;
         var _loc7_:int = 0;
         var _loc10_:BitmapData = new BitmapData(param3,param4,true,0);
         if(param2 < 0 || param2 > 999999)
         {
            return _loc10_;
         }
         var _loc13_:int = param2 % 10;
         var _loc5_:int = param2 / 10 % 10;
         var _loc15_:int = param2 / 100 % 10;
         var _loc8_:int = param2 / 1000 % 10;
         var _loc14_:int = param2 / 10000 % 10;
         var _loc6_:int = param2 / 100000 % 10;
         var _loc11_:Array = [];
         var _loc12_:int = 0;
         if(_loc6_ > 0)
         {
            _loc16_ = BitmapDataAsset(param1.getAssetByName("unique_item_number_glyph_" + _loc6_));
            _loc11_.push(_loc16_);
            _loc12_ += _loc16_.rectangle.width;
         }
         if(_loc6_ > 0 || _loc14_ > 0)
         {
            _loc16_ = BitmapDataAsset(param1.getAssetByName("unique_item_number_glyph_" + _loc14_));
            _loc11_.push(_loc16_);
            _loc12_ += _loc16_.rectangle.width;
         }
         if(_loc6_ > 0 || _loc14_ > 0 || _loc8_ > 0)
         {
            _loc16_ = BitmapDataAsset(param1.getAssetByName("unique_item_number_glyph_" + _loc8_));
            _loc11_.push(_loc16_);
            _loc12_ += _loc16_.rectangle.width;
         }
         if(_loc6_ > 0 || _loc14_ > 0 || _loc8_ > 0 || _loc15_ > 0)
         {
            _loc16_ = BitmapDataAsset(param1.getAssetByName("unique_item_number_glyph_" + _loc15_));
            _loc11_.push(_loc16_);
            _loc12_ += _loc16_.rectangle.width;
         }
         if(_loc6_ > 0 || _loc14_ > 0 || _loc8_ > 0 || _loc15_ > 0 || _loc5_ > 0)
         {
            _loc16_ = BitmapDataAsset(param1.getAssetByName("unique_item_number_glyph_" + _loc5_));
            _loc11_.push(_loc16_);
            _loc12_ += _loc16_.rectangle.width;
         }
         _loc16_ = BitmapDataAsset(param1.getAssetByName("unique_item_number_glyph_" + _loc13_));
         _loc11_.push(_loc16_);
         _loc12_ += _loc16_.rectangle.width;
         _loc12_ = _loc12_ - 1;
         var _loc9_:Point = new Point((param3 - _loc12_) / 2,0);
         while(_loc7_ < _loc11_.length)
         {
            _loc16_ = _loc11_[_loc7_];
            _loc10_.copyPixels(BitmapData(_loc16_.content),_loc16_.rectangle,_loc9_);
            _loc9_.x += _loc16_.rectangle.width;
            _loc7_++;
         }
         return _loc10_;
      }
   }
}

