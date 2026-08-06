package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.catalog.viewer.widgets.ActivityPointDisplayCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.AddOnBadgeViewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.BuilderAddonsCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.BuilderCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.BuilderLoyaltyCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.BuilderSubscriptionCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.BundleGridViewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.BundlePurchaseExtraInfoWidget;
   import com.sulake.habbo.catalog.viewer.widgets.BuyGuildWidget;
   import com.sulake.habbo.catalog.viewer.widgets.ClubBuyCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.ClubGiftWidget;
   import com.sulake.habbo.catalog.viewer.widgets.ColourGridCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.FeaturedItemsCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.FirstProductSelectorCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.GuildBadgeViewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.GuildForumSelectorCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.GuildSelectorCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.ICatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.ItemGridCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.LocalizationCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.LoyaltyVipBuyCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.MadMoneyCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.MarketPlaceCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.MarketPlaceOwnItemsCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.NewPetsCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.PetPreviewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.PetsCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.ProductViewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.PurchaseCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.RecyclerCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.RecyclerPrizesCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.RedeemItemCodeCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.RoomAdsCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.RoomPreviewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.SimplePriceCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.SingleViewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.SoldLtdItemsCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.SongDiskProductViewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.SpacesNewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.SpecialInfoWidget;
   import com.sulake.habbo.catalog.viewer.widgets.SpinnerCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.TextInputCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.TotalPriceWidget;
   import com.sulake.habbo.catalog.viewer.widgets.TraxPreviewCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.TrophyCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.UniqueLimitedItemWidget;
   import com.sulake.habbo.catalog.viewer.widgets.UserBadgeSelectorCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.VipBuyCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.WarningCatalogWidget;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.ProductOfferUpdatedEvent;
   import flash.events.Event;
   
   public class CatalogPage implements ICatalogPage
   {
      protected static const LAYOUT_MAGIC_PREFIX:String = "layout_";
      
      public static const MODE_NORMAL:int = 0;
      
      public static const MODE_SEARCH:int = 1;
      
      protected var _layout:XML;
      
      protected var _window:IWindowController_1;
      
      private var _viewer:ICatalogViewer;
      
      private var UnknownVarFromCatalogPage_Int_1:int;
      
      private var _layoutCode:String;
      
      private var _offers:Vector.<UnknownIHabboCatalog1>;
      
      private var _localization:IPageLocalization;
      
      private var UnknownVarFromCatalogPage_Array_1:Array = [];
      
      private var _widgetEvents:EventDispatcherWrapper;
      
      private var _catalog:HabboCatalog;
      
      private var UnknownVarFromCatalogPage_Int_2:int;
      
      private var UnknownVarFromCatalogPage_ItemGridCatalogWidget_1:ItemGridCatalogWidget;
      
      private var _acceptSeasonCurrencyAsCredits:Boolean;
      
      private var _mode:int;
      
      public function CatalogPage(param1:ICatalogViewer, param2:int, param3:String, param4:IPageLocalization, param5:Vector.<UnknownIHabboCatalog1>, param6:HabboCatalog, param7:Boolean, param8:int = -1)
      {
         super();
         _viewer = param1;
         UnknownVarFromCatalogPage_Int_1 = param2;
         _layoutCode = param3;
         _localization = param4;
         _offers = param5;
         _catalog = param6;
         for each(var _loc9_ in param5)
         {
            _loc9_.page = this;
         }
         _widgetEvents = new EventDispatcherWrapper();
         UnknownVarFromCatalogPage_Array_1 = [];
         _acceptSeasonCurrencyAsCredits = param7;
         if(param8 == -1)
         {
            _mode = 0;
         }
         else
         {
            _mode = param8;
         }
         init();
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function get viewer() : ICatalogViewer
      {
         return _viewer;
      }
      
      public function get pageId() : int
      {
         return _mode == 1 ? -12345678 : UnknownVarFromCatalogPage_Int_1;
      }
      
      public function get layoutCode() : String
      {
         return _layoutCode;
      }
      
      public function get offers() : Vector.<UnknownIHabboCatalog1>
      {
         return _offers;
      }
      
      public function get localization() : IPageLocalization
      {
         return _localization;
      }
      
      public function get links() : Array
      {
         return _localization.getLinks(_layoutCode);
      }
      
      public function get hasLinks() : Boolean
      {
         return _localization.hasLinks(_layoutCode);
      }
      
      public function get acceptSeasonCurrencyAsCredits() : Boolean
      {
         return _acceptSeasonCurrencyAsCredits;
      }
      
      public function get allowDragging() : Boolean
      {
         return _layoutCode != "sold_ltd_items";
      }
      
      public function set searchPageId(param1:int) : void
      {
         UnknownVarFromCatalogPage_Int_2 = param1;
      }
      
      public function get mode() : int
      {
         return _mode;
      }
      
      public function get isBuilderPage() : Boolean
      {
         return _viewer.catalogType == "BUILDERS_CLUB";
      }
      
      public function selectOffer(param1:int) : void
      {
         var _loc3_:IProductGridItem = null;
         var _loc4_:ITextFieldWindow = null;
         if(UnknownVarFromCatalogPage_ItemGridCatalogWidget_1 != null && param1 > -1)
         {
            Logger.log("selecting offer " + param1);
            for each(var _loc2_ in _offers)
            {
               if(_loc2_.offerId == param1)
               {
                  _loc3_ = _loc2_.gridItem;
                  UnknownVarFromCatalogPage_ItemGridCatalogWidget_1.select(_loc3_,true);
               }
            }
         }
         if(_window && _window.findChildByName("trophyWidget") != null)
         {
            _loc4_ = _window.findChildByName("input_text") as ITextFieldWindow;
            _loc4_.focus();
            _loc4_.activate();
         }
      }
      
      public function dispose() : void
      {
         for each(var _loc2_ in UnknownVarFromCatalogPage_Array_1)
         {
            _loc2_.dispose();
         }
         UnknownVarFromCatalogPage_Array_1 = null;
         _localization.dispose();
         for each(var _loc1_ in _offers)
         {
            _loc1_.dispose();
         }
         _offers = new Vector.<UnknownIHabboCatalog1>(0);
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(_widgetEvents != null)
         {
            _widgetEvents.dispose();
            _widgetEvents = null;
         }
         _viewer = null;
         _layout = null;
         UnknownVarFromCatalogPage_Int_1 = 0;
         _layoutCode = "";
         _acceptSeasonCurrencyAsCredits = false;
      }
      
      public function init() : void
      {
         if(createWindow(layoutCode))
         {
            createWidgets();
         }
      }
      
      public function closed() : void
      {
         if(UnknownVarFromCatalogPage_Array_1 != null)
         {
            for each(var _loc1_ in UnknownVarFromCatalogPage_Array_1)
            {
               _loc1_.closed();
            }
         }
      }
      
      protected function createWindow(param1:String) : Boolean
      {
         if(param1 == "frontpage4")
         {
            param1 = "frontpage_featured";
         }
         var _loc2_:String = "layout_" + param1;
         if(_viewer.viewerTags.indexOf("UBUNTU") > -1)
         {
            if(!viewer.catalog.assets.hasAsset(_loc2_))
            {
               _loc2_ = "old_" + _loc2_;
            }
         }
         else
         {
            _loc2_ = "old_" + _loc2_;
         }
         var _loc3_:XmlAsset = viewer.catalog.assets.getAssetByName(_loc2_) as XmlAsset;
         if(_loc3_ == null)
         {
            Logger.log("Could not find asset for layout " + _loc2_);
            return false;
         }
         _layout = _loc3_.content as XML;
         _window = viewer.catalog.windowManager.buildFromXML(_layout) as IWindowController_1;
         if(_window == null)
         {
            Logger.log("Could not create layout " + param1);
            return false;
         }
         return true;
      }
      
      private function localize() : void
      {
      }
      
      private function createWidgets() : void
      {
         createWidgetsRecursion(_window);
         initializeWidgets();
      }
      
      private function createWidgetsRecursion(param1:IWindowController_1) : void
      {
         var _loc2_:int = 0;
         var _loc3_:IWindowController_1 = null;
         if(param1 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.numChildren)
            {
               _loc3_ = param1.getChildAt(_loc2_) as IWindowController_1;
               if(_loc3_ != null)
               {
                  createWidget(_loc3_);
                  createWidgetsRecursion(_loc3_);
               }
               _loc2_++;
            }
         }
      }
      
      private function createWidget(param1:IWindowController_1) : void
      {
         if(param1 == null)
         {
            return;
         }
         switch(param1.name)
         {
            case "itemGridWidget":
               if(UnknownVarFromCatalogPage_ItemGridCatalogWidget_1 == null)
               {
                  UnknownVarFromCatalogPage_ItemGridCatalogWidget_1 = new ItemGridCatalogWidget(param1,_catalog.sessionDataManager,_viewer.catalogType);
                  UnknownVarFromCatalogPage_Array_1.push(UnknownVarFromCatalogPage_ItemGridCatalogWidget_1);
               }
               break;
            case "productViewWidget":
               UnknownVarFromCatalogPage_Array_1.push(new ProductViewCatalogWidget(param1,_catalog));
               break;
            case "songDiskProductViewWidget":
               UnknownVarFromCatalogPage_Array_1.push(new SongDiskProductViewCatalogWidget(param1,_catalog));
               break;
            case "singleViewWidget":
               UnknownVarFromCatalogPage_Array_1.push(new SingleViewCatalogWidget(param1,_catalog));
               break;
            case "purchaseWidget":
               UnknownVarFromCatalogPage_Array_1.push(new PurchaseCatalogWidget(param1,_catalog));
               break;
            case "colourGridWidget":
               UnknownVarFromCatalogPage_Array_1.push(new ColourGridCatalogWidget(param1));
               break;
            case "traxPreviewWidget":
               UnknownVarFromCatalogPage_Array_1.push(new TraxPreviewCatalogWidget(param1,_catalog.soundManager));
               break;
            case "redeemItemCodeWidget":
               UnknownVarFromCatalogPage_Array_1.push(new RedeemItemCodeCatalogWidget(param1));
               break;
            case "spacesNewWidget":
               UnknownVarFromCatalogPage_Array_1.push(new SpacesNewCatalogWidget(param1,_catalog.sessionDataManager,_viewer.catalogType));
               break;
            case "roomPreviewWidget":
               UnknownVarFromCatalogPage_Array_1.push(new RoomPreviewCatalogWidget(param1));
               break;
            case "trophyWidget":
               UnknownVarFromCatalogPage_Array_1.push(new TrophyCatalogWidget(param1,_catalog));
               break;
            case "addOnBadgeViewWidget":
               UnknownVarFromCatalogPage_Array_1.push(new AddOnBadgeViewCatalogWidget(param1));
               break;
            case "petsWidget":
               UnknownVarFromCatalogPage_Array_1.push(new PetsCatalogWidget(param1,_catalog));
               break;
            case "newPetsWidget":
               UnknownVarFromCatalogPage_Array_1.push(new NewPetsCatalogWidget(param1,_catalog));
               break;
            case "roomAdsCatalogWidget":
               UnknownVarFromCatalogPage_Array_1.push(new RoomAdsCatalogWidget(param1,_catalog));
               break;
            case "textInputWidget":
               UnknownVarFromCatalogPage_Array_1.push(new TextInputCatalogWidget(param1));
               break;
            case "specialInfoWidget":
               UnknownVarFromCatalogPage_Array_1.push(new SpecialInfoWidget(param1));
               break;
            case "recyclerWidget":
               UnknownVarFromCatalogPage_Array_1.push(new RecyclerCatalogWidget(param1));
               break;
            case "recyclerPrizesWidget":
               UnknownVarFromCatalogPage_Array_1.push(new RecyclerPrizesCatalogWidget(param1));
               break;
            case "marketPlaceWidget":
               UnknownVarFromCatalogPage_Array_1.push(new MarketPlaceCatalogWidget(param1));
               break;
            case "marketPlaceOwnItemsWidget":
               UnknownVarFromCatalogPage_Array_1.push(new MarketPlaceOwnItemsCatalogWidget(param1));
               break;
            case "clubGiftWidget":
               UnknownVarFromCatalogPage_Array_1.push(new ClubGiftWidget(param1,_catalog.getClubGiftController(),_catalog));
               break;
            case "clubBuyWidget":
               UnknownVarFromCatalogPage_Array_1.push(new ClubBuyCatalogWidget(param1));
               break;
            case "vipBuyWidget":
               UnknownVarFromCatalogPage_Array_1.push(new VipBuyCatalogWidget(param1,_catalog));
               break;
            case "loyaltyVipBuyWidget":
               UnknownVarFromCatalogPage_Array_1.push(new LoyaltyVipBuyCatalogWidget(param1,_catalog));
               break;
            case "vipGiftWidget":
               UnknownVarFromCatalogPage_Array_1.push(new VipBuyCatalogWidget(param1,_catalog,true));
               break;
            case "activityPointDisplayWidget":
               UnknownVarFromCatalogPage_Array_1.push(new ActivityPointDisplayCatalogWidget(param1));
               break;
            case "madMoneyWidget":
               UnknownVarFromCatalogPage_Array_1.push(new MadMoneyCatalogWidget(param1));
               break;
            case "buyGuildWidget":
               UnknownVarFromCatalogPage_Array_1.push(new BuyGuildWidget(param1));
               break;
            case "guildBadgeViewWidget":
               UnknownVarFromCatalogPage_Array_1.push(new GuildBadgeViewCatalogWidget(param1,_catalog.getGroupMembershipsController()));
               break;
            case "guildSelectorWidget":
               UnknownVarFromCatalogPage_Array_1.push(new GuildSelectorCatalogWidget(param1,_catalog.getGroupMembershipsController()));
               break;
            case "guildForumSelectorWidget":
               UnknownVarFromCatalogPage_Array_1.push(new GuildForumSelectorCatalogWidget(param1,_catalog.getGroupMembershipsController()));
               break;
            case "petPreviewWidget":
               UnknownVarFromCatalogPage_Array_1.push(new PetPreviewCatalogWidget(param1,_catalog));
               break;
            case "spinnerWidget":
               UnknownVarFromCatalogPage_Array_1.push(new SpinnerCatalogWidget(param1,_catalog));
               break;
            case "bundlePurchaseExtraInfoWidget":
               UnknownVarFromCatalogPage_Array_1.push(new BundlePurchaseExtraInfoWidget(param1,_catalog));
               break;
            case "totalPriceWidget":
               UnknownVarFromCatalogPage_Array_1.push(new TotalPriceWidget(param1,_catalog));
               break;
            case "limitedItemWidget":
               UnknownVarFromCatalogPage_Array_1.push(new UniqueLimitedItemWidget(param1,_catalog));
               break;
            case "soldLtdItemsWidget":
               UnknownVarFromCatalogPage_Array_1.push(new SoldLtdItemsCatalogWidget(param1,_catalog));
               break;
            case "userBadgeSelectorWidget":
               UnknownVarFromCatalogPage_Array_1.push(new UserBadgeSelectorCatalogWidget(param1,_catalog));
               break;
            case "bundleGridScrollWidget":
               UnknownVarFromCatalogPage_Array_1.push(new BundleGridViewCatalogWidget(param1));
               break;
            case "simplePriceWidget":
               UnknownVarFromCatalogPage_Array_1.push(new SimplePriceCatalogWidget(param1,_catalog));
               break;
            case "builderWidget":
               UnknownVarFromCatalogPage_Array_1.push(new BuilderCatalogWidget(param1,_catalog));
               break;
            case "builderSubscriptionWidget":
               UnknownVarFromCatalogPage_Array_1.push(new BuilderSubscriptionCatalogWidget(param1,_catalog));
               break;
            case "builderAddonsWidget":
               UnknownVarFromCatalogPage_Array_1.push(new BuilderAddonsCatalogWidget(param1,_catalog));
               break;
            case "builderLoyaltyWidget":
               UnknownVarFromCatalogPage_Array_1.push(new BuilderLoyaltyCatalogWidget(param1,_catalog));
               break;
            case "warningWidget":
               UnknownVarFromCatalogPage_Array_1.push(new WarningCatalogWidget(param1));
               break;
            case "firstProductAutoSelectorWidget":
               UnknownVarFromCatalogPage_Array_1.push(new FirstProductSelectorCatalogWidget(param1));
               break;
            case "featuredItemsWidget":
               UnknownVarFromCatalogPage_Array_1.push(new FeaturedItemsCatalogWidget(param1,_catalog));
         }
      }
      
      private function initializeWidgets() : void
      {
         var _loc3_:* = null;
         var _loc6_:ColourGridCatalogWidget = null;
         var _loc7_:ItemGridCatalogWidget = null;
         var _loc1_:IWindowController_1 = null;
         var _loc4_:int = 0;
         var _loc5_:IWindowController_1 = null;
         var _loc2_:Array = [];
         if(_layoutCode == "default_3x3_color_grouping")
         {
            _loc1_ = _window.findChildByName("itemGridWidget") as IWindowController_1;
            _loc4_ = 3;
            _loc1_.height = 64 - _loc4_;
            _loc5_ = _window.findChildByName("colourGridWidget") as IWindowController_1;
            _loc5_.visible = true;
            _loc5_.width = 360;
            _loc5_.x = _loc1_.x;
            _loc5_.y = _loc1_.y + _loc1_.height + _loc4_;
            _loc5_.height = 91;
            _loc6_ = new ColourGridCatalogWidget(_loc5_);
            UnknownVarFromCatalogPage_Array_1.push(_loc6_);
         }
         for each(_loc3_ in UnknownVarFromCatalogPage_Array_1)
         {
            _loc3_.page = this;
            if(_loc3_ is ItemGridCatalogWidget)
            {
               _loc7_ = _loc3_ as ItemGridCatalogWidget;
            }
            _loc3_.events = _widgetEvents;
            if(!_loc3_.init())
            {
               _loc2_.push(_loc3_);
            }
         }
         removeWidgets(_loc2_);
         initializeLocalizations();
         _widgetEvents.dispatchEvent(new CatalogWidgetEvent("WIDGETS_INITIALIZED"));
      }
      
      private function initializeLocalizations() : void
      {
         var _loc1_:ICatalogWidget = new LocalizationCatalogWidget(_window,_catalog);
         UnknownVarFromCatalogPage_Array_1.push(_loc1_);
         _loc1_.page = this;
         _loc1_.events = _widgetEvents;
         _loc1_.init();
      }
      
      private function removeWidgets(param1:Array) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:int = 0;
         if(param1 == null || param1.length == 0)
         {
            return;
         }
         for each(_loc3_ in UnknownVarFromCatalogPage_Array_1)
         {
            if(_loc3_.window != null)
            {
               for each(_loc2_ in param1)
               {
                  if(_loc2_.window != null)
                  {
                     if(_loc2_.window.getChildIndex(_loc3_.window) >= 0)
                     {
                        if(param1.indexOf(_loc3_) < 0)
                        {
                           param1.push(_loc3_);
                        }
                        break;
                     }
                  }
               }
            }
         }
         for each(_loc2_ in param1)
         {
            if(_loc2_.window != null)
            {
               _window.removeChild(_loc2_.window);
               _loc2_.window.dispose();
            }
            _loc4_ = int(UnknownVarFromCatalogPage_Array_1.indexOf(_loc2_));
            if(_loc4_ >= 0)
            {
               UnknownVarFromCatalogPage_Array_1.splice(_loc4_,1);
            }
            _loc2_.dispose();
         }
      }
      
      public function dispatchWidgetEvent(param1:Event) : Boolean
      {
         if(_widgetEvents != null)
         {
            return _widgetEvents.dispatchEvent(param1);
         }
         return false;
      }
      
      public function replaceOffers(param1:Vector.<UnknownIHabboCatalog1>, param2:Boolean = false) : void
      {
         if(param2)
         {
            for each(var _loc3_ in _offers)
            {
               _loc3_.dispose();
            }
         }
         _offers = param1;
      }
      
      public function updateLimitedItemsLeft(param1:int, param2:int) : void
      {
         for each(var _loc3_ in _offers)
         {
            if(_loc3_.offerId == param1)
            {
               _loc3_.product.uniqueLimitedItemsLeft = param2;
               _widgetEvents.dispatchEvent(new ProductOfferUpdatedEvent(_loc3_));
               return;
            }
         }
      }
   }
}

