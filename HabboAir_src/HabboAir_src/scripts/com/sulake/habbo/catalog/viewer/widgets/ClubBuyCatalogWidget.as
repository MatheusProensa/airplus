package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.club.ClubBuyController;
   import com.sulake.habbo.catalog.club.ClubBuyItem;
   import com.sulake.habbo.catalog.club.ClubBuyOfferData;
   import com.sulake.habbo.catalog.purse.IPurse;
   import com.sulake.habbo.catalog.viewer.CatalogPage;
   import com.sulake.habbo.catalog.viewer.ICatalogViewer;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.utils.HabboWebTools;
   
   public class ClubBuyCatalogWidget extends CatalogWidget implements ICatalogWidget, IVipBuyCatalogWidget
   {
      private var UnknownVarFromClubBuyCatalogWidget_ClubBuyController_1:ClubBuyController;
      
      private var _offers:Array;
      
      public function ClubBuyCatalogWidget(param1:IWindowController_1)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         if(UnknownVarFromClubBuyCatalogWidget_ClubBuyController_1 != null)
         {
            UnknownVarFromClubBuyCatalogWidget_ClubBuyController_1.unRegisterVisualization(this);
         }
         UnknownVarFromClubBuyCatalogWidget_ClubBuyController_1 = null;
         reset();
         super.dispose();
      }
      
      public function get isGift() : Boolean
      {
         return false;
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         _offers = [];
         attachWidgetView("clubBuyWidget");
         UnknownVarFromClubBuyCatalogWidget_ClubBuyController_1 = (page.viewer.catalog as HabboCatalog).getClubBuyController();
         UnknownVarFromClubBuyCatalogWidget_ClubBuyController_1.registerVisualization(this);
         UnknownVarFromClubBuyCatalogWidget_ClubBuyController_1.requestOffers(0);
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
         var _loc5_:HabboCatalog = null;
         var _loc2_:IHabboLocalizationManager = null;
         var _loc8_:IPurse = null;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         if(disposed)
         {
            return;
         }
         var _loc3_:ICatalogViewer = page.viewer;
         if(_loc3_)
         {
            _loc5_ = _loc3_.catalog as HabboCatalog;
            if(_loc5_)
            {
               _loc2_ = _loc5_.localization;
               _loc8_ = _loc5_.getPurse();
               if(_loc8_ && _loc2_)
               {
                  _loc7_ = _loc8_.clubDays;
                  _loc6_ = _loc8_.clubPeriods;
                  _loc4_ = _loc6_ * 31 + _loc7_;
                  _loc2_.registerParameter("catalog.club.buy.remaining.hc","days",String(_loc4_));
                  _loc2_.registerParameter("catalog.club.buy.remaining.vip","days",String(_loc4_));
               }
            }
         }
         try
         {
            if(_window)
            {
               switch(param1)
               {
                  case 0:
                     _window.findChildByName("club_header").caption = "${catalog.club.buy.header.none}";
                     _window.findChildByName("club_info").caption = "${catalog.club.buy.info.none}";
                     _window.findChildByName("club_remaining").visible = false;
                     _window.findChildByName("club_remaining_bg").visible = false;
                     break;
                  case 1:
                     _window.findChildByName("club_header").caption = "${catalog.club.buy.header.hc}";
                     _window.findChildByName("club_info").caption = "${catalog.club.buy.info.hc}";
                     _window.findChildByName("club_remaining").caption = "${catalog.club.buy.remaining.hc}";
                     break;
                  case 2:
                     _window.findChildByName("club_header").caption = "${catalog.club.buy.header.vip}";
                     _window.findChildByName("club_info").caption = "${catalog.club.buy.info.vip}";
                     _window.findChildByName("club_remaining").caption = "${catalog.club.buy.remaining.vip}";
                     showClubInfo();
               }
            }
         }
         catch(e:Error)
         {
            ErrorReportStorage.addDebugData("ClubBuyCatalogWidget","initClubType - Window not properly constructed!");
         }
         initLinks();
      }
      
      private function initLinks() : void
      {
         var _loc1_:IWindowModel = null;
         if(_window)
         {
            _loc1_ = _window.findChildByName("club_link");
            if(_loc1_)
            {
               _loc1_.setParamFlag(1);
               _loc1_.mouseThreshold = 0;
               _loc1_.addEventListener("WME_CLICK",onClickLink);
            }
         }
      }
      
      public function showOffer(param1:ClubBuyOfferData) : void
      {
         var _loc2_:ClubBuyItem = null;
         var _loc3_:IItemListWindow = null;
         if(disposed)
         {
            return;
         }
         Logger.log("Offer: " + [param1.offerId,param1.productCode,param1.priceCredits,param1.vip,param1.months,param1.daysLeftAfterPurchase,param1.year,param1.month,param1.day,param1.upgradeHcPeriodToVip]);
         param1.page = page;
         try
         {
            _loc2_ = new ClubBuyItem(param1,page as CatalogPage);
         }
         catch(e:Error)
         {
            ErrorReportStorage.addDebugData("ClubBuyCatalogWidget","showOffer - new ClubBuyItem(" + String(param1) + ", " + (String(page as CatalogPage)) + ") crashed!");
            return;
         }
         if(param1.vip)
         {
            _loc3_ = _window.findChildByName("item_list_vip") as IItemListWindow;
         }
         else
         {
            _loc3_ = _window.findChildByName("item_list_hc") as IItemListWindow;
         }
         if(_loc3_ != null)
         {
            _loc3_.addListItem(_loc2_.window);
         }
         _offers.push(_loc2_);
      }
      
      private function onClickLink(param1:WindowMouseEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = IWindowModel(param1.target).name;
         var _loc2_:IComponent_1 = page.viewer.catalog as HabboCatalog;
         var _loc5_:* = _loc4_;
         if("club_link" === _loc5_)
         {
            _loc3_ = _loc2_.getProperty("link.format.club");
            openExternalLink(_loc3_);
         }
      }
      
      private function openExternalLink(param1:String) : void
      {
         if(param1 != "")
         {
            page.viewer.catalog.windowManager.alert("${catalog.alert.external.link.title}","${catalog.alert.external.link.desc}",0,onExternalLink);
            HabboWebTools.navigateToURL(param1,"habboMain");
         }
      }
      
      private function onExternalLink(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         param1.dispose();
      }
      
      private function showClubInfo() : void
      {
         var _loc2_:XML = null;
         var _loc1_:IWindowModel = null;
         var _loc3_:IItemListWindow = _window.findChildByName("item_list_hc") as IItemListWindow;
         if(_loc3_ != null)
         {
            _loc2_ = getAssetXML("club_buy_info_item");
            _loc1_ = page.viewer.catalog.windowManager.buildFromXML(_loc2_);
            _loc3_.addListItem(_loc1_);
         }
      }
   }
}

