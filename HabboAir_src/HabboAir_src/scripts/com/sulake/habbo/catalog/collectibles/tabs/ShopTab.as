package com.sulake.habbo.catalog.collectibles.tabs
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.collectibles.CollectiblesController;
   import com.sulake.habbo.catalog.collectibles.CollectiblesView;
   import com.sulake.habbo.catalog.collectibles.renderer.ShopCollectibleItemRenderer;
   import com.sulake.habbo.catalog.collectibles.renderer.collections.CollectionsNavigationNodeRenderer;
   import com.sulake.habbo.catalog.collectibles.renderer.collections.ShopNavigationNodeRenderer;
   import com.sulake.habbo.catalog.collectibles.tabs.subviews.CollectibleProductPreviewer;
   import com.sulake.habbo.catalog.collectibles.tabs.subviews.CollectionView;
   import com.sulake.habbo.catalog.purse.IPurse;
   import com.sulake.habbo.communication.messages.incoming.collectibles.NftStoreOffersMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.GetNftStoreOffersMessageComposer;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftStoreOffer;
   
   public class ShopTab implements IProfiler_1
   {
      public static var BG_STAR_ROTATE_SPEED:Number = 20;
      
      public static var UnknownVarFromShopTab_Number_1:Number = 90;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromShopTab_CollectiblesView_1:CollectiblesView;
      
      private var _controller:CollectiblesController;
      
      private var UnknownVarFromShopTab_IWindowController_1_1:IWindowController_1;
      
      private var _navigationList:IItemListWindow;
      
      private var _renderableItems:Vector.<ShopNavigationNodeRenderer>;
      
      private var _navigationItemTemplate:IWindowModel;
      
      private var _waitingForOffers:Boolean;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var UnknownVarFromShopTab_ShopNavigationNodeRenderer_1:ShopNavigationNodeRenderer;
      
      private var UnknownVarFromShopTab_CollectionView_1:CollectionView;
      
      private var UnknownVarFromShopTab_IStaticBitmapWrapperWindow_1:IStaticBitmapWrapperWindow;
      
      private var _loadingIcon:IStaticBitmapWrapperWindow;
      
      private var UnknownVarFromShopTab_Boolean_1:Boolean;
      
      private var _gridItemTemplate:IWindowController_1;
      
      private var _itemGrid:IItemGridWindow;
      
      private var _gridItems:Vector.<ShopCollectibleItemRenderer>;
      
      private var UnknownVarFromShopTab_ShopCollectibleItemRenderer_1:ShopCollectibleItemRenderer;
      
      private var UnknownVarFromShopTab_CollectibleProductPreviewer_1:CollectibleProductPreviewer;
      
      private var _currentOffers:Array = [];
      
      private var _offersByCategory:Object = {};
      
      public function ShopTab(param1:CollectiblesView, param2:CollectiblesController)
      {
         super();
         UnknownVarFromShopTab_CollectiblesView_1 = param1;
         _controller = param2;
         UnknownVarFromShopTab_IWindowController_1_1 = IWindowController_1(UnknownVarFromShopTab_CollectiblesView_1.window.findChildByName("shopContainer"));
         _navigationList = IItemListWindow(UnknownVarFromShopTab_IWindowController_1_1.findChildByName("navigationList"));
         _navigationItemTemplate = _navigationList.removeListItem(_navigationList.getListItemByName("item_template"));
         _renderableItems = new Vector.<ShopNavigationNodeRenderer>();
         var _loc3_:IItemGridWindow = UnknownVarFromShopTab_IWindowController_1_1.findChildByName("itemgrid_shop") as IItemGridWindow;
         _itemGrid = _loc3_;
         _gridItemTemplate = _loc3_.getGridItemAt(0) as IWindowController_1;
         _loc3_.removeGridItems();
         _gridItems = new Vector.<ShopCollectibleItemRenderer>();
         UnknownVarFromShopTab_CollectibleProductPreviewer_1 = new CollectibleProductPreviewer(productPreviewBitmap,badgeImageWidget,petImageWidget,unknownImageWindow,avatarImageWidget,placeholderImage,effectImageWidget,controller.avatarRenderManager);
         UnknownVarFromShopTab_CollectibleProductPreviewer_1.setPlaceholder();
         setReady(false);
         addMessageEvents();
         requestNftStoreOffers();
         buyButton.addEventListener("WME_CLICK",onClickBuy);
         UnknownVarFromShopTab_IStaticBitmapWrapperWindow_1 = IStaticBitmapWrapperWindow(UnknownVarFromShopTab_IWindowController_1_1.findChildByName("bg_star"));
         _loadingIcon = IStaticBitmapWrapperWindow(UnknownVarFromShopTab_IWindowController_1_1.findChildByName("loading_icon"));
         controller.registerUpdateReceiver(this,1);
      }
      
      private function addMessageEvents() : void
      {
         _messageEvents = new Vector.<IMessageEvent>(0);
         _messageEvents.push(new NftStoreOffersMessageEvent(onNftStoreOffers));
         for each(var _loc1_ in _messageEvents)
         {
            _controller.addMessageEvent(_loc1_);
         }
      }
      
      private function onNftStoreOffers(param1:NftStoreOffersMessageEvent) : void
      {
         if(!_waitingForOffers || _navigationList.numListItems != 0)
         {
            return;
         }
         _waitingForOffers = false;
         var _loc2_:Array = param1.getParser().nftStoreOffers;
         _currentOffers = _loc2_;
         createNavigationNodes();
         if(_renderableItems.length > 0)
         {
            activateCategory(_renderableItems[0]);
         }
         setReady(true);
         collectionContainer.visible = _renderableItems.length > 0;
      }
      
      private function createNavigationNodes() : void
      {
         var _loc3_:String = null;
         var _loc2_:ShopNavigationNodeRenderer = null;
         for each(var _loc1_ in _currentOffers)
         {
            if(_loc1_ != null)
            {
               _loc3_ = _controller.localizationManager.getLocalization(getNavigationCategory(_loc1_.productInfo.productTypeId));
               if(!_offersByCategory.hasOwnProperty(_loc3_))
               {
                  _offersByCategory[_loc3_] = [];
                  _loc2_ = new ShopNavigationNodeRenderer(this,_loc3_);
                  _navigationList.addListItem(_loc2_.window);
                  _renderableItems.push(_loc2_);
               }
               _offersByCategory[_loc3_].push(_loc1_);
            }
         }
      }
      
      private function getNavigationCategory(param1:int) : String
      {
         switch(param1)
         {
            case 0:
            case 1:
               return "shop.furni.title";
            case 10:
               return "shop.pets.title";
            case 11:
               return "shop.clothes.title";
            default:
               return "product.type.other";
         }
      }
      
      private function setReady(param1:Boolean) : void
      {
         loadedContainer.visible = param1;
         loadingContainer.visible = !param1;
         UnknownVarFromShopTab_Boolean_1 = param1;
      }
      
      private function requestNftStoreOffers() : void
      {
         clearNavigationList();
         _waitingForOffers = true;
         _controller.send(new GetNftStoreOffersMessageComposer());
      }
      
      public function activateCategory(param1:ShopNavigationNodeRenderer) : void
      {
         if(UnknownVarFromShopTab_ShopNavigationNodeRenderer_1 == param1)
         {
            return;
         }
         if(UnknownVarFromShopTab_ShopNavigationNodeRenderer_1 != null)
         {
            UnknownVarFromShopTab_ShopNavigationNodeRenderer_1.deactivate();
         }
         UnknownVarFromShopTab_ShopNavigationNodeRenderer_1 = param1;
         UnknownVarFromShopTab_ShopNavigationNodeRenderer_1.activate();
         populateGridItems();
      }
      
      public function populateGridItems() : void
      {
         var _loc4_:IWindowController_1 = null;
         var _loc3_:ShopCollectibleItemRenderer = null;
         clearGridItems();
         if(_offersByCategory[UnknownVarFromShopTab_ShopNavigationNodeRenderer_1.category].length <= 0)
         {
            return;
         }
         var _loc1_:IWindowController_1 = gridItemTemplate;
         for each(var _loc2_ in _offersByCategory[UnknownVarFromShopTab_ShopNavigationNodeRenderer_1.category])
         {
            _loc4_ = _loc1_.clone() as IWindowController_1;
            _loc3_ = new ShopCollectibleItemRenderer(controller,_loc2_,_loc4_,this);
            itemGrid.addGridItem(_loc4_);
            _gridItems.push(_loc3_);
         }
         selectItem(_gridItems[0]);
      }
      
      public function clearGridItems() : void
      {
         UnknownVarFromShopTab_ShopCollectibleItemRenderer_1 = null;
         if(_gridItems)
         {
            for each(var _loc1_ in _gridItems)
            {
               _loc1_.dispose();
            }
            _gridItems.length = 0;
         }
         if(itemGrid)
         {
            itemGrid.destroyGridItems();
         }
      }
      
      public function selectItem(param1:ShopCollectibleItemRenderer) : void
      {
         if(UnknownVarFromShopTab_ShopCollectibleItemRenderer_1 != null)
         {
            UnknownVarFromShopTab_ShopCollectibleItemRenderer_1.deactivate();
            UnknownVarFromShopTab_ShopCollectibleItemRenderer_1 = null;
         }
         if(param1 != null)
         {
            UnknownVarFromShopTab_ShopCollectibleItemRenderer_1 = param1;
            UnknownVarFromShopTab_ShopCollectibleItemRenderer_1.activate();
            initItemPreview();
         }
         else
         {
            UnknownVarFromShopTab_ShopCollectibleItemRenderer_1 = null;
         }
      }
      
      private function initItemPreview() : void
      {
         if(UnknownVarFromShopTab_ShopCollectibleItemRenderer_1 == null)
         {
            return;
         }
         var _loc2_:ShopCollectibleItemRenderer = UnknownVarFromShopTab_ShopCollectibleItemRenderer_1;
         var _loc1_:NftStoreOffer = _loc2_.offer;
         UnknownVarFromShopTab_CollectibleProductPreviewer_1.clearPreviewer();
         _controller.previewImage(_loc2_.renderableItem,UnknownVarFromShopTab_CollectibleProductPreviewer_1);
         productNameText.caption = _controller.getProductName(_loc2_.renderableItem);
         emeraldPriceText.caption = _loc1_.emeraldPrice.toString();
         var _loc3_:* = _loc1_.mintLimit > 0;
         mintLimitContainer.visible = _loc3_;
         if(_loc3_)
         {
            mintLimitText.caption = _loc1_.mintedCount + "/" + _loc1_.mintLimit;
         }
         if(_loc1_.mintedCount < _loc1_.mintLimit || _loc1_.mintLimit == -1)
         {
            buyButton.enable();
         }
         else
         {
            buyButton.disable();
         }
      }
      
      private function onClickBuy(param1:WindowMouseEvent) : void
      {
         var _loc2_:NftStorePurchaseOffer = new NftStorePurchaseOffer(UnknownVarFromShopTab_ShopCollectibleItemRenderer_1.offer);
         var _loc3_:IPurse = controller.catalog.getPurse();
         if(_loc3_.emeraldBalance < _loc2_.priceInEmerald)
         {
            HabboCatalog(_controller.catalog).showNotEnoughActivityPointsAlert(1001);
            return;
         }
         HabboCatalog(_controller.catalog).showPurchaseConfirmation(_loc2_,-1,activeWallet);
      }
      
      public function get navigationItemTemplate() : IWindowModel
      {
         return _navigationItemTemplate;
      }
      
      private function get collectionContainer() : IWindowController_1
      {
         return UnknownVarFromShopTab_IWindowController_1_1.findChildByName("collection_content") as IWindowController_1;
      }
      
      private function get loadingContainer() : IWindowController_1
      {
         return UnknownVarFromShopTab_IWindowController_1_1.findChildByName("loading_contents") as IWindowController_1;
      }
      
      private function get loadedContainer() : IWindowController_1
      {
         return UnknownVarFromShopTab_IWindowController_1_1.findChildByName("loaded_content") as IWindowController_1;
      }
      
      private function clearNavigationList() : void
      {
         UnknownVarFromShopTab_ShopNavigationNodeRenderer_1 = null;
         _navigationList.removeListItems();
         for each(var _loc1_ in _renderableItems)
         {
            _loc1_.dispose();
         }
         _renderableItems.length = 0;
      }
      
      private function removeMessageEvents() : void
      {
         if(!_controller || !_messageEvents)
         {
            return;
         }
         for each(var _loc1_ in _messageEvents)
         {
            _controller.removeMessageEvent(_loc1_);
            _loc1_.dispose();
         }
         _messageEvents = null;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         controller.removeUpdateReceiver(this);
         UnknownVarFromShopTab_CollectibleProductPreviewer_1.clearPreviewer();
         clearNavigationList();
         clearGridItems();
         removeMessageEvents();
         buyButton.removeEventListener("WME_CLICK",onClickBuy);
         if(UnknownVarFromShopTab_ShopNavigationNodeRenderer_1 != null)
         {
            UnknownVarFromShopTab_ShopNavigationNodeRenderer_1.dispose();
            UnknownVarFromShopTab_ShopNavigationNodeRenderer_1 = null;
         }
      }
      
      public function get controller() : CollectiblesController
      {
         return _controller;
      }
      
      public function get activeWallet() : String
      {
         return UnknownVarFromShopTab_CollectiblesView_1.activeWallet;
      }
      
      public function get gridItemTemplate() : IWindowController_1
      {
         return _gridItemTemplate;
      }
      
      public function get itemGrid() : IItemGridWindow
      {
         return _itemGrid;
      }
      
      private function get avatarImageWidget() : IWidgetWindowController
      {
         return UnknownVarFromShopTab_IWindowController_1_1.findChildByName("avatar_image_widget") as IWidgetWindowController;
      }
      
      private function get badgeImageWidget() : IWidgetWindowController
      {
         return UnknownVarFromShopTab_IWindowController_1_1.findChildByName("badge_image_widget") as IWidgetWindowController;
      }
      
      private function get petImageWidget() : IWidgetWindowController
      {
         return UnknownVarFromShopTab_IWindowController_1_1.findChildByName("pet_image_widget") as IWidgetWindowController;
      }
      
      private function get effectImageWidget() : IWidgetWindowController
      {
         return UnknownVarFromShopTab_IWindowController_1_1.findChildByName("effect_image_widget") as IWidgetWindowController;
      }
      
      private function get unknownImageWindow() : IStaticBitmapWrapperWindow
      {
         return UnknownVarFromShopTab_IWindowController_1_1.findChildByName("unknown_image") as IStaticBitmapWrapperWindow;
      }
      
      private function get placeholderImage() : IStaticBitmapWrapperWindow
      {
         return UnknownVarFromShopTab_IWindowController_1_1.findChildByName("placeholder_image") as IStaticBitmapWrapperWindow;
      }
      
      private function get productPreviewBitmap() : IBitmapWrapperController
      {
         return UnknownVarFromShopTab_IWindowController_1_1.findChildByName("product_preview") as IBitmapWrapperController;
      }
      
      private function get productNameText() : ITextWindow
      {
         return UnknownVarFromShopTab_IWindowController_1_1.findChildByName("preview_furni_name") as ITextWindow;
      }
      
      private function get buyButton() : UnknownICoreWindowComponents4
      {
         return UnknownVarFromShopTab_IWindowController_1_1.findChildByName("buy_button") as UnknownICoreWindowComponents4;
      }
      
      private function get emeraldPriceText() : ITextWindow
      {
         return UnknownVarFromShopTab_IWindowController_1_1.findChildByName("price_text") as ITextWindow;
      }
      
      private function get mintLimitText() : ITextWindow
      {
         return UnknownVarFromShopTab_IWindowController_1_1.findChildByName("mintlimit_text") as ITextWindow;
      }
      
      private function get mintLimitContainer() : IWindowModel
      {
         return UnknownVarFromShopTab_IWindowController_1_1.findChildByName("mintlimit_container") as IWindowModel;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:Number = NaN;
         _loc2_ = NaN;
         if(UnknownVarFromShopTab_Boolean_1)
         {
            _loc2_ = BG_STAR_ROTATE_SPEED * (param1 / 1000);
            UnknownVarFromShopTab_IStaticBitmapWrapperWindow_1.rotation += _loc2_;
            UnknownVarFromShopTab_IStaticBitmapWrapperWindow_1.rotation %= 360;
            UnknownVarFromShopTab_IStaticBitmapWrapperWindow_1.invalidate();
            if(UnknownVarFromShopTab_CollectionView_1 != null)
            {
               UnknownVarFromShopTab_CollectionView_1.updateBonusProgressBar(false,param1);
            }
         }
         else
         {
            _loc2_ = UnknownVarFromShopTab_Number_1 * (param1 / 1000);
            _loadingIcon.rotation += _loc2_;
            _loadingIcon.rotation %= 360;
            _loadingIcon.invalidate();
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

