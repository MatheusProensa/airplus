package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils2;
   import com.sulake.habbo.catalog.marketplace.IMarketPlace;
   import com.sulake.habbo.catalog.marketplace.IMarketPlaceVisualization;
   import com.sulake.habbo.catalog.marketplace.MarketPlaceOfferData;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.widgets.ILimitedItemGridOverlayWidget;
   import com.sulake.habbo.window.widgets.IRarityItemGridOverlayWidget;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class MarketPlaceOwnItemsCatalogWidget extends CatalogWidget implements ICatalogWidget, UnknownIHabboRoom1, IMarketPlaceVisualization
   {
      private static const ITEM_POOL_MAX_SIZE:int = 2000;
      
      private const STATUS_SEARCHING:int = 1;
      
      private const STATUS_LIST_AVAILABLE:int = 2;
      
      private const MAX_SEARCH_STRING_LENGTH:int = 40;
      
      private var _itemTemplates:Map;
      
      private var _itemPools:Map;
      
      private var _itemList:IItemListWindow;
      
      private var _allOffers:Map;
      
      private var _offers:Map;
      
      private var _offerWindowsById:Map;
      
      private var UnknownVarFromMarketPlaceOwnItemsCatalogWidget_String_1:String = "";
      
      private var UnknownVarFromMarketPlaceOwnItemsCatalogWidget_Int_1:int = 1;
      
      private var _ignoreCategorySelectionEvents:Boolean = false;
      
      public function MarketPlaceOwnItemsCatalogWidget(param1:IWindowController_1)
      {
         super(param1);
         _itemTemplates = new Map();
         _itemPools = new Map();
         _offerWindowsById = new Map();
      }
      
      override public function dispose() : void
      {
         clearVisibleItems();
         if(_itemTemplates != null)
         {
            for each(var _loc1_ in _itemTemplates)
            {
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
            }
            _itemTemplates.dispose();
            _itemTemplates = null;
         }
         if(_itemPools != null)
         {
            for each(var _loc2_ in _itemPools)
            {
               disposeItemPool(_loc2_);
            }
            _itemPools.dispose();
            _itemPools = null;
         }
         if(_offerWindowsById != null)
         {
            _offerWindowsById.dispose();
            _offerWindowsById = null;
         }
         if(_offers != null)
         {
            _offers.dispose();
            _offers = null;
         }
         _allOffers = null;
         super.dispose();
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         if(marketPlace == null)
         {
            return false;
         }
         var _loc3_:IHabboWindowManagerComponent = marketPlace.windowManager;
         if(_loc3_ == null)
         {
            return false;
         }
         displayMainView();
         var _loc2_:IItemListWindow = _window.findChildByName("item_list") as IItemListWindow;
         _itemTemplates.add(1,_loc2_.removeListItem(_loc2_.getListItemByName("ongoing_item")));
         _itemTemplates.add(2,_loc2_.removeListItem(_loc2_.getListItemByName("sold_item")));
         _itemTemplates.add(3,_loc2_.removeListItem(_loc2_.getListItemByName("expired_item")));
         var _loc1_:ITextFieldWindow = _window.findChildByName("search_input") as ITextFieldWindow;
         if(_loc1_ != null)
         {
            _loc1_.text = "";
         }
         updateSearchUiState();
         populateCategoryDropMenu();
         marketPlace.registerVisualization(this);
         setSelectedCategory(1);
         return true;
      }
      
      private function showRedeemInfo(param1:Boolean) : void
      {
         if(!window)
         {
            return;
         }
         var _loc2_:IWindowController_1 = window.findChildByName("redeem_border") as IWindowController_1;
         if(_loc2_)
         {
            _loc2_.visible = param1;
         }
      }
      
      private function updateBottomActionButtons(param1:Boolean) : void
      {
         if(!window)
         {
            return;
         }
         var _loc2_:* = UnknownVarFromMarketPlaceOwnItemsCatalogWidget_Int_1 == 1;
         var _loc3_:UnknownICoreWindowComponents4 = window.findChildByName("recall_all_button") as UnknownICoreWindowComponents4;
         if(_loc3_ != null)
         {
            _loc3_.visible = _loc2_;
            if(param1 && _loc2_)
            {
               _loc3_.enable();
            }
            else
            {
               _loc3_.disable();
            }
         }
         var _loc4_:UnknownICoreWindowComponents4 = window.findChildByName("mark_as_seen_button") as UnknownICoreWindowComponents4;
         if(_loc4_ != null)
         {
            _loc4_.visible = !_loc2_;
            if(param1 && !_loc2_)
            {
               _loc4_.enable();
            }
            else
            {
               _loc4_.disable();
            }
         }
      }
      
      public function listUpdatedNotify() : void
      {
         if(marketPlace == null)
         {
            return;
         }
         _allOffers = marketPlace.latestOwnOffers();
         applySearchFilter();
      }
      
      public function removeOfferIds(param1:Array) : void
      {
         var _loc2_:IWindowModel = null;
         var _loc4_:IWindowModel = null;
         if(!_itemList || !_offers || !_offerWindowsById || param1 == null)
         {
            return;
         }
         _itemList.autoArrangeItems = false;
         for each(var _loc3_ in param1)
         {
            if(_offers != null)
            {
               _offers.remove(_loc3_);
            }
            _loc2_ = _offerWindowsById.remove(_loc3_) as IWindowModel;
            if(_loc2_ != null)
            {
               _loc4_ = _itemList.removeListItem(_loc2_);
               if(_loc4_ != null)
               {
                  recycleItemWindow(_loc4_ as IWindowController_1);
               }
            }
         }
         _itemList.autoArrangeItems = true;
         updateListSummary();
      }
      
      private function applySearchFilter() : void
      {
         if(_allOffers == null)
         {
            return;
         }
         if(_offers != null)
         {
            _offers.dispose();
         }
         _offers = new Map();
         for each(var _loc1_ in _allOffers)
         {
            if(matchesSearch(_loc1_))
            {
               _offers.add(_loc1_.offerId,_loc1_);
            }
         }
         updateList(_offers);
      }
      
      private function updateStatusDisplay(param1:int, param2:int = -1) : void
      {
         var _loc5_:String = null;
         if(!marketPlace || !window)
         {
            return;
         }
         var _loc3_:IHabboLocalizationManager = marketPlace.localization;
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:IWindowModel = window.findChildByName("status_text");
         if(_loc4_ == null)
         {
            return;
         }
         if(param1 == 1)
         {
            _loc5_ = _loc3_.getLocalization("catalog.marketplace.searching");
         }
         else if(param1 == 2)
         {
            if(param2 > 0)
            {
               _loc5_ = _loc3_.getLocalization("catalog.marketplace.items_found");
               _loc5_ = _loc5_.replace("%count%",param2);
            }
            else
            {
               _loc5_ = _loc3_.getLocalization("catalog.marketplace.no_items");
            }
         }
         _loc4_.caption = _loc5_;
      }
      
      private function get marketPlace() : IMarketPlace
      {
         if(!page || !page.viewer || !page.viewer.catalog)
         {
            return null;
         }
         return page.viewer.catalog.getMarketPlace();
      }
      
      private function updateList(param1:Map) : void
      {
         var _loc19_:int = 0;
         var _loc13_:int = 0;
         var _loc15_:MarketPlaceOfferData = null;
         var _loc4_:IWindowController_1 = null;
         var _loc7_:IWindowModel = null;
         var _loc10_:IWindowModel = null;
         var _loc27_:IWindowModel = null;
         var _loc11_:String = null;
         var _loc9_:IWindowModel = null;
         var _loc23_:int = 0;
         var _loc16_:int = 0;
         var _loc18_:int = 0;
         var _loc12_:String = null;
         var _loc26_:String = null;
         var _loc20_:IWindowModel = null;
         var _loc14_:IWindowModel = null;
         var _loc6_:UnknownHabboRoom1 = null;
         var _loc21_:IBitmapWrapperController = null;
         var _loc8_:Point = null;
         var _loc25_:IWindowModel = null;
         var _loc17_:IWidgetWindowController = null;
         var _loc24_:ILimitedItemGridOverlayWidget = null;
         var _loc22_:IWidgetWindowController = null;
         var _loc3_:IRarityItemGridOverlayWidget = null;
         if(!param1 || !marketPlace || !window)
         {
            return;
         }
         var _loc2_:IHabboLocalizationManager = marketPlace.localization;
         if(!_loc2_)
         {
            return;
         }
         if(!_itemList)
         {
            return;
         }
         clearVisibleItems();
         var _loc5_:Array = param1.getKeys();
         if(!_loc5_)
         {
            return;
         }
         _loc19_ = 0;
         while(_loc19_ < _loc5_.length)
         {
            _loc13_ = int(_loc5_[_loc19_]);
            _loc15_ = param1.getValue(_loc13_) as MarketPlaceOfferData;
            _loc4_ = claimItemWindow(_loc15_.status);
            if(!(!_loc4_ || Boolean(_loc4_.disposed)))
            {
               _loc7_ = _loc4_.findChildByName("item_name");
               if(_loc7_ != null)
               {
                  _loc7_.caption = marketPlace != null ? "${" + marketPlace.getNameLocalizationKey(_loc15_) + "}" : "";
               }
               _loc10_ = _loc4_.findChildByName("item_desc");
               if(_loc10_ != null)
               {
                  _loc10_.caption = marketPlace != null ? "${" + marketPlace.getDescriptionLocalizationKey(_loc15_) + "}" : "";
               }
               _loc27_ = _loc4_.findChildByName("item_price");
               if(_loc27_ != null)
               {
                  _loc11_ = _loc2_.getLocalization("catalog.marketplace.offer.price_own_item");
                  _loc11_ = _loc11_.replace("%price%",_loc15_.price);
                  _loc27_.caption = _loc11_;
               }
               if(_loc15_.status == 1)
               {
                  _loc9_ = _loc4_.findChildByName("item_time");
                  if(_loc9_ != null)
                  {
                     _loc23_ = Math.max(1,_loc15_.timeLeftMinutes);
                     _loc16_ = Math.floor(_loc23_ / 60);
                     _loc18_ = _loc23_ - _loc16_ * 60;
                     _loc12_ = _loc18_ + " " + _loc2_.getLocalization("catalog.marketplace.offer.minutes");
                     if(_loc16_ > 0)
                     {
                        _loc12_ = _loc16_ + " " + _loc2_.getLocalization("catalog.marketplace.offer.hours") + " " + _loc12_;
                     }
                     _loc26_ = _loc2_.getLocalization("catalog.marketplace.offer.time_left");
                     _loc26_ = _loc26_.replace("%time%",_loc12_);
                     _loc9_.caption = _loc26_;
                  }
               }
               if(_loc15_.status == 2)
               {
                  _loc20_ = _loc4_.findChildByName("item_sold");
                  if(_loc20_ != null)
                  {
                     _loc20_.caption = getStatusText(_loc2_,_loc15_,"catalog.marketplace.offer.sold","catalog.marketplace.offer.sold_at");
                  }
               }
               if(_loc15_.status == 3)
               {
                  _loc14_ = _loc4_.findChildByName("item_expired");
                  if(_loc14_ != null)
                  {
                     _loc14_.caption = getStatusText(_loc2_,_loc15_,"catalog.marketplace.offer.expired","catalog.marketplace.offer.expired_at");
                  }
               }
               if(_loc15_.image == null)
               {
                  _loc6_ = getFurniImageResult(_loc15_.furniId,_loc15_.furniType,_loc15_.extraData);
                  if(_loc6_ != null)
                  {
                     if(_loc6_.data != null)
                     {
                        _loc15_.image = _loc6_.data as BitmapData;
                     }
                     else
                     {
                        _loc15_.imageCallback = _loc6_.id;
                        _loc4_.id = _loc6_.id;
                     }
                  }
               }
               if(_loc15_.image != null)
               {
                  _loc21_ = _loc4_.findChildByName("item_image") as IBitmapWrapperController;
                  if(_loc21_ != null)
                  {
                     _loc8_ = new Point((_loc21_.width - _loc15_.image.width) / 2,(_loc21_.height - _loc15_.image.height) / 2);
                     _loc21_.bitmap = new BitmapData(_loc21_.width,_loc21_.height,true,0);
                     _loc21_.bitmap.copyPixels(_loc15_.image,_loc15_.image.rect,_loc8_);
                  }
               }
               if(_loc15_.isUniqueLimitedItem)
               {
                  _loc25_ = _loc4_.findChildByName("unique_item_background_bitmap");
                  _loc17_ = IWidgetWindowController(_loc4_.findChildByName("unique_item_overlay_widget"));
                  _loc24_ = ILimitedItemGridOverlayWidget(_loc17_.widget);
                  _loc24_.serialNumber = _loc15_.stuffData.uniqueSerialNumber;
                  _loc24_.animated = true;
                  _loc25_.visible = true;
                  _loc17_.visible = true;
               }
               if(_loc15_.stuffData && _loc15_.stuffData.rarityLevel >= 0)
               {
                  _loc22_ = IWidgetWindowController(_loc4_.findChildByName("rarity_item_overlay_widget"));
                  _loc3_ = IRarityItemGridOverlayWidget(_loc22_.widget);
                  _loc22_.visible = true;
                  _loc3_.rarityLevel = _loc15_.stuffData.rarityLevel;
               }
               _itemList.addListItem(_loc4_);
               _offerWindowsById.add(_loc15_.offerId,_loc4_);
               _loc4_.procedure = onGridEvent;
            }
            _loc19_++;
         }
         updateListSummary();
      }
      
      private function updateListSummary() : void
      {
         if(!marketPlace || !_allOffers || !_offers || !window)
         {
            return;
         }
         var _loc1_:IHabboLocalizationManager = marketPlace.localization;
         if(!_loc1_)
         {
            return;
         }
         updateStatusDisplay(2,_offers.length);
         showRedeemInfo(true);
         updateBottomActionButtons(_allOffers.length > 0);
      }
      
      public function displayMainView() : void
      {
         attachWidgetView("marketPlaceOwnItemsWidget");
         window.procedure = onWidgetEvent;
         _itemList = window.findChildByName("item_list") as IItemListWindow;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var _loc5_:* = null;
         var _loc7_:IBitmapWrapperController = null;
         var _loc6_:Point = null;
         if(disposed || !marketPlace || !param2 || !_itemList || !_offers)
         {
            return;
         }
         var _loc4_:Array = [];
         if(_itemList.groupListItemsWithID(param1,_loc4_))
         {
            for each(_loc5_ in _loc4_)
            {
               if(_loc5_)
               {
                  _loc7_ = _loc5_.findChildByName("item_image") as IBitmapWrapperController;
                  if(_loc7_ != null)
                  {
                     _loc7_.bitmap = new BitmapData(_loc7_.width,_loc7_.height,true,16777215);
                     _loc6_ = new Point((_loc7_.width - param2.width) / 2,(_loc7_.height - param2.height) / 2);
                     _loc7_.bitmap.copyPixels(param2,param2.rect,_loc6_,null,null,true);
                  }
                  _loc5_.id = 0;
               }
            }
         }
         for each(var _loc3_ in _offers)
         {
            if(_loc3_.imageCallback == param1)
            {
               _loc3_.imageCallback = 0;
               _loc3_.image = param2;
            }
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function getFurniImageResult(param1:int, param2:int, param3:String = null) : UnknownHabboRoom1
      {
         if(!page || !page.viewer || !page.viewer.roomEngine)
         {
            return null;
         }
         if(param2 == 1)
         {
            return page.viewer.roomEngine.getFurnitureIcon(param1,this);
         }
         if(param2 == 2)
         {
            return page.viewer.roomEngine.getWallItemIcon(param1,this,param3);
         }
         return null;
      }
      
      private function onGridEvent(param1:WindowEvent, param2:IWindowModel = null) : void
      {
         var _loc4_:IItemListWindow = null;
         var _loc5_:int = 0;
         var _loc3_:MarketPlaceOfferData = null;
         if(param1.type == "WME_CLICK")
         {
            if(!marketPlace || !param2 || !window)
            {
               return;
            }
            if(param2.name == "pick_button")
            {
               _loc4_ = window.findChildByName("item_list") as IItemListWindow;
               if(_loc4_ == null)
               {
                  return;
               }
               _loc5_ = _loc4_.getListItemIndex(param1.window.parent);
               if(!_offers)
               {
                  return;
               }
               _loc3_ = _offers.getWithIndex(_loc5_) as MarketPlaceOfferData;
               if(_loc3_)
               {
                  marketPlace.redeemExpiredOffer(_loc3_.offerId);
               }
            }
         }
      }
      
      private function onWidgetEvent(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:ITextFieldWindow = null;
         var _loc4_:int = 0;
         var _loc5_:WindowKeyboardEvent = null;
         if(param2 == null)
         {
            param2 = param1.target as IWindowModel;
         }
         if(param1.type == "WME_CLICK")
         {
            if(!marketPlace || !param2)
            {
               return;
            }
            if(param2.name == "search_button")
            {
               performSearch();
            }
            if(param2.name == "cancel_search_btn" || param2.parent != null && param2.parent.name == "cancel_search_btn")
            {
               clearSearch();
            }
            if(param2.name == "recall_all_button")
            {
               marketPlace.windowManager.confirm("${shop.marketplace.recall.all.button}","${shop.marketplace.recall.all.items}",0,onRecallAllConfirm);
            }
            if(param2.name == "mark_as_seen_button")
            {
               marketPlace.windowManager.confirm("${shop.marketplace.mark.as.seen.button}","${shop.marketplace.mark.as.seen.items}",0,onMarkAsSeenConfirm);
            }
         }
         else if(param1.type == "WE_CHANGE")
         {
            _loc3_ = param2 as ITextFieldWindow;
            if(_loc3_ == null || _loc3_.name != "search_input")
            {
               return;
            }
            if(_loc3_.text.length > 40)
            {
               _loc3_.text = _loc3_.text.substr(0,40);
            }
            _loc3_.scrollH = 0;
            updateSearchUiState();
         }
         else if(param1.type == "WE_SELECTED")
         {
            if(_ignoreCategorySelectionEvents || !(param2 is IDropBaseController_1) || param2.name != "offer_category_dropmenu")
            {
               return;
            }
            _loc4_ = getCategoryForSelection(IDropBaseController_1(param2).selection);
            if(_loc4_ != UnknownVarFromMarketPlaceOwnItemsCatalogWidget_Int_1)
            {
               setSelectedCategory(_loc4_);
            }
         }
         else if(param1.type == "WKE_KEY_DOWN")
         {
            if(param2 is ITextFieldWindow && param2.name == "search_input")
            {
               _loc5_ = param1 as WindowKeyboardEvent;
               if(_loc5_ != null && _loc5_.keyCode == 13)
               {
                  performSearch();
               }
            }
         }
      }
      
      private function performSearch() : void
      {
         if(!window)
         {
            return;
         }
         var _loc1_:ITextFieldWindow = window.findChildByName("search_input") as ITextFieldWindow;
         if(_loc1_ == null)
         {
            return;
         }
         UnknownVarFromMarketPlaceOwnItemsCatalogWidget_String_1 = normalizeSearchText(_loc1_.text);
         applySearchFilter();
      }
      
      private function clearSearch() : void
      {
         if(!window)
         {
            return;
         }
         var _loc1_:ITextFieldWindow = window.findChildByName("search_input") as ITextFieldWindow;
         if(_loc1_ != null)
         {
            _loc1_.text = "";
            _loc1_.scrollH = 0;
         }
         UnknownVarFromMarketPlaceOwnItemsCatalogWidget_String_1 = "";
         updateSearchUiState();
         applySearchFilter();
      }
      
      private function matchesSearch(param1:MarketPlaceOfferData) : Boolean
      {
         if(UnknownVarFromMarketPlaceOwnItemsCatalogWidget_String_1 == "")
         {
            return true;
         }
         return getOfferSearchText(param1).indexOf(UnknownVarFromMarketPlaceOwnItemsCatalogWidget_String_1) >= 0;
      }
      
      private function getOfferSearchText(param1:MarketPlaceOfferData) : String
      {
         if(param1 == null || marketPlace == null || marketPlace.localization == null)
         {
            return "";
         }
         var _loc2_:IHabboLocalizationManager = marketPlace.localization;
         var _loc3_:String = marketPlace.getNameLocalizationKey(param1);
         var _loc4_:String = marketPlace.getDescriptionLocalizationKey(param1);
         var _loc6_:String = _loc2_.getLocalization(_loc3_,"");
         var _loc5_:String = _loc2_.getLocalization(_loc4_,"");
         return normalizeSearchText(_loc6_ + " " + _loc5_);
      }
      
      private function normalizeSearchText(param1:String) : String
      {
         return param1 == null ? "" : param1.toLowerCase();
      }
      
      private function updateSearchUiState() : void
      {
         if(!window)
         {
            return;
         }
         var _loc1_:ITextFieldWindow = window.findChildByName("search_input") as ITextFieldWindow;
         var _loc3_:IWindowModel = window.findChildByName("search_placeholder");
         var _loc2_:IWindowModel = window.findChildByName("cancel_search_btn");
         var _loc4_:Boolean = _loc1_ != null && _loc1_.text.length > 0;
         if(_loc3_ != null)
         {
            _loc3_.visible = !_loc4_;
         }
         if(_loc2_ != null)
         {
            _loc2_.visible = _loc4_;
         }
      }
      
      private function getStatusText(param1:IHabboLocalizationManager, param2:MarketPlaceOfferData, param3:String, param4:String) : String
      {
         var _loc5_:String = param1.getLocalization(param3,"");
         if(param2 == null || isNaN(param2.statusTime) || param2.statusTime <= 0)
         {
            return _loc5_;
         }
         return param1.getLocalizationWithParams(param4,_loc5_,"timestamp",formatStatusTime(param2.statusTime));
      }
      
      private function formatStatusTime(param1:Number) : String
      {
         return new Date(param1).toLocaleString();
      }
      
      private function populateCategoryDropMenu() : void
      {
         if(!window || marketPlace == null || marketPlace.localization == null)
         {
            return;
         }
         var _loc2_:IDropBaseController_1 = window.findChildByName("offer_category_dropmenu") as IDropBaseController_1;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc1_:IHabboLocalizationManager = marketPlace.localization;
         var _loc3_:Array = [];
         _loc3_.push(_loc1_.getLocalization("shop.marketplace.own.offers.category.open","OPEN"));
         _loc3_.push(_loc1_.getLocalization("shop.marketplace.own.offers.category.sold","SOLD"));
         _loc3_.push(_loc1_.getLocalization("shop.marketplace.own.offers.category.expired","EXPIRED"));
         _ignoreCategorySelectionEvents = true;
         _loc2_.populate(_loc3_);
         _loc2_.selection = getDropMenuSelectionForCategory(UnknownVarFromMarketPlaceOwnItemsCatalogWidget_Int_1);
         _ignoreCategorySelectionEvents = false;
      }
      
      private function setSelectedCategory(param1:int) : void
      {
         var _loc3_:IDropBaseController_1 = null;
         var _loc2_:int = 0;
         UnknownVarFromMarketPlaceOwnItemsCatalogWidget_Int_1 = param1;
         if(window != null)
         {
            _loc3_ = window.findChildByName("offer_category_dropmenu") as IDropBaseController_1;
            if(_loc3_ != null)
            {
               _loc2_ = getDropMenuSelectionForCategory(param1);
               if(_loc3_.selection != _loc2_)
               {
                  _ignoreCategorySelectionEvents = true;
                  _loc3_.selection = _loc2_;
                  _ignoreCategorySelectionEvents = false;
               }
            }
         }
         clearCurrentOffersView();
         updateBottomActionButtons(false);
         if(marketPlace != null)
         {
            marketPlace.requestOwnItems(param1);
         }
      }
      
      private function clearCurrentOffersView() : void
      {
         clearVisibleItems();
         if(_offers != null)
         {
            _offers.dispose();
            _offers = null;
         }
         _allOffers = null;
         updateStatusDisplay(1);
         showRedeemInfo(false);
      }
      
      private function getDropMenuSelectionForCategory(param1:int) : int
      {
         switch(param1 - 2)
         {
            case 0:
               return 1;
            case 1:
               return 2;
            default:
               return 0;
         }
      }
      
      private function getCategoryForSelection(param1:int) : int
      {
         switch(param1 - 1)
         {
            case 0:
               return 2;
            case 1:
               return 3;
            default:
               return 1;
         }
      }
      
      private function clearVisibleItems() : void
      {
         if(_itemList == null)
         {
            return;
         }
         _itemList.autoArrangeItems = false;
         while(_itemList.numListItems > 0)
         {
            recycleItemWindow(_itemList.removeListItemAt(0) as IWindowController_1);
         }
         _itemList.autoArrangeItems = true;
         if(_offerWindowsById != null)
         {
            _offerWindowsById.reset();
         }
      }
      
      private function claimItemWindow(param1:int) : IWindowController_1
      {
         var _loc2_:Vector.<IWindowController_1> = getItemPool(param1);
         if(_loc2_.length > 0)
         {
            return _loc2_.pop();
         }
         var _loc3_:IWindowController_1 = _itemTemplates.getValue(param1) as IWindowController_1;
         return _loc3_ == null ? null : _loc3_.clone() as IWindowController_1;
      }
      
      private function recycleItemWindow(param1:IWindowController_1) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:int = getStatusForWindow(param1);
         var _loc2_:Vector.<IWindowController_1> = getItemPool(_loc3_);
         if(_loc2_ == null || _loc2_.length >= 2000)
         {
            param1.dispose();
            return;
         }
         resetPooledWindow(param1);
         _loc2_.push(param1);
      }
      
      private function getItemPool(param1:int) : Vector.<IWindowController_1>
      {
         if(_itemPools == null || param1 < 0)
         {
            return null;
         }
         var _loc2_:Vector.<IWindowController_1> = _itemPools.getValue(param1) as Vector.<IWindowController_1>;
         if(_loc2_ == null)
         {
            _loc2_ = new Vector.<IWindowController_1>(0);
            _itemPools.add(param1,_loc2_);
         }
         return _loc2_;
      }
      
      private function disposeItemPool(param1:Vector.<IWindowController_1>) : void
      {
         if(param1 == null)
         {
            return;
         }
         for each(var _loc2_ in param1)
         {
            if(_loc2_ != null)
            {
               _loc2_.dispose();
            }
         }
         param1.length = 0;
      }
      
      private function resetPooledWindow(param1:IWindowController_1) : void
      {
         param1.id = 0;
         param1.procedure = null;
         var _loc4_:IBitmapWrapperController = param1.findChildByName("item_image") as IBitmapWrapperController;
         if(_loc4_ != null)
         {
            _loc4_.bitmap = null;
         }
         var _loc5_:IWindowModel = param1.findChildByName("unique_item_background_bitmap");
         if(_loc5_ != null)
         {
            _loc5_.visible = false;
         }
         var _loc2_:IWidgetWindowController = param1.findChildByName("unique_item_overlay_widget") as IWidgetWindowController;
         if(_loc2_ != null)
         {
            _loc2_.visible = false;
         }
         var _loc3_:IWidgetWindowController = param1.findChildByName("rarity_item_overlay_widget") as IWidgetWindowController;
         if(_loc3_ != null)
         {
            _loc3_.visible = false;
         }
      }
      
      private function getStatusForWindow(param1:IWindowController_1) : int
      {
         if(param1 == null)
         {
            return -1;
         }
         switch(param1.name)
         {
            case "ongoing_item":
               return 1;
            case "sold_item":
               return 2;
            case "expired_item":
               return 3;
            default:
               return -1;
         }
      }
      
      private function onRecallAllConfirm(param1:UnknownICoreWindowUtils2, param2:WindowEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.dispose();
         if(param2.type != "WE_OK" || marketPlace == null)
         {
            return;
         }
         marketPlace.recallAllOffers();
      }
      
      private function onMarkAsSeenConfirm(param1:UnknownICoreWindowUtils2, param2:WindowEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.dispose();
         if(param2.type != "WE_OK" || marketPlace == null)
         {
            return;
         }
         marketPlace.clearOwnHistory(UnknownVarFromMarketPlaceOwnItemsCatalogWidget_Int_1);
      }
      
      public function updateStats() : void
      {
      }
   }
}

