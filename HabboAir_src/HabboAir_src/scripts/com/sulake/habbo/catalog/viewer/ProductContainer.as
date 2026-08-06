package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.catalog.purse.ActivityPointTypeEnum;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import flash.display.BitmapData;
   
   public class ProductContainer extends ProductGridItem implements UnknownIHabboRoom1, IProductContainer, IProductGridItem, UnknownIHabboAvatar1
   {
      private static const ELEMENT_TOTAL_PRICE_CONTAINER:String = "totalprice_container";
      
      private static const UnknownConstFromProductContainer_String_1:String = "amount_text_left";
      
      private static const ELEMENT_AMOUNT_TEXT_RIGHT:String = "amount_text_right";
      
      private static const ELEMENT_CURRENCY_INDICATOR_BITMAP_RIGHT:String = "currency_indicator_bitmap_right";
      
      protected var _offer:UnknownIHabboCatalog1;
      
      protected var _products:Vector.<IProduct>;
      
      public function ProductContainer(param1:UnknownIHabboCatalog1, param2:Vector.<IProduct>, param3:HabboCatalog)
      {
         var _loc5_:String = null;
         super(param3);
         for each(var _loc4_ in param2)
         {
            if(_loc4_.productType != "b")
            {
               _loc5_ = _loc4_.extraParam;
               break;
            }
         }
         _offer = param1;
         _products = param2;
      }
      
      public function get products() : Vector.<IProduct>
      {
         return _products;
      }
      
      public function get firstProduct() : IProduct
      {
         if(!_products || _products.length == 0)
         {
            return null;
         }
         if(_products.length == 1)
         {
            return _products[0];
         }
         if(_products.length == 2 && (_products[1].productType == "b" || _products[0].productType == "b"))
         {
            return _products[0].productType == "b" ? _products[1] : _products[0];
         }
         var _loc1_:Vector.<IProduct> = Product.stripAddonProducts(_products);
         return _loc1_.length > 0 ? _loc1_[0] : null;
      }
      
      public function get offer() : UnknownIHabboCatalog1
      {
         return _offer;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         for each(var _loc1_ in _products)
         {
            _loc1_.dispose();
         }
         _products = null;
         super.dispose();
      }
      
      public function get isLazy() : Boolean
      {
         return false;
      }
      
      public function initProductIcon(param1:IRoomEngine, param2:IStuffData = null) : void
      {
      }
      
      override public function set view(param1:IWindowController_1) : void
      {
         var _loc3_:int = 0;
         var _loc2_:IProduct = null;
         super.view = param1;
         if(_view == null)
         {
            return;
         }
         if(catalog && (_offer.badgeCode && _offer.badgeCode != "" || _offer.extraChatStyleCode && _offer.extraChatStyleCode != "") && _offer.productContainer.products.length > 1)
         {
            setAddOnIcon("catalog_icon_badge_included");
         }
         else if(catalog && _offer.productContainer.products.length == 2)
         {
            _loc3_ = 0;
            while(_loc3_ < 2)
            {
               _loc2_ = _offer.productContainer.products[_loc3_];
               if(_loc2_.productType == "e" && _loc2_.productClassId == 108)
               {
                  setAddOnIcon("catalog_icon_ninja_effect_included");
               }
               _loc3_++;
            }
         }
         setClubIconLevel(offer.clubLevel);
         if(catalog.isDraggable(offer))
         {
            setDraggable(true);
         }
      }
      
      private function setAddOnIcon(param1:String) : void
      {
         var _loc3_:IBitmapWrapperController = _view.findChildByName("badge_add_on") as IBitmapWrapperController;
         var _loc4_:ISoundAsset = catalog.assets.getAssetByName(param1);
         _loc3_.bitmap = _loc4_.content as BitmapData;
         var _loc2_:BitmapData = _loc4_.content as BitmapData;
         _loc3_.width = _loc2_.width;
         _loc3_.height = _loc2_.height;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         setIconImage(param2,true);
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      public function setClubIconLevel(param1:int) : void
      {
         if(view == null)
         {
            return;
         }
         var _loc2_:IWindowModel = view.findChildByName("clubLevelIcon");
         if(_loc2_ == null)
         {
            return;
         }
         switch(offer.clubLevel)
         {
            case 0:
               _loc2_.visible = false;
               break;
            case 1:
               _loc2_.visible = true;
               _loc2_.style = 11;
               _loc2_.x += 3;
               break;
            case 2:
               _loc2_.visible = true;
               _loc2_.style = 12;
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(!disposed)
         {
            for each(var _loc2_ in products)
            {
               if(_loc2_.productType == "r" && _loc2_.extraParam == param1)
               {
                  setIconImage(renderAvatarImage(_loc2_.extraParam,this),true);
                  return;
               }
            }
         }
      }
      
      public function createCurrencyIndicators(param1:HabboCatalog) : void
      {
         var _loc3_:ITextWindow = null;
         var _loc7_:ITextWindow = null;
         var _loc6_:IWindowModel = null;
         var _loc2_:ITextWindow = null;
         var _loc4_:IWindowModel = null;
         if(_offer.priceInCredits > 0)
         {
            if(_offer.priceInActivityPoints > 0)
            {
               _loc3_ = ITextWindow(_view.findChildByName("amount_text_left"));
            }
            else
            {
               _loc3_ = ITextWindow(_view.findChildByName("amount_text_right"));
            }
            if(_loc3_)
            {
               _loc3_.text = _offer.priceInCredits + "";
            }
         }
         if(_offer.priceInActivityPoints > 0)
         {
            _loc7_ = ITextWindow(_view.findChildByName("amount_text_right"));
            if(_loc7_)
            {
               _loc6_ = _view.findChildByName("currency_indicator_bitmap_right");
               if(_loc6_)
               {
                  _loc6_.style = ActivityPointTypeEnum.getIconStyleFor(_offer.activityPointType,param1,false);
               }
               _loc7_.text = _offer.priceInActivityPoints + "";
            }
         }
         else if(_offer.priceInSilver > 0)
         {
            _loc2_ = ITextWindow(_view.findChildByName("amount_text_right"));
            if(_loc2_)
            {
               _loc4_ = _view.findChildByName("currency_indicator_bitmap_right");
               if(_loc4_)
               {
                  _loc4_.style = ActivityPointTypeEnum.getIconStyleFor(1000,param1,false);
               }
               _loc2_.text = _offer.priceInSilver + "";
            }
         }
         var _loc5_:IItemListWindow = IItemListWindow(_view.findChildByName("totalprice_container"));
         if(_loc5_)
         {
            _loc5_.arrangeListItems();
         }
      }
   }
}

