package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.catalog.viewer.widgets.BundleGridViewCatalogWidget;
   import com.sulake.habbo.habbicons.assets.HabbiconAssetManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.session.events.BadgeImageReadyEvent;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.session.product.IProductData;
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class Product extends ProductGridItem implements IProduct, UnknownIHabboRoom1
   {
      public static const EFFECT_CLASSID_NINJA_DISAPPEAR:int = 108;
      
      private var _productType:String;
      
      private var _productClassId:int;
      
      private var _extraParam:String;
      
      private var _productCount:int;
      
      private var _productData:IProductData;
      
      private var _furnitureData:IFurnitureData;
      
      private var _isUniqueLimitedItem:Boolean;
      
      private var _uniqueLimitedItemSeriesSize:int;
      
      private var _uniqueLimitedItemsLeft:int;
      
      private var UnknownVarFromProduct_IProductContainer_1:IProductContainer;
      
      public function Product(param1:String, param2:int, param3:String, param4:int, param5:IProductData, param6:IFurnitureData, param7:HabboCatalog, param8:Boolean = false, param9:int = 0, param10:int = 0)
      {
         super(param7);
         _productType = param1;
         _productClassId = param2;
         _extraParam = param3;
         _productCount = param4;
         _productData = param5;
         _furnitureData = param6;
         _isUniqueLimitedItem = param8;
         _uniqueLimitedItemSeriesSize = param9;
         _uniqueLimitedItemsLeft = param10;
      }
      
      public static function stripAddonProducts(param1:Vector.<IProduct>) : Vector.<IProduct>
      {
         var _loc2_:* = null;
         if(param1.length == 1)
         {
            return param1;
         }
         var _loc3_:Vector.<IProduct> = new Vector.<IProduct>(0);
         for each(_loc2_ in param1)
         {
            if(_loc2_.productType != "b" && !(_loc2_.productType == "e" && _loc2_.productClassId == 108) && _loc2_.productType != "chat_style")
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function get productType() : String
      {
         return _productType;
      }
      
      public function get productClassId() : int
      {
         return _productClassId;
      }
      
      public function set extraParam(param1:String) : void
      {
         _extraParam = param1;
      }
      
      public function get extraParam() : String
      {
         return _extraParam;
      }
      
      public function get productCount() : int
      {
         return _productCount;
      }
      
      public function get productData() : IProductData
      {
         return _productData;
      }
      
      public function get furnitureData() : IFurnitureData
      {
         return _furnitureData;
      }
      
      public function get isUniqueLimitedItem() : Boolean
      {
         return _isUniqueLimitedItem;
      }
      
      public function get uniqueLimitedItemSeriesSize() : int
      {
         return _uniqueLimitedItemSeriesSize;
      }
      
      public function get uniqueLimitedItemsLeft() : int
      {
         return _uniqueLimitedItemsLeft;
      }
      
      public function set uniqueLimitedItemsLeft(param1:int) : void
      {
         _uniqueLimitedItemsLeft = param1;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         _productType = "";
         _productClassId = 0;
         _extraParam = "";
         _productCount = 0;
         _productData = null;
         _furnitureData = null;
         if(catalog && catalog.sessionDataManager)
         {
            catalog.sessionDataManager.events.removeEventListener("BIRE_BADGE_IMAGE_READY",onBadgeImageReady);
         }
         HabbiconAssetManager.removeEventListener("habbicon_assets_loaded",onHabbiconAssetsLoaded);
         super.dispose();
      }
      
      public function initIcon(param1:IProductContainer, param2:UnknownIHabboRoom1 = null, param3:UnknownIHabboAvatar1 = null, param4:UnknownIHabboCatalog1 = null, param5:IBitmapWrapperController = null, param6:IStuffData = null, param7:Function = null) : BitmapData
      {
         var _loc10_:IRoomEngine = null;
         var _loc8_:UnknownHabboRoom1 = null;
         var _loc11_:String = null;
         if(disposed)
         {
            return null;
         }
         var _loc9_:BitmapData = null;
         if(param2 == null)
         {
            param2 = this;
         }
         if(param1 is BundleGridViewCatalogWidget)
         {
            _loc10_ = (param1 as BundleGridViewCatalogWidget).offer.page.viewer.roomEngine;
         }
         else
         {
            _loc10_ = (param1 as ProductContainer).offer.page.viewer.roomEngine;
         }
         if(!_loc10_ || !catalog)
         {
            return null;
         }
         switch(_productType)
         {
            case "s":
               _loc8_ = _loc10_.getFurnitureIcon(productClassId,param2,null,param6);
               break;
            case "i":
               if(param4 && _furnitureData)
               {
                  _loc11_ = "";
                  switch(_furnitureData.className)
                  {
                     case "floor":
                        _loc11_ = ["th",_furnitureData.className,param4.product.extraParam].join("_");
                        break;
                     case "wallpaper":
                        _loc11_ = ["th","wall",param4.product.extraParam].join("_");
                        break;
                     case "landscape":
                        _loc11_ = ["th",_furnitureData.className,param4.product.extraParam.replace(".","_"),"001"].join("_");
                        break;
                     default:
                        _loc8_ = _loc10_.getWallItemIcon(productClassId,param2,_extraParam);
                  }
                  catalog.setImageFromAsset(param5,_loc11_,param7);
               }
               else
               {
                  _loc8_ = _loc10_.getWallItemIcon(productClassId,param2,_extraParam);
               }
               break;
            case "e":
               _loc9_ = catalog.getPixelEffectIcon(productClassId);
               if(param2 == this)
               {
                  this.setIconImage(_loc9_,true);
               }
               break;
            case "h":
               _loc9_ = catalog.getSubscriptionProductIcon(productClassId);
               break;
            case "b":
               catalog.sessionDataManager.events.addEventListener("BIRE_BADGE_IMAGE_READY",onBadgeImageReady);
               _loc9_ = catalog.sessionDataManager.getBadgeImage(_extraParam);
               UnknownVarFromProduct_IProductContainer_1 = param1;
               break;
            case "r":
               _loc9_ = renderAvatarImage(_extraParam,param3);
               setIconImage(_loc9_,false);
               break;
            case "chat_style":
               _loc9_ = catalog.freeFlowChat.chatStyleLibrary.getStyle(int(_extraParam)).selectorPreview.clone();
               break;
            case "habbicon":
               _loc9_ = getHabbiconPreviewBitmap();
               if(_loc9_ == null)
               {
                  HabbiconAssetManager.addEventListener("habbicon_assets_loaded",onHabbiconAssetsLoaded);
                  _loc9_ = new BitmapData(40,40,false,9408399);
               }
               if(param2 == this)
               {
                  this.setIconImage(_loc9_,true);
               }
               break;
            default:
               Logger.log("[Product] Can not yet handle this type of product: " + productType);
         }
         if(_loc8_ != null)
         {
            _loc9_ = _loc8_.data;
            if(param2 == this)
            {
               this.setIconImage(_loc9_,true);
            }
         }
         return _loc9_;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(!disposed)
         {
            setIconImage(param2,true);
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function onBadgeImageReady(param1:BadgeImageReadyEvent) : void
      {
         if(!disposed)
         {
            if(_productType == "b" && param1.badgeId == _extraParam)
            {
               ProductGridItem(UnknownVarFromProduct_IProductContainer_1).setIconImage(param1.badgeImage,false);
               if(catalog && catalog.sessionDataManager)
               {
                  catalog.sessionDataManager.events.removeEventListener("BIRE_BADGE_IMAGE_READY",onBadgeImageReady);
               }
            }
         }
      }
      
      private function onHabbiconAssetsLoaded(param1:Event) : void
      {
         if(disposed || _productType != "habbicon")
         {
            return;
         }
         var _loc2_:BitmapData = getHabbiconPreviewBitmap();
         if(_loc2_ != null)
         {
            setIconImage(_loc2_,true);
            HabbiconAssetManager.removeEventListener("habbicon_assets_loaded",onHabbiconAssetsLoaded);
         }
      }
      
      private function getHabbiconPreviewBitmap() : BitmapData
      {
         var _loc1_:BitmapData = HabbiconAssetManager.getPreviewBitmap(int(_extraParam),false);
         return _loc1_ != null ? _loc1_.clone() : null;
      }
      
      public function get isColorable() : Boolean
      {
         if(_furnitureData && _furnitureData.fullName)
         {
            return _furnitureData.fullName.indexOf("*") != -1;
         }
         return false;
      }
      
      override public function set view(param1:IWindowController_1) : void
      {
         var _loc2_:IWindowModel = null;
         var _loc3_:ITextWindow = null;
         if(!param1)
         {
            return;
         }
         super.view = param1;
         if(_productCount > 1)
         {
            _loc2_ = _view.findChildByName("multiContainer");
            if(_loc2_)
            {
               _loc2_.visible = true;
            }
            _loc3_ = _view.findChildByName("multiCounter") as ITextWindow;
            if(_loc3_)
            {
               _loc3_.text = "x" + productCount;
            }
         }
      }
   }
}

