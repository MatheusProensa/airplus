package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.club.ClubBuyController;
   import com.sulake.habbo.catalog.club.ClubBuyOfferData;
   import com.sulake.habbo.catalog.club.VipBuyItem;
   import com.sulake.habbo.catalog.purse.IPurse;
   import com.sulake.habbo.catalog.viewer.CatalogPage;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import flash.text.StyleSheet;
   import flash.text.TextFormat;
   
   public class VipBuyCatalogWidget extends CatalogWidget implements ICatalogWidget, IVipBuyCatalogWidget
   {
      private var UnknownVarFromVipBuyCatalogWidget_ClubBuyController_1:ClubBuyController;
      
      private var _offers:Array;
      
      private var _catalog:HabboCatalog;
      
      private var _isGift:Boolean;
      
      public function VipBuyCatalogWidget(param1:IWindowController_1, param2:HabboCatalog, param3:Boolean = false)
      {
         super(param1);
         _catalog = param2;
         _isGift = param3;
      }
      
      public function get isGift() : Boolean
      {
         return _isGift;
      }
      
      override public function dispose() : void
      {
         if(UnknownVarFromVipBuyCatalogWidget_ClubBuyController_1 != null)
         {
            UnknownVarFromVipBuyCatalogWidget_ClubBuyController_1.unRegisterVisualization(this);
            UnknownVarFromVipBuyCatalogWidget_ClubBuyController_1 = null;
         }
         reset();
         super.dispose();
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         _offers = [];
         UnknownVarFromVipBuyCatalogWidget_ClubBuyController_1 = _catalog.getClubBuyController();
         UnknownVarFromVipBuyCatalogWidget_ClubBuyController_1.registerVisualization(this);
         UnknownVarFromVipBuyCatalogWidget_ClubBuyController_1.requestOffers(_isGift ? 2 : 1);
         return true;
      }
      
      public function reset() : void
      {
         for each(var _loc1_ in _offers)
         {
            _loc1_.dispose();
         }
         _offers = [];
      }
      
      public function initClubType(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(disposed)
         {
            return;
         }
         var _loc2_:IHabboLocalizationManager = _catalog.localization;
         var _loc6_:IPurse = _catalog.getPurse();
         if(_loc6_ != null && _loc2_ != null)
         {
            _loc5_ = _loc6_.clubDays;
            _loc4_ = _loc6_.clubPeriods;
            _loc3_ = _loc4_ * 31 + _loc5_;
            _loc2_.registerParameter("catalog.vip.extend.info","days",String(_loc3_));
         }
         if(_window != null && param1 == 2 && !_isGift)
         {
            _window.findChildByName("vip_title").caption = "${catalog.vip.extend.title}";
            _window.findChildByName("vip_info").caption = "${catalog.vip.extend.info}";
         }
         if(_window != null)
         {
            fixFormatting(_window.findChildByName("vip_title") as ITextWindow);
            fixFormatting(_window.findChildByName("vip_info") as ITextWindow,3);
         }
         initLinks();
      }
      
      private function fixFormatting(param1:ITextWindow, param2:Number = 0) : void
      {
         var _loc3_:TextFormat = param1.getTextFormat();
         _loc3_.align = "center";
         _loc3_.leading = param2;
         param1.setTextFormat(_loc3_);
      }
      
      private function initLinks() : void
      {
         var _loc2_:IWindowModel = null;
         var _loc1_:ITextWindow = null;
         if(_window)
         {
            _loc2_ = _window.findChildByName("vip_link");
            if(_loc2_)
            {
               _loc2_.addEventListener("WME_CLICK",onBenefits);
               _loc2_.mouseThreshold = 0;
            }
            _loc1_ = _window.findChildByName("hccenter_link") as ITextWindow;
            if(_loc1_ && UnknownVarFromVipBuyCatalogWidget_ClubBuyController_1)
            {
               _loc1_.text = UnknownVarFromVipBuyCatalogWidget_ClubBuyController_1.localization.getLocalization("catalog.vip.buy.hccenter","catalog.vip.buy.hccenter");
               setLinkStyle(_loc1_);
            }
         }
      }
      
      private function setLinkStyle(param1:ITextWindow) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc3_:StyleSheet = new StyleSheet();
         var _loc2_:Object = {};
         _loc2_.textDecoration = "underline";
         _loc3_.setStyle("a:link",_loc2_);
         param1.styleSheet = _loc3_;
      }
      
      public function onBenefits(param1:WindowMouseEvent) : void
      {
         _catalog.utils.showVipBenefits();
      }
      
      public function showOffer(param1:ClubBuyOfferData) : void
      {
         var _loc2_:VipBuyItem = null;
         if(disposed || !param1.vip)
         {
            return;
         }
         Logger.log("Offer: " + [param1.offerId,param1.productCode,param1.priceCredits,param1.vip,param1.months,param1.daysLeftAfterPurchase,param1.year,param1.month,param1.day,param1.upgradeHcPeriodToVip]);
         param1.page = page;
         try
         {
            _loc2_ = new VipBuyItem(param1,_catalog,_isGift ? "HabboCatalogGift" : "HabboCatalogBuy");
         }
         catch(e:Error)
         {
            ErrorReportStorage.addDebugData("ClubBuyCatalogWidget","showOffer - new ClubBuyItem(" + String(param1) + ", " + (String(page as CatalogPage)) + ") crashed!");
            return;
         }
         var _loc3_:IItemListWindow = _window.findChildByName("item_list_vip") as IItemListWindow;
         if(_loc3_ != null)
         {
            _loc3_.addListItem(_loc2_.window);
         }
         _offers.push(_loc2_);
      }
   }
}

