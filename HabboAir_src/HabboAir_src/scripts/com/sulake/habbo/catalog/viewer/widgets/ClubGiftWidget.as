package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.catalog.club.ClubGiftController;
   import com.sulake.habbo.catalog.viewer.IProduct;
   import com.sulake.habbo.catalog.viewer.IProductContainer;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.Product;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageProductData;
   import com.sulake.habbo.communication.messages.incoming.catalog.ClubGiftData;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.session.product.IProductData;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ClubGiftWidget extends CatalogWidget implements ICatalogWidget
   {
      private var UnknownVarFromClubGiftWidget_ClubGiftController_1:ClubGiftController;
      
      private var _offers:Map;
      
      private var _preview:IWindowController_1;
      
      private var _catalog:HabboCatalog;
      
      private const DAYS_IN_MONTH:int = 31;
      
      public function ClubGiftWidget(param1:IWindowController_1, param2:ClubGiftController, param3:HabboCatalog)
      {
         super(param1);
         _catalog = param3;
         UnknownVarFromClubGiftWidget_ClubGiftController_1 = param2;
         _offers = new Map();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         UnknownVarFromClubGiftWidget_ClubGiftController_1 = null;
         _catalog = null;
         if(_preview)
         {
            _preview.dispose();
            _preview = null;
         }
      }
      
      override public function init() : Boolean
      {
         if(!window)
         {
            return false;
         }
         if(!super.init())
         {
            return false;
         }
         UnknownVarFromClubGiftWidget_ClubGiftController_1.widget = this;
         attachWidgetView("clubGiftWidget");
         _window.findChildByName("info_text").caption = "";
         _window.findChildByName("past_club_days").caption = "";
         _window.findChildByName("past_vip_days").caption = "";
         update();
         return true;
      }
      
      public function update() : void
      {
         updateInfo();
         updateList();
      }
      
      private function updateInfo() : void
      {
         var _loc6_:String = null;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         if(!UnknownVarFromClubGiftWidget_ClubGiftController_1 || !window)
         {
            return;
         }
         var _loc7_:IWindowModel = window.findChildByName("info_text");
         if(!_loc7_)
         {
            return;
         }
         if(UnknownVarFromClubGiftWidget_ClubGiftController_1.giftsAvailable > 0)
         {
            _loc6_ = "catalog.club_gift.available";
            UnknownVarFromClubGiftWidget_ClubGiftController_1.localization.registerParameter(_loc6_,"amount",UnknownVarFromClubGiftWidget_ClubGiftController_1.giftsAvailable.toString());
         }
         else if(UnknownVarFromClubGiftWidget_ClubGiftController_1.daysUntilNextGift > 0)
         {
            _loc6_ = "catalog.club_gift.days_until_next";
            UnknownVarFromClubGiftWidget_ClubGiftController_1.localization.registerParameter(_loc6_,"days",UnknownVarFromClubGiftWidget_ClubGiftController_1.daysUntilNextGift.toString());
         }
         else if(UnknownVarFromClubGiftWidget_ClubGiftController_1.hasClub)
         {
            _loc6_ = "catalog.club_gift.not_available";
         }
         else
         {
            _loc6_ = "catalog.club_gift.no_club";
         }
         _loc7_.caption = UnknownVarFromClubGiftWidget_ClubGiftController_1.localization.getLocalization(_loc6_);
         if(!UnknownVarFromClubGiftWidget_ClubGiftController_1.purse)
         {
            return;
         }
         var _loc2_:IWindowModel = window.findChildByName("past_club_days");
         if(_loc2_)
         {
            _loc5_ = UnknownVarFromClubGiftWidget_ClubGiftController_1.purse.pastClubDays + UnknownVarFromClubGiftWidget_ClubGiftController_1.purse.pastVipDays;
            _loc6_ = _loc5_ >= 31 ? "catalog.club_gift.past_club.long" : "catalog.club_gift.past_club";
            _loc4_ = _loc5_ % 31;
            _loc1_ = _loc5_ / 31;
            UnknownVarFromClubGiftWidget_ClubGiftController_1.localization.registerParameter(_loc6_,"days",_loc4_.toString());
            UnknownVarFromClubGiftWidget_ClubGiftController_1.localization.registerParameter(_loc6_,"months",_loc1_.toString());
            _loc2_.caption = UnknownVarFromClubGiftWidget_ClubGiftController_1.localization.getLocalization(_loc6_);
         }
         var _loc3_:IWindowModel = window.findChildByName("past_vip_days");
         if(_loc3_)
         {
            _loc6_ = UnknownVarFromClubGiftWidget_ClubGiftController_1.purse.pastVipDays >= 31 ? "catalog.club_gift.past_vip.long" : "catalog.club_gift.past_vip";
            _loc4_ = UnknownVarFromClubGiftWidget_ClubGiftController_1.purse.pastVipDays % 31;
            _loc1_ = UnknownVarFromClubGiftWidget_ClubGiftController_1.purse.pastVipDays / 31;
            UnknownVarFromClubGiftWidget_ClubGiftController_1.localization.registerParameter(_loc6_,"days",_loc4_.toString());
            UnknownVarFromClubGiftWidget_ClubGiftController_1.localization.registerParameter(_loc6_,"months",_loc1_.toString());
            _loc3_.caption = UnknownVarFromClubGiftWidget_ClubGiftController_1.localization.getLocalization(_loc6_);
         }
      }
      
      private function updateList() : void
      {
         var _loc1_:UnknownIHabboCatalog1 = null;
         var _loc3_:IWindowModel = null;
         var _loc11_:* = undefined;
         var _loc12_:IProductData = null;
         var _loc9_:IFurnitureData = null;
         var _loc5_:Product = null;
         var _loc6_:ClubGiftData = null;
         if(!UnknownVarFromClubGiftWidget_ClubGiftController_1 || !window || !page)
         {
            return;
         }
         for each(_loc1_ in _offers)
         {
            _loc1_.dispose();
         }
         _offers.reset();
         var _loc2_:Array = UnknownVarFromClubGiftWidget_ClubGiftController_1.getOffers();
         if(!_loc2_)
         {
            return;
         }
         var _loc4_:Map = UnknownVarFromClubGiftWidget_ClubGiftController_1.getGiftData();
         if(!_loc4_)
         {
            return;
         }
         var _loc10_:IItemListWindow = window.findChildByName("gift_list") as IItemListWindow;
         if(!_loc10_)
         {
            return;
         }
         _loc10_.destroyListItems();
         for each(var _loc7_ in _loc2_)
         {
            _loc11_ = new Vector.<IProduct>(0);
            _loc12_ = UnknownVarFromClubGiftWidget_ClubGiftController_1.catalog.getProductData(_loc7_.localizationId);
            for each(var _loc8_ in _loc7_.products)
            {
               _loc9_ = UnknownVarFromClubGiftWidget_ClubGiftController_1.catalog.getFurnitureData(_loc8_.furniClassId,_loc8_.productType);
               _loc5_ = new Product(_loc8_.productType,_loc8_.furniClassId,_loc8_.extraParam,_loc8_.productCount,_loc12_,_loc9_,_catalog);
               _loc11_.push(_loc5_);
            }
            _loc1_ = new Offer(_loc7_.offerId,_loc7_.localizationId,_loc7_.isRent,_loc7_.priceInCredits,_loc7_.priceInActivityPoints,_loc7_.activityPointType,_loc7_.priceInSilver,_loc7_.giftable,_loc7_.clubLevel,_loc11_,_loc7_.bundlePurchaseAllowed,_catalog);
            _loc1_.page = page;
            _loc6_ = _loc4_.getValue(_loc1_.offerId) as ClubGiftData;
            _loc3_ = createListItem(_loc1_,_loc6_);
            if(_loc3_)
            {
               _loc10_.addListItem(_loc3_);
               _offers.add(_loc1_.offerId,_loc1_);
            }
         }
      }
      
      private function createListItem(param1:UnknownIHabboCatalog1, param2:ClubGiftData) : IWindowModel
      {
         var _loc9_:int = 0;
         var _loc13_:String = null;
         var _loc8_:int = 0;
         var _loc12_:int = 0;
         if(!param1 || !param1.product || !param2)
         {
            return null;
         }
         var _loc3_:IWindowController_1 = createWindow("club_gift_list_item") as IWindowController_1;
         if(!_loc3_)
         {
            return null;
         }
         _loc3_.procedure = clickHandler;
         var _loc4_:IProduct = param1.product;
         if(!_loc4_)
         {
            return null;
         }
         var _loc6_:IProductData = _loc4_.productData;
         if(!_loc6_)
         {
            return null;
         }
         setText(_loc3_.findChildByName("gift_name"),_loc6_.name);
         setText(_loc3_.findChildByName("gift_desc"),_loc6_.description);
         if(param2.isVip)
         {
            _loc9_ = param2.daysRequired - UnknownVarFromClubGiftWidget_ClubGiftController_1.purse.pastVipDays;
         }
         else
         {
            _loc9_ = param2.daysRequired - (UnknownVarFromClubGiftWidget_ClubGiftController_1.purse.pastClubDays + UnknownVarFromClubGiftWidget_ClubGiftController_1.purse.pastVipDays);
         }
         if(!param2.isSelectable && _loc9_ > 0)
         {
            if(param2.isVip)
            {
               _loc13_ = "catalog.club_gift.vip_missing";
            }
            else
            {
               _loc13_ = "catalog.club_gift.club_missing";
            }
            if(_loc9_ >= 31)
            {
               _loc13_ += ".long";
            }
            _loc8_ = _loc9_ % 31;
            _loc12_ = _loc9_ / 31;
            UnknownVarFromClubGiftWidget_ClubGiftController_1.localization.registerParameter(_loc13_,"days",_loc8_.toString());
            UnknownVarFromClubGiftWidget_ClubGiftController_1.localization.registerParameter(_loc13_,"months",_loc12_.toString());
         }
         else if(UnknownVarFromClubGiftWidget_ClubGiftController_1.giftsAvailable > 0)
         {
            _loc13_ = "catalog.club_gift.selectable";
         }
         else
         {
            _loc13_ = "";
         }
         setText(_loc3_.findChildByName("months_required"),_loc13_.length > 0 ? UnknownVarFromClubGiftWidget_ClubGiftController_1.localization.getLocalization(_loc13_) : "");
         var _loc10_:IIconWindow = _loc3_.findChildByName("vip_icon") as IIconWindow;
         if(_loc10_)
         {
            _loc10_.visible = param2.isVip;
         }
         var _loc11_:UnknownICoreWindowComponents4 = _loc3_.findChildByName("select_button") as UnknownICoreWindowComponents4;
         if(_loc11_)
         {
            if(param2.isSelectable && UnknownVarFromClubGiftWidget_ClubGiftController_1.giftsAvailable > 0)
            {
               _loc11_.enable();
            }
            else
            {
               _loc11_.disable();
            }
            _loc11_.id = param1.offerId;
         }
         var _loc7_:IProductContainer = param1.productContainer;
         if(!_loc7_)
         {
            return null;
         }
         if(!page || !page.viewer || !page.viewer.roomEngine)
         {
            return null;
         }
         var _loc5_:IWindowController_1 = _loc3_.findChildByName("image_container") as IWindowController_1;
         if(_loc5_)
         {
            _loc7_.view = _loc5_;
            _loc7_.initProductIcon(page.viewer.roomEngine);
            _loc5_.procedure = mouseOverHandler;
            _loc5_.id = param1.offerId;
         }
         return _loc3_;
      }
      
      private function setText(param1:IWindowModel, param2:String) : void
      {
         param1.caption = param2;
      }
      
      private function clickHandler(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(!param1 || !param2 || !_offers || !UnknownVarFromClubGiftWidget_ClubGiftController_1)
         {
            return;
         }
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(param2.name != "select_button")
         {
            return;
         }
         var _loc3_:UnknownIHabboCatalog1 = _offers.getValue(param2.id);
         if(!_loc3_)
         {
            return;
         }
         UnknownVarFromClubGiftWidget_ClubGiftController_1.selectGift(_loc3_);
      }
      
      private function mouseOverHandler(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc4_:Rectangle = null;
         if(!param1 || !param2 || !_offers)
         {
            return;
         }
         if(param2.name != "image_container")
         {
            return;
         }
         var _loc3_:UnknownIHabboCatalog1 = _offers.getValue(param2.id);
         if(!_loc3_)
         {
            return;
         }
         if(param1.type == "WME_OVER")
         {
            _loc4_ = new Rectangle();
            param2.getGlobalRectangle(_loc4_);
         }
         if(param1.type == "WME_OUT")
         {
            hidePreview();
         }
      }
      
      private function showPreview(param1:Offer, param2:Rectangle) : void
      {
         var _loc6_:UnknownHabboRoom1 = null;
         if(!param1 || !param1.productContainer)
         {
            return;
         }
         if(!page || !page.viewer || !page.viewer.roomEngine)
         {
            return;
         }
         var _loc4_:IProduct = param1.product;
         if(!_loc4_)
         {
            return;
         }
         if(!_preview)
         {
            _preview = createWindow("club_gift_preview") as IWindowController_1;
         }
         if(!_preview)
         {
            return;
         }
         var _loc3_:IBitmapWrapperController = _preview.findChildByName("image") as IBitmapWrapperController;
         if(!_loc3_)
         {
            return;
         }
         switch(_loc4_.productType)
         {
            case "s":
               _loc6_ = page.viewer.roomEngine.getFurnitureImage(_loc4_.productClassId,new Vector3d(90),64,null,0,_loc4_.extraParam);
               break;
            case "i":
               _loc6_ = page.viewer.roomEngine.getWallItemImage(_loc4_.productClassId,new Vector3d(90),64,null,0,_loc4_.extraParam);
               break;
            default:
               return;
         }
         if(!_loc6_ || !_loc6_.data)
         {
            return;
         }
         _loc3_.width = _loc6_.data.width;
         _loc3_.height = _loc6_.data.height;
         if(_loc3_.bitmap)
         {
            _loc3_.bitmap.dispose();
         }
         _loc3_.bitmap = new BitmapData(_loc3_.width,_loc3_.height);
         _loc3_.bitmap.draw(_loc6_.data);
         _loc6_.data.dispose();
         var _loc5_:Point = Point.interpolate(param2.topLeft,param2.bottomRight,0.5);
         _preview.setGlobalPosition(_loc5_.subtract(new Point(_preview.width / 2,_preview.height / 2)));
         _preview.visible = true;
         _preview.activate();
      }
      
      private function hidePreview() : void
      {
         if(_preview)
         {
            _preview.visible = false;
         }
      }
      
      private function createWindow(param1:String) : IWindowModel
      {
         if(!UnknownVarFromClubGiftWidget_ClubGiftController_1 || !UnknownVarFromClubGiftWidget_ClubGiftController_1.assets || !UnknownVarFromClubGiftWidget_ClubGiftController_1.windowManager)
         {
            return null;
         }
         var _loc3_:XmlAsset = UnknownVarFromClubGiftWidget_ClubGiftController_1.assets.getAssetByName(param1) as XmlAsset;
         if(!_loc3_ || !_loc3_.content)
         {
            return null;
         }
         var _loc2_:XML = _loc3_.content as XML;
         if(!_loc2_)
         {
            return null;
         }
         return UnknownVarFromClubGiftWidget_ClubGiftController_1.windowManager.buildFromXML(_loc2_);
      }
   }
}

