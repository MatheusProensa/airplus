package com.sulake.habbo.catalog.club
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.localization.ILocalization;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.ICatalogPage;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   
   public class ClubBuyItem
   {
      private var _offer:ClubBuyOfferData;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromClubBuyItem_ICatalogPage_1:ICatalogPage;
      
      public function ClubBuyItem(param1:ClubBuyOfferData, param2:ICatalogPage)
      {
         var _loc5_:XML = null;
         var _loc3_:ILocalization = null;
         super();
         _offer = param1;
         UnknownVarFromClubBuyItem_ICatalogPage_1 = param2;
         if(param1.vip)
         {
            _loc5_ = getAssetXML("club_buy_vip_item");
         }
         else
         {
            _loc5_ = getAssetXML("club_buy_hc_item");
         }
         _window = UnknownVarFromClubBuyItem_ICatalogPage_1.viewer.catalog.windowManager.buildFromXML(_loc5_) as IWindowController_1;
         var _loc4_:IHabboLocalizationManager = (param2.viewer.catalog as HabboCatalog).localization;
         _loc4_.registerParameter("catalog.club.item.header","months",String(param1.months));
         _loc3_ = _loc4_.getLocalizationRaw("catalog.club.item.header");
         _window.findChildByName("item_header").caption = _loc3_.value;
         _loc4_.registerParameter("catalog.club.price","price",String(param1.priceCredits));
         _loc3_ = _loc4_.getLocalizationRaw("catalog.club.price");
         _window.findChildByName("item_price").caption = _loc3_.value;
         var _loc6_:UnknownICoreWindowComponents4 = _window.findChildByName("item_buy") as UnknownICoreWindowComponents4;
         if(_loc6_ != null)
         {
            _loc6_.addEventListener("WME_CLICK",onBuy);
         }
      }
      
      public function dispose() : void
      {
         _window.dispose();
      }
      
      private function onBuy(param1:WindowMouseEvent) : void
      {
         HabboCatalog(UnknownVarFromClubBuyItem_ICatalogPage_1.viewer.catalog).showPurchaseConfirmation(_offer,UnknownVarFromClubBuyItem_ICatalogPage_1.pageId);
      }
      
      private function getAssetXML(param1:String) : XML
      {
         if(!UnknownVarFromClubBuyItem_ICatalogPage_1 || !UnknownVarFromClubBuyItem_ICatalogPage_1.viewer || !UnknownVarFromClubBuyItem_ICatalogPage_1.viewer.catalog || !UnknownVarFromClubBuyItem_ICatalogPage_1.viewer.catalog.assets)
         {
            return null;
         }
         var _loc2_:XmlAsset = UnknownVarFromClubBuyItem_ICatalogPage_1.viewer.catalog.assets.getAssetByName(param1) as XmlAsset;
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.content as XML;
      }
      
      public function get window() : IWindowModel
      {
         return _window;
      }
   }
}

