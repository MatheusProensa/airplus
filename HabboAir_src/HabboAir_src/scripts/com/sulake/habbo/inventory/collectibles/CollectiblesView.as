package com.sulake.habbo.inventory.collectibles
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.habbo.catalog.collectibles.ICollectiblesController;
   import com.sulake.habbo.communication.messages.parser.collectibles.trading.TradeNftItem;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.widgets.IProductImageWidget;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class CollectiblesView implements IInventoryView, UnknownIHabboAvatar1
   {
      private static const IMAGE_UPDATE_DELAY_MS:int = 30;
      
      private static const FILTER_OPTIONS:Array = [1,0,11,9,4,2,10];
      
      private const STATE_NULL:int = 0;
      
      private const STATE_INITIALIZING:int = 1;
      
      private const STATE_EMPTY:int = 2;
      
      private const STATE_CONTENT:int = 3;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var UnknownVarFromCollectiblesView_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromCollectiblesView_CollectiblesModel_1:CollectiblesModel;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromCollectiblesView_Boolean_1:Boolean = false;
      
      private var UnknownVarFromCollectiblesView_CollectiblesGridView_1:CollectiblesGridView;
      
      private var _groupedItems:Map = new Map();
      
      private var UnknownVarFromCollectiblesView_Int_1:int = 0;
      
      private var UnknownVarFromCollectiblesView_Timer_1:Timer;
      
      public function CollectiblesView(param1:CollectiblesModel, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection)
      {
         super();
         UnknownVarFromCollectiblesView_CollectiblesModel_1 = param1;
         _windowManager = param2;
         UnknownVarFromCollectiblesView_Timer_1 = new Timer(30);
         UnknownVarFromCollectiblesView_Timer_1.addEventListener("timer",onImageUpdateTimerEvent);
         UnknownVarFromCollectiblesView_Timer_1.start();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get isVisible() : Boolean
      {
         return UnknownVarFromCollectiblesView_IWindowController_1_1 && UnknownVarFromCollectiblesView_IWindowController_1_1.parent != null && UnknownVarFromCollectiblesView_IWindowController_1_1.visible;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         _windowManager = null;
         UnknownVarFromCollectiblesView_CollectiblesModel_1 = null;
         if(UnknownVarFromCollectiblesView_CollectiblesGridView_1 != null)
         {
            UnknownVarFromCollectiblesView_CollectiblesGridView_1.dispose();
            UnknownVarFromCollectiblesView_CollectiblesGridView_1 = null;
         }
         if(UnknownVarFromCollectiblesView_IWindowController_1_1)
         {
            UnknownVarFromCollectiblesView_IWindowController_1_1.dispose();
            UnknownVarFromCollectiblesView_IWindowController_1_1 = null;
         }
         if(UnknownVarFromCollectiblesView_Timer_1 != null)
         {
            UnknownVarFromCollectiblesView_Timer_1.removeEventListener("timer",onImageUpdateTimerEvent);
            UnknownVarFromCollectiblesView_Timer_1.stop();
            UnknownVarFromCollectiblesView_Timer_1 = null;
         }
      }
      
      public function getWindowContainer() : IWindowController_1
      {
         if(!UnknownVarFromCollectiblesView_Boolean_1)
         {
            init();
         }
         if(UnknownVarFromCollectiblesView_IWindowController_1_1 == null || Boolean(UnknownVarFromCollectiblesView_IWindowController_1_1.disposed))
         {
            return null;
         }
         return UnknownVarFromCollectiblesView_IWindowController_1_1;
      }
      
      public function initCollectibles(param1:Vector.<TradeNftItem>, param2:Vector.<TradeNftItem>) : void
      {
         var _loc5_:CollectibleGroupedItem = null;
         var _loc8_:String = null;
         var _loc6_:* = undefined;
         for each(var _loc3_ in param1)
         {
            _loc8_ = groupKey(_loc3_);
            if(_groupedItems.hasKey(_loc8_))
            {
               _loc5_ = _groupedItems.getValue(_loc8_);
               _loc5_.addAssetId(_loc3_.assetId);
            }
            else
            {
               _loc6_ = new Vector.<Number>();
               _loc6_.push(_loc3_.assetId);
               _loc5_ = new CollectibleGroupedItem(_loc3_,_loc6_,UnknownVarFromCollectiblesView_CollectiblesModel_1);
               _groupedItems.add(_loc8_,_loc5_);
            }
         }
         for each(var _loc9_ in param2)
         {
            _loc8_ = groupKey(_loc9_);
            if(_groupedItems.hasKey(_loc8_))
            {
               _loc5_ = _groupedItems.getValue(_loc8_);
               if(_loc5_.removeAssetId(_loc9_.assetId))
               {
                  if(_loc5_.amount == 0)
                  {
                     _loc5_.dispose();
                     _groupedItems.remove(_loc8_);
                  }
               }
            }
         }
         var _loc7_:Vector.<CollectibleGroupedItem> = new Vector.<CollectibleGroupedItem>();
         for each(var _loc4_ in _groupedItems.getValues())
         {
            _loc7_.push(_loc4_);
         }
         UnknownVarFromCollectiblesView_CollectiblesGridView_1.setItems(_loc7_);
         updateState();
         updatePreview();
      }
      
      private function maybeSelectFirst() : void
      {
         if(UnknownVarFromCollectiblesView_CollectiblesModel_1.selected == null && UnknownVarFromCollectiblesView_CollectiblesGridView_1.currentPageItems != null && UnknownVarFromCollectiblesView_CollectiblesGridView_1.currentPageItems.length > 0)
         {
            UnknownVarFromCollectiblesView_CollectiblesModel_1.setSelected(UnknownVarFromCollectiblesView_CollectiblesGridView_1.currentPageItems[0]);
         }
      }
      
      public function unlockAll() : void
      {
         var _loc1_:Array = _groupedItems.getValues();
         for each(var _loc2_ in _loc1_)
         {
            _loc2_.unlockAll();
         }
      }
      
      public function findGroupedItem(param1:TradeNftItem, param2:Boolean = true) : CollectibleGroupedItem
      {
         var _loc4_:String = groupKey(param1);
         var _loc3_:CollectibleGroupedItem = _groupedItems.getValue(_loc4_);
         if(_loc3_ == null)
         {
            return null;
         }
         if(!param2 || _loc3_.hasAsset(param1.assetId))
         {
            return _loc3_;
         }
         return null;
      }
      
      public function updateFilters() : void
      {
         if(!UnknownVarFromCollectiblesView_Boolean_1)
         {
            return;
         }
         if(UnknownVarFromCollectiblesView_IWindowController_1_1 == null || Boolean(UnknownVarFromCollectiblesView_IWindowController_1_1.disposed))
         {
            return;
         }
         var _loc2_:int = filterOptions.selection;
         var _loc1_:int = int(_loc2_ <= 0 ? -1 : FILTER_OPTIONS[_loc2_ - 1]);
         UnknownVarFromCollectiblesView_CollectiblesGridView_1.setFilter(_loc1_,filterText.caption);
      }
      
      private function groupKey(param1:TradeNftItem) : String
      {
         return param1.productCode;
      }
      
      public function updatePreview() : void
      {
         if(!UnknownVarFromCollectiblesView_Boolean_1)
         {
            return;
         }
         maybeSelectFirst();
         if(UnknownVarFromCollectiblesView_IWindowController_1_1 == null || Boolean(UnknownVarFromCollectiblesView_IWindowController_1_1.disposed))
         {
            return;
         }
         var _loc4_:CollectibleGroupedItem = UnknownVarFromCollectiblesView_CollectiblesModel_1.selected;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc1_:ICollectiblesController = UnknownVarFromCollectiblesView_CollectiblesModel_1.controller.catalog.collectorHub;
         var _loc2_:String = _loc1_.getProductName(_loc4_.renderableItem);
         var _loc3_:String = _loc1_.getProductType(_loc4_.renderableItem);
         (nftImageWidget.widget as IProductImageWidget).productInfo = _loc4_.renderableItem;
         nftNameText.text = _loc2_;
         nftTypeText.text = UnknownVarFromCollectiblesView_CollectiblesModel_1.controller.localization.getLocalization("collectibles.item.type") + ": " + _loc3_;
         if(_loc4_ == null || _loc4_.unlockedAssetCount == 0)
         {
            offerButton.disable();
         }
         else
         {
            offerButton.enable();
         }
      }
      
      private function init() : void
      {
         UnknownVarFromCollectiblesView_IWindowController_1_1 = UnknownVarFromCollectiblesView_CollectiblesModel_1.controller.view.getView("collectibles");
         UnknownVarFromCollectiblesView_IWindowController_1_1.procedure = windowEventProc;
         UnknownVarFromCollectiblesView_IWindowController_1_1.visible = false;
         var _loc1_:IItemGridWindow = UnknownVarFromCollectiblesView_IWindowController_1_1.findChildByName("item_grid") as IItemGridWindow;
         var _loc2_:IItemListWindow = UnknownVarFromCollectiblesView_IWindowController_1_1.findChildByName("item_grid_pages") as IItemListWindow;
         UnknownVarFromCollectiblesView_CollectiblesGridView_1 = new CollectiblesGridView(this,_loc1_,_loc2_);
         UnknownVarFromCollectiblesView_IWindowController_1_1.findChildByName("filter").caption = "";
         populateFilterOptions();
         UnknownVarFromCollectiblesView_Boolean_1 = true;
         updateState();
      }
      
      private function onImageUpdateTimerEvent(param1:TimerEvent) : void
      {
         initListImages();
      }
      
      private function initListImages() : void
      {
         if(UnknownVarFromCollectiblesView_CollectiblesGridView_1 && UnknownVarFromCollectiblesView_CollectiblesGridView_1.currentPageItems)
         {
            for each(var _loc1_ in UnknownVarFromCollectiblesView_CollectiblesGridView_1.currentPageItems)
            {
               if(!_loc1_.isInitialized)
               {
                  _loc1_.initializeImage();
                  break;
               }
            }
         }
      }
      
      private function populateFilterOptions() : void
      {
         var _loc3_:Array = [];
         var _loc2_:IHabboLocalizationManager = UnknownVarFromCollectiblesView_CollectiblesModel_1.controller.localization;
         _loc3_.push(_loc2_.getLocalization("inventory.filter.option.everything","Everything"));
         for each(var _loc1_ in FILTER_OPTIONS)
         {
            switch(_loc1_)
            {
               case 0:
                  _loc3_.push(_loc2_.getLocalization("product.type.wall"));
                  break;
               case 1:
                  _loc3_.push(_loc2_.getLocalization("product.type.room"));
                  break;
               case 2:
                  _loc3_.push(_loc2_.getLocalization("product.type.effect"));
                  break;
               case 4:
                  _loc3_.push(_loc2_.getLocalization("product.type.badge"));
                  break;
               case 9:
                  _loc3_.push(_loc2_.getLocalization("product.type.chatstyle"));
                  break;
               case 10:
                  _loc3_.push(_loc2_.getLocalization("product.type.pets"));
                  break;
               case 11:
                  _loc3_.push(_loc2_.getLocalization("product.type.clothing"));
                  break;
            }
         }
         filterOptions.populate(_loc3_);
         filterOptions.selection = 0;
      }
      
      public function updateState() : void
      {
         var _loc1_:int = 0;
         if(!UnknownVarFromCollectiblesView_Boolean_1)
         {
            return;
         }
         var _loc2_:Map = UnknownVarFromCollectiblesView_CollectiblesModel_1.items;
         if(!UnknownVarFromCollectiblesView_CollectiblesModel_1.isListInitialized())
         {
            _loc1_ = 1;
         }
         else if(!_loc2_ || _loc2_.length == 0)
         {
            _loc1_ = 2;
         }
         else
         {
            _loc1_ = 3;
         }
         if(UnknownVarFromCollectiblesView_Int_1 == _loc1_)
         {
            return;
         }
         UnknownVarFromCollectiblesView_Int_1 = _loc1_;
         updateContainerVisibility();
      }
      
      public function updateContainerVisibility() : void
      {
         if(UnknownVarFromCollectiblesView_CollectiblesModel_1.controller.currentCategoryId != "collectibles")
         {
            return;
         }
         var _loc1_:IWindowController_1 = UnknownVarFromCollectiblesView_CollectiblesModel_1.controller.view.loadingContainer;
         var _loc4_:IWindowController_1 = UnknownVarFromCollectiblesView_CollectiblesModel_1.controller.view.emptyContainer;
         var _loc5_:IWindowModel = UnknownVarFromCollectiblesView_IWindowController_1_1.findChildByName("grid_container");
         var _loc3_:IWindowModel = UnknownVarFromCollectiblesView_IWindowController_1_1.findChildByName("options_container");
         var _loc2_:IWindowModel = UnknownVarFromCollectiblesView_IWindowController_1_1.findChildByName("preview_container");
         switch(UnknownVarFromCollectiblesView_Int_1 - 1)
         {
            case 0:
               if(_loc1_)
               {
                  _loc1_.visible = true;
               }
               if(_loc4_)
               {
                  _loc4_.visible = false;
               }
               _loc5_.visible = false;
               _loc3_.visible = false;
               _loc2_.visible = false;
               break;
            case 1:
               if(_loc1_)
               {
                  _loc1_.visible = false;
               }
               if(_loc4_)
               {
                  _loc4_.visible = true;
               }
               _loc5_.visible = false;
               _loc3_.visible = false;
               _loc2_.visible = false;
               break;
            case 2:
               if(_loc1_)
               {
                  _loc1_.visible = false;
               }
               if(_loc4_)
               {
                  _loc4_.visible = false;
               }
               _loc5_.visible = true;
               _loc3_.visible = true;
               _loc2_.visible = true;
         }
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc4_:int = 0;
         var _loc3_:WindowKeyboardEvent = null;
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "clear_filter_button":
                  UnknownVarFromCollectiblesView_IWindowController_1_1.findChildByName("filter").caption = "";
                  param2.visible = false;
                  updateFilters();
                  break;
               case "offertotrade_btn":
                  _loc4_ = Math.min(Math.max(1,int(offerAmountInput.caption)),UnknownVarFromCollectiblesView_CollectiblesModel_1.selected.unlockedAssetCount);
                  if(_loc4_ != int(offerAmountInput.caption))
                  {
                     offerAmountInput.caption = String(_loc4_);
                  }
                  UnknownVarFromCollectiblesView_CollectiblesModel_1.requestAddTrading(UnknownVarFromCollectiblesView_CollectiblesModel_1.selected,_loc4_);
            }
         }
         else if(param1.type == "WKE_KEY_UP")
         {
            _loc3_ = param1 as WindowKeyboardEvent;
            var _loc5_:* = param2.name;
            if("filter" === _loc5_)
            {
               UnknownVarFromCollectiblesView_IWindowController_1_1.findChildByName("clear_filter_button").visible = param2.caption.length > 0;
               if(_loc3_.keyCode == 13)
               {
                  updateFilters();
               }
            }
         }
         if(param1.type == "WE_SELECTED")
         {
            _loc5_ = param2.name;
            if("filter.options" === _loc5_)
            {
               updateFilters();
            }
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
      }
      
      private function get nftImageWidget() : IWidgetWindowController
      {
         return UnknownVarFromCollectiblesView_IWindowController_1_1.findChildByName("nft_image") as IWidgetWindowController;
      }
      
      private function get nftNameText() : ITextWindow
      {
         return UnknownVarFromCollectiblesView_IWindowController_1_1.findChildByName("nft_name") as ITextWindow;
      }
      
      private function get nftTypeText() : ITextWindow
      {
         return UnknownVarFromCollectiblesView_IWindowController_1_1.findChildByName("nft_type") as ITextWindow;
      }
      
      private function get offerAmountInput() : ITextFieldWindow
      {
         return UnknownVarFromCollectiblesView_IWindowController_1_1.findChildByName("offertotrade_cnt") as ITextFieldWindow;
      }
      
      private function get offerButton() : UnknownICoreWindowComponents4
      {
         return UnknownVarFromCollectiblesView_IWindowController_1_1.findChildByName("offertotrade_btn") as UnknownICoreWindowComponents4;
      }
      
      private function get filterOptions() : IDropBaseController_1
      {
         return UnknownVarFromCollectiblesView_IWindowController_1_1.findChildByName("filter.options") as IDropBaseController_1;
      }
      
      private function get filterText() : ITextFieldWindow
      {
         return UnknownVarFromCollectiblesView_IWindowController_1_1.findChildByName("filter") as ITextFieldWindow;
      }
   }
}

