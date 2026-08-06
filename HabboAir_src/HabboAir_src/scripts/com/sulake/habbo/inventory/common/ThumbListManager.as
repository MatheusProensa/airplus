package com.sulake.habbo.inventory.common
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.habbo.inventory.IThumbListDrawableItem;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ThumbListManager
   {
      private var UnknownVarFromThumbListManager_IThumbListDataProvider_1:IThumbListDataProvider;
      
      private var UnknownVarFromThumbListManager_Int_1:int;
      
      private var UnknownVarFromThumbListManager_Int_2:int = 1;
      
      private var _listImage:BitmapData;
      
      private var UnknownVarFromThumbListManager_Int_3:int;
      
      private var _listItemWidth:int;
      
      private var _viewWidth:int;
      
      private var UnknownVarFromThumbListManager_Int_4:int;
      
      private var _thumbWidth:int;
      
      private var UnknownVarFromThumbListManager_Int_5:int;
      
      private var UnknownVarFromThumbListManager_BitmapData_1:BitmapData;
      
      private var UnknownVarFromThumbListManager_BitmapData_2:BitmapData;
      
      public function ThumbListManager(param1:IAssetLibraryCollection, param2:IThumbListDataProvider, param3:String, param4:String, param5:int, param6:int)
      {
         super();
         UnknownVarFromThumbListManager_IThumbListDataProvider_1 = param2;
         var _loc7_:BitmapDataAsset = BitmapDataAsset(param1.getAssetByName(param3));
         if(_loc7_ != null)
         {
            UnknownVarFromThumbListManager_BitmapData_1 = BitmapData(_loc7_.content);
         }
         var _loc8_:BitmapDataAsset = BitmapDataAsset(param1.getAssetByName(param4));
         if(_loc8_ != null)
         {
            UnknownVarFromThumbListManager_BitmapData_2 = BitmapData(_loc8_.content);
         }
         _thumbWidth = UnknownVarFromThumbListManager_BitmapData_1.width;
         UnknownVarFromThumbListManager_Int_5 = UnknownVarFromThumbListManager_BitmapData_1.height;
         _viewWidth = param5;
         UnknownVarFromThumbListManager_Int_4 = param6;
         UnknownVarFromThumbListManager_Int_1 = Math.floor(_viewWidth / _thumbWidth);
         _listImage = new BitmapData(_viewWidth,UnknownVarFromThumbListManager_Int_4);
      }
      
      public function dispose() : void
      {
         UnknownVarFromThumbListManager_IThumbListDataProvider_1 = null;
         _listImage = null;
      }
      
      public function updateImageFromList() : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:IThumbListDrawableItem = null;
         var _loc2_:BitmapData = null;
         UnknownVarFromThumbListManager_Int_2 = resolveRowCountFromList();
         if(UnknownVarFromThumbListManager_Int_2 == 0)
         {
            _listImage = new BitmapData(_viewWidth,UnknownVarFromThumbListManager_Int_4);
            return;
         }
         _listImage = new BitmapData(Math.max(UnknownVarFromThumbListManager_Int_1 * _thumbWidth,_viewWidth),Math.max(UnknownVarFromThumbListManager_Int_2 * UnknownVarFromThumbListManager_Int_5,UnknownVarFromThumbListManager_Int_4),true,16777215);
         _listImage.fillRect(_listImage.rect,4294967295);
         var _loc6_:int = 0;
         var _loc4_:Array = getList();
         _loc5_ = 0;
         while(_loc5_ < UnknownVarFromThumbListManager_Int_2)
         {
            _loc3_ = 0;
            while(_loc3_ < UnknownVarFromThumbListManager_Int_1)
            {
               if(_loc6_ < _loc4_.length)
               {
                  _loc1_ = _loc4_[_loc6_];
                  if(_loc1_ != null)
                  {
                     _loc2_ = createThumbImage(_loc1_.iconImage,_loc1_.isSelected);
                     _listImage.copyPixels(_loc2_,_loc2_.rect,new Point(_loc3_ * _thumbWidth,_loc5_ * UnknownVarFromThumbListManager_Int_5),null,null,true);
                  }
                  _loc6_++;
               }
               _loc3_++;
            }
            _loc5_++;
         }
      }
      
      public function addItemAsFirst(param1:IThumbListDrawableItem) : void
      {
         var _loc2_:BitmapData = null;
         var _loc4_:Rectangle = null;
         if(param1 == null)
         {
            return;
         }
         var _loc5_:Point = resolveLastItemGridLoc();
         if(_loc5_.x == UnknownVarFromThumbListManager_Int_1 && _listImage.height < _loc5_.y * UnknownVarFromThumbListManager_Int_5)
         {
            _loc2_ = new BitmapData(_listImage.width,_listImage.height + UnknownVarFromThumbListManager_Int_5);
         }
         else
         {
            _loc2_ = new BitmapData(_listImage.width,_listImage.height);
         }
         var _loc3_:BitmapData = createThumbImage(param1.iconImage,param1.isSelected);
         _loc2_.copyPixels(_loc3_,_loc3_.rect,new Point(0,0),null,null,true);
         _loc4_ = new Rectangle(0,0,_thumbWidth * (UnknownVarFromThumbListManager_Int_1 - 1),UnknownVarFromThumbListManager_Int_5);
         _loc2_.copyPixels(_listImage,_loc4_,new Point(_thumbWidth,0),null,null,true);
         _loc4_ = new Rectangle(_thumbWidth * (UnknownVarFromThumbListManager_Int_1 - 1),0,_thumbWidth,_listImage.height);
         _loc2_.copyPixels(_listImage,_loc4_,new Point(0,UnknownVarFromThumbListManager_Int_5),null,null,true);
         _loc4_ = new Rectangle(0,UnknownVarFromThumbListManager_Int_5,_thumbWidth * (UnknownVarFromThumbListManager_Int_1 - 1),_listImage.height - UnknownVarFromThumbListManager_Int_5);
         _loc2_.copyPixels(_listImage,_loc4_,new Point(_thumbWidth,UnknownVarFromThumbListManager_Int_5),null,null,true);
         _listImage = _loc2_;
      }
      
      public function replaceItemImage(param1:int, param2:IThumbListDrawableItem) : void
      {
         if(param2 == null)
         {
            return;
         }
         var _loc4_:Point = resolveGridLocationFromIndex(param1);
         var _loc5_:Point = new Point(_loc4_.x * _thumbWidth,_loc4_.y * UnknownVarFromThumbListManager_Int_5);
         var _loc3_:BitmapData = createThumbImage(param2.iconImage,param2.isSelected);
         _listImage.copyPixels(_loc3_,_loc3_.rect,_loc5_,null,null,true);
      }
      
      public function getListImage() : BitmapData
      {
         return _listImage;
      }
      
      public function removeItemInIndex(param1:int) : void
      {
         var _loc2_:Point = resolveGridLocationFromIndex(param1);
         removeItemInImage(_loc2_);
      }
      
      public function removeItemInLocation(param1:Point) : void
      {
         var _loc2_:Point = resolveGridLocationFromImage(param1);
         removeItemInImage(_loc2_);
      }
      
      public function updateListItem(param1:int) : void
      {
         var _loc2_:IThumbListDrawableItem = getDrawableItem(param1);
         replaceItemImage(param1,_loc2_);
      }
      
      private function getList() : Array
      {
         var _loc1_:Array = null;
         if(UnknownVarFromThumbListManager_IThumbListDataProvider_1 != null)
         {
            _loc1_ = UnknownVarFromThumbListManager_IThumbListDataProvider_1.getDrawableList();
         }
         return !!_loc1_ ? _loc1_ : [];
      }
      
      private function getDrawableItem(param1:int) : IThumbListDrawableItem
      {
         var _loc2_:Array = getList();
         if(param1 >= 0 && param1 < _loc2_.length)
         {
            return _loc2_[param1] as IThumbListDrawableItem;
         }
         return null;
      }
      
      private function resolveRowCountFromList() : int
      {
         var _loc1_:Array = getList();
         return int(Math.ceil(_loc1_.length / UnknownVarFromThumbListManager_Int_1));
      }
      
      private function resolveLastItemGridLoc() : Point
      {
         var _loc2_:Array = getList();
         return resolveGridLocationFromIndex(_loc2_.length - 1);
      }
      
      public function resolveIndexFromImageLocation(param1:Point) : int
      {
         var _loc3_:Point = resolveGridLocationFromImage(param1);
         return int(_loc3_.y * UnknownVarFromThumbListManager_Int_1 + _loc3_.x);
      }
      
      private function resolveGridLocationFromImage(param1:Point) : Point
      {
         var _loc2_:int = Math.floor(param1.y / UnknownVarFromThumbListManager_Int_5);
         var _loc3_:int = Math.floor(param1.x / _thumbWidth);
         return new Point(_loc3_,_loc2_);
      }
      
      private function resolveGridLocationFromIndex(param1:int) : Point
      {
         var _loc2_:int = Math.floor(param1 / UnknownVarFromThumbListManager_Int_1);
         var _loc3_:int = param1 % UnknownVarFromThumbListManager_Int_1;
         return new Point(_loc3_,_loc2_);
      }
      
      private function removeItemInImage(param1:Point) : void
      {
         var _loc7_:Rectangle = null;
         var _loc3_:Point = null;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:BitmapData = null;
         var _loc9_:BitmapData = null;
         var _loc5_:BitmapData = null;
         var _loc12_:BitmapData = null;
         if(param1.x >= UnknownVarFromThumbListManager_Int_1)
         {
            return;
         }
         if(param1.y >= UnknownVarFromThumbListManager_Int_2)
         {
            return;
         }
         var _loc11_:int = UnknownVarFromThumbListManager_Int_1 - param1.x - 1;
         _loc7_ = new Rectangle((param1.x + 1) * _thumbWidth,param1.y * UnknownVarFromThumbListManager_Int_5,_loc11_ * _thumbWidth,UnknownVarFromThumbListManager_Int_5);
         _loc3_ = new Point(param1.x * _thumbWidth,param1.y * UnknownVarFromThumbListManager_Int_5);
         var _loc4_:BitmapData = new BitmapData(_loc7_.width + _thumbWidth,_loc7_.height);
         _loc4_.fillRect(_loc4_.rect,4294967295);
         _loc4_.copyPixels(_listImage,_loc7_,new Point(0,0),null,null,true);
         _listImage.copyPixels(_loc4_,_loc4_.rect,_loc3_,null,null,true);
         if(param1.y < UnknownVarFromThumbListManager_Int_2 - 1)
         {
            _loc6_ = _listImage.width - _thumbWidth;
            _loc8_ = _listImage.height - (param1.y + 1) * UnknownVarFromThumbListManager_Int_5;
            _loc2_ = new BitmapData(_loc6_,_loc8_);
            _loc7_ = new Rectangle(_thumbWidth,(param1.y + 1) * UnknownVarFromThumbListManager_Int_5,_loc2_.width,_loc2_.height);
            _loc2_.copyPixels(_listImage,_loc7_,new Point(0,0),null,null,true);
            _loc9_ = new BitmapData(_thumbWidth,_loc7_.height);
            _loc7_.x = 0;
            _loc7_.width = _thumbWidth;
            _loc9_.copyPixels(_listImage,_loc7_,new Point(0,0),null,null,true);
            _listImage.fillRect(new Rectangle(0,_listImage.height - UnknownVarFromThumbListManager_Int_5,_listImage.width,UnknownVarFromThumbListManager_Int_5),4294967295);
            _loc3_ = new Point(_listImage.width - _thumbWidth,_loc7_.y - UnknownVarFromThumbListManager_Int_5);
            _listImage.copyPixels(_loc9_,_loc9_.rect,_loc3_,null,null,true);
            _loc3_ = new Point(0,_loc7_.y);
            _listImage.copyPixels(_loc2_,_loc2_.rect,_loc3_,null,null,true);
         }
         var _loc10_:int = getList().length - 1;
         if(_loc10_ > 0)
         {
            param1 = resolveGridLocationFromIndex(_loc10_);
            if(param1.x == UnknownVarFromThumbListManager_Int_1 - 1)
            {
               _loc5_ = new BitmapData(_listImage.width,_listImage.height - UnknownVarFromThumbListManager_Int_5);
               _loc7_ = new Rectangle(0,0,_listImage.width,_listImage.height - UnknownVarFromThumbListManager_Int_5);
               _loc5_.copyPixels(_listImage,_loc7_,new Point(0,0),null,null,true);
               _listImage = _loc5_;
               UnknownVarFromThumbListManager_Int_2--;
            }
         }
         if(_listImage.height < UnknownVarFromThumbListManager_Int_4)
         {
            _loc12_ = new BitmapData(_listImage.width,UnknownVarFromThumbListManager_Int_4);
            _loc12_.fillRect(_loc12_.rect,4294967295);
            _loc12_.copyPixels(_listImage,_listImage.rect,new Point(0,0),null,null,true);
            _listImage = _loc12_;
         }
      }
      
      private function createThumbImage(param1:BitmapData = null, param2:Boolean = false) : BitmapData
      {
         var _loc3_:Point = null;
         var _loc4_:BitmapData = new BitmapData(UnknownVarFromThumbListManager_BitmapData_1.width,UnknownVarFromThumbListManager_BitmapData_1.height);
         if(param2)
         {
            _loc4_.copyPixels(UnknownVarFromThumbListManager_BitmapData_2,UnknownVarFromThumbListManager_BitmapData_1.rect,new Point(0,0),null,null,false);
         }
         else
         {
            _loc4_.copyPixels(UnknownVarFromThumbListManager_BitmapData_1,UnknownVarFromThumbListManager_BitmapData_1.rect,new Point(0,0),null,null,false);
         }
         if(param1 != null)
         {
            _loc3_ = new Point((_loc4_.width - param1.width) / 2,(_loc4_.height - param1.height) / 2);
            _loc4_.copyPixels(param1,param1.rect,_loc3_,null,null,true);
         }
         return _loc4_;
      }
   }
}

