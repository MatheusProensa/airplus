package com.sulake.habbo.catalog.collectibles.tabs
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.components.IHTMLTextController;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils2;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.collectibles.CollectiblesController;
   import com.sulake.habbo.catalog.collectibles.CollectiblesView;
   import com.sulake.habbo.catalog.collectibles.IRenderableCollectibleItem;
   import com.sulake.habbo.catalog.collectibles.renderer.MintInventoryItemRenderer;
   import com.sulake.habbo.catalog.collectibles.renderer.model.MintableItemWrapper;
   import com.sulake.habbo.catalog.collectibles.tabs.subviews.CollectibleProductPreviewer;
   import com.sulake.habbo.catalog.event.CatalogEvent;
   import com.sulake.habbo.communication.messages.incoming.collectibles.CollectableMintableItemTypesMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.collectibles.CollectibleMintTokenCountMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.collectibles.CollectibleMintTokenOffersMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.collectibles.CollectibleMintableItemResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.collectibles.CollectibleMintingEnabledMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.GetCollectibleMintTokensMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.GetCollectibleMintableItemTypesMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.GetCollectibleMintingEnabledMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.GetMintTokenOffersMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.MintItemMessageComposer;
   import com.sulake.habbo.communication.messages.parser.collectibles.CollectibleMintableItemResultMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.collectibles.CollectiblesProductItem;
   import com.sulake.habbo.communication.messages.parser.collectibles.MintTokenOffer;
   import com.sulake.habbo.inventory.IHabboInventory;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.utils.HabboWebTools;
   
   public class MintInventoryListTab implements IProfiler_1
   {
      private static var PROGRESS_BAR_UPDATE_THRESHOLD:int = 1000;
      
      private var _disposed:Boolean;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var UnknownVarFromMintInventoryListTab_IItemGridWindow_1:IItemGridWindow;
      
      private var UnknownVarFromMintInventoryListTab_CollectiblesView_1:CollectiblesView;
      
      private var UnknownVarFromMintInventoryListTab_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromMintInventoryListTab_CollectiblesController_1:CollectiblesController;
      
      private var UnknownVarFromMintInventoryListTab_IWindowController_1_2:IWindowController_1;
      
      private var UnknownVarFromMintInventoryListTab_Boolean_1:Boolean;
      
      private var UnknownVarFromMintInventoryListTab_Boolean_2:Boolean;
      
      private var UnknownVarFromMintInventoryListTab_Boolean_3:Boolean;
      
      private var UnknownVarFromMintInventoryListTab_Boolean_4:Boolean;
      
      private var UnknownVarFromMintInventoryListTab_Boolean_5:Boolean;
      
      private var UnknownVarFromMintInventoryListTab_Boolean_6:Boolean;
      
      private var UnknownVarFromMintInventoryListTab_Int_1:int;
      
      private var _productItems:Vector.<CollectiblesProductItem>;
      
      private var UnknownVarFromMintInventoryListTab_Boolean_7:Boolean;
      
      private var _tokenOffers:Vector.<MintTokenOffer>;
      
      private var UnknownVarFromMintInventoryListTab_Boolean_8:Boolean;
      
      private var UnknownVarFromMintInventoryListTab_MintInventoryItemRenderer_1:MintInventoryItemRenderer;
      
      private var UnknownVarFromMintInventoryListTab_CollectibleProductPreviewer_1:CollectibleProductPreviewer;
      
      private var UnknownVarFromMintInventoryListTab_IStaticBitmapWrapperWindow_1:IStaticBitmapWrapperWindow;
      
      private var _loadingIcon:IStaticBitmapWrapperWindow;
      
      private var UnknownVarFromMintInventoryListTab_Number_1:Number;
      
      private var _items:Vector.<MintInventoryItemRenderer>;
      
      private var UnknownVarFromMintInventoryListTab_Boolean_9:Boolean;
      
      public function MintInventoryListTab(param1:CollectiblesView, param2:CollectiblesController)
      {
         super();
         UnknownVarFromMintInventoryListTab_CollectiblesView_1 = param1;
         UnknownVarFromMintInventoryListTab_CollectiblesController_1 = param2;
         _items = new Vector.<MintInventoryItemRenderer>(0);
         UnknownVarFromMintInventoryListTab_IWindowController_1_1 = UnknownVarFromMintInventoryListTab_CollectiblesView_1.window.findChildByName("mintingContainer") as IWindowController_1;
         UnknownVarFromMintInventoryListTab_IItemGridWindow_1 = UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("itemgrid_inventory") as IItemGridWindow;
         UnknownVarFromMintInventoryListTab_IWindowController_1_2 = UnknownVarFromMintInventoryListTab_IItemGridWindow_1.getGridItemAt(0) as IWindowController_1;
         UnknownVarFromMintInventoryListTab_IItemGridWindow_1.removeGridItem(UnknownVarFromMintInventoryListTab_IWindowController_1_2);
         UnknownVarFromMintInventoryListTab_IStaticBitmapWrapperWindow_1 = IStaticBitmapWrapperWindow(UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("bg_star"));
         _loadingIcon = IStaticBitmapWrapperWindow(UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("loading_icon"));
         UnknownVarFromMintInventoryListTab_CollectibleProductPreviewer_1 = new CollectibleProductPreviewer(productPreviewBitmap,null,null,null,avatarImageWidget,placeholderImage);
         UnknownVarFromMintInventoryListTab_CollectibleProductPreviewer_1.setPlaceholder();
         addMessageEvents();
         initializeData();
         updateReadyState(false);
         param2.registerUpdateReceiver(this,1);
         createWalletButton.addEventListener("WME_CLICK",onClickCreateWallet);
         moreInfoButton.addEventListener("WME_CLICK",onClickMoreInfo);
         stampsPurchaseDropdown.addEventListener("WE_SELECTED",onSelectTokenOffer);
         stampBuyButton.addEventListener("WME_CLICK",onBuyStampsClicked);
         collectButton.addEventListener("WME_CLICK",onCollectClicked);
      }
      
      private function addMessageEvents() : void
      {
         if(!UnknownVarFromMintInventoryListTab_CollectiblesController_1)
         {
            return;
         }
         _messageEvents = new Vector.<IMessageEvent>(0);
         _messageEvents.push(new CollectibleMintTokenCountMessageEvent(onCollectibleMintTokensMessage));
         _messageEvents.push(new CollectibleMintingEnabledMessageEvent(onCollectibleMintingEnabledMessage));
         _messageEvents.push(new CollectableMintableItemTypesMessageEvent(onCollectableMintableItemTypesMessage));
         _messageEvents.push(new CollectibleMintTokenOffersMessageEvent(onMintTokenOffersMessage));
         _messageEvents.push(new CollectibleMintableItemResultMessageEvent(onMintItemResult));
         for each(var _loc1_ in _messageEvents)
         {
            UnknownVarFromMintInventoryListTab_CollectiblesController_1.addMessageEvent(_loc1_);
         }
      }
      
      private function updateReadyState(param1:Boolean) : void
      {
         var _loc2_:Boolean = !UnknownVarFromMintInventoryListTab_Boolean_4 && !UnknownVarFromMintInventoryListTab_Boolean_5 && !UnknownVarFromMintInventoryListTab_Boolean_2 && !UnknownVarFromMintInventoryListTab_Boolean_3 && !UnknownVarFromMintInventoryListTab_Boolean_1;
         if(_loc2_)
         {
            if(!UnknownVarFromMintInventoryListTab_Boolean_6 && !UnknownVarFromMintInventoryListTab_Boolean_9)
            {
               populateItems(_productItems);
            }
            else if(param1)
            {
               reloadPreview();
            }
         }
         UnknownVarFromMintInventoryListTab_Boolean_6 = _loc2_;
         loadedContainer.visible = UnknownVarFromMintInventoryListTab_Boolean_6;
         loadingContainer.visible = !UnknownVarFromMintInventoryListTab_Boolean_6;
      }
      
      private function onCollectibleMintTokensMessage(param1:CollectibleMintTokenCountMessageEvent) : void
      {
         UnknownVarFromMintInventoryListTab_Boolean_1 = false;
         UnknownVarFromMintInventoryListTab_Int_1 = param1.getParser().totalTokens;
         mintTokenBalanceText.caption = String(UnknownVarFromMintInventoryListTab_Int_1);
         updateReadyState(true);
      }
      
      private function onCollectibleMintingEnabledMessage(param1:CollectibleMintingEnabledMessageEvent) : void
      {
         UnknownVarFromMintInventoryListTab_Boolean_3 = false;
         UnknownVarFromMintInventoryListTab_Boolean_7 = param1.getParser().enabled;
         updateReadyState(true);
      }
      
      public function set activeWallet(param1:String) : void
      {
         UnknownVarFromMintInventoryListTab_Boolean_4 = false;
         if(param1 != null)
         {
            UnknownVarFromMintInventoryListTab_Boolean_1 = true;
            UnknownVarFromMintInventoryListTab_CollectiblesController_1.send(new GetCollectibleMintTokensMessageComposer(param1));
         }
         updateReadyState(true);
         stampPurchasingContainer.visible = param1 != null;
         noWalletContainer.visible = param1 == null;
      }
      
      private function onCollectableMintableItemTypesMessage(param1:CollectableMintableItemTypesMessageEvent) : void
      {
         UnknownVarFromMintInventoryListTab_Boolean_2 = false;
         _productItems = param1.getParser().collectibleProductItems;
         updateReadyState(true);
      }
      
      private function onMintTokenOffersMessage(param1:CollectibleMintTokenOffersMessageEvent) : void
      {
         _tokenOffers = param1.getParser().tokenOffers;
         var _loc3_:Vector.<String> = new Vector.<String>();
         for each(var _loc2_ in _tokenOffers)
         {
            _loc3_.push(_loc2_.amountTokens);
         }
         stampsPurchaseDropdown.populateWithVector(_loc3_);
         if(_loc3_.length > 0)
         {
            stampsPurchaseDropdown.selection = 0;
            onSelectTokenOffer(null);
         }
      }
      
      private function onSelectTokenOffer(param1:WindowEvent) : void
      {
         var _loc2_:MintTokenOffer = selectedTokenOffer;
         silverCost.caption = String(_loc2_.silverPrice);
         if(_loc2_.silverPrice <= UnknownVarFromMintInventoryListTab_CollectiblesController_1.catalog.getPurse().silverBalance)
         {
            stampBuyButton.enable();
         }
         else
         {
            stampBuyButton.disable();
         }
      }
      
      private function get selectedTokenOffer() : MintTokenOffer
      {
         var _loc1_:int = stampsPurchaseDropdown.selection;
         if(_loc1_ < 0 || _loc1_ >= _tokenOffers.length)
         {
            return null;
         }
         return _tokenOffers[_loc1_];
      }
      
      private function onBuyStampsClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:MintTokenOffer = selectedTokenOffer;
         var _loc3_:String = UnknownVarFromMintInventoryListTab_CollectiblesView_1.activeWallet;
         if(_loc2_ == null || _loc3_ == null)
         {
            return;
         }
         var _loc4_:MintTokenPurchaseOffer = new MintTokenPurchaseOffer(_loc2_);
         HabboCatalog(UnknownVarFromMintInventoryListTab_CollectiblesController_1.catalog).showPurchaseConfirmation(_loc4_,-1,_loc3_);
      }
      
      public function onInventoryInitialize(param1:String) : void
      {
         if(param1 != "furni")
         {
            return;
         }
         UnknownVarFromMintInventoryListTab_Boolean_5 = false;
         updateReadyState(true);
      }
      
      public function amountChangedForItem(param1:String, param2:int, param3:Boolean) : void
      {
         var _loc5_:CollectiblesProductItem = null;
         var _loc6_:Boolean = false;
         var _loc7_:Array = null;
         if(param1 != "furni")
         {
            return;
         }
         if(UnknownVarFromMintInventoryListTab_Boolean_6 && _items != null && _items.length > 0)
         {
            for each(var _loc4_ in _items)
            {
               _loc5_ = _loc4_.item;
               _loc6_ = _loc5_.itemType == "i" && param3 || _loc5_.itemType == "s" && !param3;
               if(_loc6_ && _loc5_.itemTypeId == param2)
               {
                  _loc7_ = getIdsInInventory(_loc5_);
                  (_loc4_.renderableItem as MintableItemWrapper).amount = _loc7_.length;
                  _loc4_.updateVisuals();
                  if(_loc4_ == UnknownVarFromMintInventoryListTab_MintInventoryItemRenderer_1)
                  {
                     reloadPreview();
                  }
                  return;
               }
            }
         }
      }
      
      private function initializeData() : void
      {
         UnknownVarFromMintInventoryListTab_Boolean_2 = true;
         UnknownVarFromMintInventoryListTab_CollectiblesController_1.send(new GetCollectibleMintableItemTypesMessageComposer());
         UnknownVarFromMintInventoryListTab_Boolean_3 = true;
         UnknownVarFromMintInventoryListTab_CollectiblesController_1.send(new GetCollectibleMintingEnabledMessageComposer());
         if(!UnknownVarFromMintInventoryListTab_CollectiblesController_1.inventory.checkCategoryInitilization("furni"))
         {
            UnknownVarFromMintInventoryListTab_Boolean_5 = true;
         }
         UnknownVarFromMintInventoryListTab_Boolean_4 = true;
         if(UnknownVarFromMintInventoryListTab_CollectiblesView_1.walletsLoaded())
         {
            activeWallet = UnknownVarFromMintInventoryListTab_CollectiblesView_1.activeWallet;
         }
         stampBuyButton.disable();
         UnknownVarFromMintInventoryListTab_CollectiblesController_1.send(new GetMintTokenOffersMessageComposer());
      }
      
      public function populateItems(param1:Vector.<CollectiblesProductItem>) : void
      {
         var _loc4_:IWindowController_1 = null;
         var _loc3_:MintInventoryItemRenderer = null;
         for each(var _loc2_ in param1)
         {
            _loc4_ = UnknownVarFromMintInventoryListTab_IWindowController_1_2.clone() as IWindowController_1;
            _loc3_ = new MintInventoryItemRenderer(UnknownVarFromMintInventoryListTab_CollectiblesController_1,_loc2_,_loc4_,this,getIdsInInventory(_loc2_).length);
            UnknownVarFromMintInventoryListTab_IItemGridWindow_1.addGridItem(_loc4_);
            _items.push(_loc3_);
         }
         UnknownVarFromMintInventoryListTab_Boolean_9 = true;
         if(_items.length > 0)
         {
            UnknownVarFromMintInventoryListTab_MintInventoryItemRenderer_1 = _items[0];
            UnknownVarFromMintInventoryListTab_MintInventoryItemRenderer_1.activate();
            initMintItemPreview();
         }
         previewWindow.visible = _items.length > 0;
      }
      
      private function getIdsInInventory(param1:CollectiblesProductItem) : Array
      {
         var _loc4_:String = param1.itemType;
         var _loc2_:Boolean = false;
         if(_loc4_ == "i")
         {
            _loc2_ = true;
         }
         else if(_loc4_ != "s")
         {
            return [];
         }
         var _loc5_:IHabboInventory = UnknownVarFromMintInventoryListTab_CollectiblesController_1.inventory;
         var _loc3_:Array = _loc5_.getNonRentedInventoryIds("furni",param1.itemTypeId,_loc2_);
         return _loc3_ == null ? [] : _loc3_;
      }
      
      public function selectItem(param1:MintInventoryItemRenderer) : void
      {
         if(UnknownVarFromMintInventoryListTab_MintInventoryItemRenderer_1 != null)
         {
            UnknownVarFromMintInventoryListTab_MintInventoryItemRenderer_1.deactivate();
            UnknownVarFromMintInventoryListTab_MintInventoryItemRenderer_1 = null;
         }
         if(param1 != null)
         {
            UnknownVarFromMintInventoryListTab_MintInventoryItemRenderer_1 = param1;
            UnknownVarFromMintInventoryListTab_MintInventoryItemRenderer_1.activate();
            initMintItemPreview();
         }
         else
         {
            UnknownVarFromMintInventoryListTab_MintInventoryItemRenderer_1 = null;
         }
      }
      
      private function reloadPreview() : void
      {
         initMintItemPreview();
      }
      
      private function initMintItemPreview() : void
      {
         if(UnknownVarFromMintInventoryListTab_MintInventoryItemRenderer_1 == null)
         {
            return;
         }
         var _loc3_:MintInventoryItemRenderer = UnknownVarFromMintInventoryListTab_MintInventoryItemRenderer_1;
         UnknownVarFromMintInventoryListTab_CollectibleProductPreviewer_1.clearPreviewer();
         UnknownVarFromMintInventoryListTab_CollectiblesController_1.previewImage(_loc3_.renderableItem,UnknownVarFromMintInventoryListTab_CollectibleProductPreviewer_1);
         productNameText.caption = UnknownVarFromMintInventoryListTab_CollectiblesController_1.getProductName(_loc3_.renderableItem);
         var _loc5_:IRenderableCollectibleItem = _loc3_.renderableItem;
         var _loc1_:CollectiblesProductItem = _loc3_.item;
         var _loc2_:* = UnknownVarFromMintInventoryListTab_CollectiblesView_1.activeWallet == null;
         var _loc4_:* = _loc5_.amount == 0;
         var _loc6_:* = UnknownVarFromMintInventoryListTab_Int_1 < _loc1_.price;
         var _loc7_:Boolean = isMintPeriodExpired();
         stampPricingText.caption = String(_loc1_.price);
         noFurniNotification.visible = _loc4_;
         if(_loc1_.regionLocked)
         {
            mintLockedText.caption = localization.getLocalization("shop.minting.region_locked");
            mintLockClosedImage.visible = true;
            mintLockOpenImage.visible = false;
         }
         else
         {
            mintLockedText.caption = localization.getLocalization("shop.minting.region_unlocked");
            mintLockClosedImage.visible = false;
            mintLockOpenImage.visible = true;
         }
         updateProgressBar(true);
         if(_loc2_ || _loc4_ || _loc6_ || _loc7_ || !UnknownVarFromMintInventoryListTab_Boolean_7 || UnknownVarFromMintInventoryListTab_Boolean_8)
         {
            collectButton.disable();
         }
         else
         {
            collectButton.enable();
         }
      }
      
      private function onCollectClicked(param1:WindowMouseEvent) : void
      {
         collectButton.disable();
         var _loc2_:UnknownICoreWindowUtils2 = UnknownVarFromMintInventoryListTab_CollectiblesController_1.windowManager.confirm("${shop.minting.confirm.title}","${shop.minting.confirm.description}",0,onCollectConfirmDialogConfirm);
         _loc2_.titleBarColor = 2763306;
      }
      
      private function onCollectConfirmDialogConfirm(param1:UnknownICoreWindowUtils2, param2:WindowEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            _loc3_ = UnknownVarFromMintInventoryListTab_CollectiblesView_1.activeWallet;
            if(UnknownVarFromMintInventoryListTab_MintInventoryItemRenderer_1 == null || _loc3_ == null)
            {
               return;
            }
            _loc4_ = getIdsInInventory(UnknownVarFromMintInventoryListTab_MintInventoryItemRenderer_1.item);
            if(_loc4_.length == 0)
            {
               return;
            }
            UnknownVarFromMintInventoryListTab_Boolean_8 = true;
            UnknownVarFromMintInventoryListTab_CollectiblesController_1.send(new MintItemMessageComposer(_loc4_[0],_loc3_));
         }
         reloadPreview();
      }
      
      private function onMintItemResult(param1:CollectibleMintableItemResultMessageEvent) : void
      {
         var _loc2_:* = param1.getParser().mintResult == CollectibleMintableItemResultMessageEventParser.UnknownVarFromNftStorePurchaseMessageEventParser_Int_1;
         UnknownVarFromMintInventoryListTab_CollectiblesController_1.catalog.events.dispatchEvent(new CatalogEvent(_loc2_ ? "COLLECTIBLES_MINT_SUCCESS" : "COLLECTIBLES_MINT_FAIL"));
         UnknownVarFromMintInventoryListTab_Boolean_8 = false;
         reloadPreview();
      }
      
      public function updateProgressBar(param1:Boolean = true, param2:uint = 0) : void
      {
         var _loc6_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc4_:* = false;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:String = null;
         UnknownVarFromMintInventoryListTab_Number_1 += param2;
         var _loc9_:Boolean = param1 || UnknownVarFromMintInventoryListTab_Number_1 >= PROGRESS_BAR_UPDATE_THRESHOLD;
         if(!_loc9_ || !UnknownVarFromMintInventoryListTab_MintInventoryItemRenderer_1)
         {
            return;
         }
         UnknownVarFromMintInventoryListTab_Number_1 = 0;
         var _loc5_:Number = UnknownVarFromMintInventoryListTab_MintInventoryItemRenderer_1.item.startTime * 1000;
         var _loc8_:Number = UnknownVarFromMintInventoryListTab_MintInventoryItemRenderer_1.item.endTime * 1000;
         if(_loc5_ > 0 && _loc8_ > 0)
         {
            _loc6_ = new Date().time;
            _loc10_ = Math.max(0,_loc8_ - _loc6_);
            _loc3_ = _loc8_ - _loc5_;
            _loc7_ = Math.min(1,_loc10_ / _loc3_);
            _loc4_ = _loc7_ <= 0;
            _loc7_ = Math.max(0,_loc7_);
            _loc11_ = int(completionProgressBarPadded.width);
            _loc12_ = _loc11_ * _loc7_;
            completionProgressBarTop.width = _loc12_;
            completionProgressBarBottom.width = _loc12_;
            if(!_loc4_)
            {
               _loc13_ = FriendlyTime.getFriendlyTime(localization,_loc10_ / 1000);
               completionProgressBarText.caption = localization.getLocalizationWithParams("shop.minting.time_left") + ": " + _loc13_;
            }
            else
            {
               completionProgressBarText.caption = localization.getLocalizationWithParams("shop.minting.time_ended");
               collectButton.disable();
            }
         }
      }
      
      private function isMintPeriodExpired() : Boolean
      {
         if(UnknownVarFromMintInventoryListTab_MintInventoryItemRenderer_1 == null)
         {
            return true;
         }
         return UnknownVarFromMintInventoryListTab_MintInventoryItemRenderer_1.item.endTime * 1000 < new Date().time;
      }
      
      private function get localization() : IHabboLocalizationManager
      {
         return UnknownVarFromMintInventoryListTab_CollectiblesController_1.localizationManager;
      }
      
      private function onClickCreateWallet(param1:WindowMouseEvent) : void
      {
         HabboWebTools.openWebPageAndMinimizeClient(UnknownVarFromMintInventoryListTab_CollectiblesController_1.getProperty("nft.wallet.create.url"));
      }
      
      private function onClickMoreInfo(param1:WindowMouseEvent) : void
      {
         HabboWebTools.openWebPageAndMinimizeClient(UnknownVarFromMintInventoryListTab_CollectiblesController_1.getProperty("web.settings.wallet.relativeUrl"));
      }
      
      private function removeMessageEvents() : void
      {
         if(!UnknownVarFromMintInventoryListTab_CollectiblesController_1 || !_messageEvents)
         {
            return;
         }
         for each(var _loc1_ in _messageEvents)
         {
            UnknownVarFromMintInventoryListTab_CollectiblesController_1.removeMessageEvent(_loc1_);
            _loc1_.dispose();
         }
         _messageEvents = null;
      }
      
      public function clearItems() : void
      {
         if(_items)
         {
            for each(var _loc1_ in _items)
            {
               _loc1_.dispose();
            }
            _items.length = 0;
         }
         if(UnknownVarFromMintInventoryListTab_IItemGridWindow_1)
         {
            UnknownVarFromMintInventoryListTab_IItemGridWindow_1.destroyGridItems();
         }
         UnknownVarFromMintInventoryListTab_Boolean_9 = false;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         clearItems();
         removeMessageEvents();
         UnknownVarFromMintInventoryListTab_CollectiblesController_1.removeUpdateReceiver(this);
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:Number = NaN;
         _loc2_ = NaN;
         if(UnknownVarFromMintInventoryListTab_Boolean_6)
         {
            _loc2_ = CollectionsTab.BG_STAR_ROTATE_SPEED * (param1 / 1000);
            UnknownVarFromMintInventoryListTab_IStaticBitmapWrapperWindow_1.rotation += _loc2_;
            UnknownVarFromMintInventoryListTab_IStaticBitmapWrapperWindow_1.rotation %= 360;
            UnknownVarFromMintInventoryListTab_IStaticBitmapWrapperWindow_1.invalidate();
            updateProgressBar(false,param1);
         }
         else
         {
            _loc2_ = CollectionsTab.UnknownVarFromShopTab_Number_1 * (param1 / 1000);
            _loadingIcon.rotation += _loc2_;
            _loadingIcon.rotation %= 360;
            _loadingIcon.invalidate();
         }
      }
      
      private function get loadingContainer() : IWindowController_1
      {
         return UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("loading_contents") as IWindowController_1;
      }
      
      private function get loadedContainer() : IWindowController_1
      {
         return UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("loaded_content") as IWindowController_1;
      }
      
      private function get previewWindow() : IWindowController_1
      {
         return UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("preview_container") as IWindowController_1;
      }
      
      private function get productPreviewBitmap() : IBitmapWrapperController
      {
         return UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("product_preview") as IBitmapWrapperController;
      }
      
      private function get avatarImageWidget() : IWidgetWindowController
      {
         return UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("avatar_image_widget") as IWidgetWindowController;
      }
      
      private function get productNameText() : ITextWindow
      {
         return UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("preview_furni_name") as ITextWindow;
      }
      
      private function get placeholderImage() : IStaticBitmapWrapperWindow
      {
         return UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("placeholder_image") as IStaticBitmapWrapperWindow;
      }
      
      private function get stampPricingText() : ITextWindow
      {
         return UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("stamp_pricing") as ITextWindow;
      }
      
      private function get collectButton() : UnknownICoreWindowComponents4
      {
         return UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("collect_button") as UnknownICoreWindowComponents4;
      }
      
      private function get noFurniNotification() : UnknownICoreWindowComponents6
      {
         return UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("no_furni_notify") as UnknownICoreWindowComponents6;
      }
      
      private function get mintLockedText() : IHTMLTextController
      {
         return UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("mint_lock_text") as IHTMLTextController;
      }
      
      private function get mintLockOpenImage() : IStaticBitmapWrapperWindow
      {
         return UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("mint_lock_open_icon") as IStaticBitmapWrapperWindow;
      }
      
      private function get mintLockClosedImage() : IStaticBitmapWrapperWindow
      {
         return UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("mint_lock_closed_icon") as IStaticBitmapWrapperWindow;
      }
      
      private function get completionProgressBar() : IWindowController_1
      {
         return UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("progress_bar") as IWindowController_1;
      }
      
      private function get completionProgressBarPadded() : IWindowController_1
      {
         return UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("progress_padded_bar") as IWindowController_1;
      }
      
      private function get completionProgressBarTop() : IWindowController_1
      {
         return UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("progress_bar_top") as IWindowController_1;
      }
      
      private function get completionProgressBarBottom() : IWindowController_1
      {
         return UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("progress_bar_bottom") as IWindowController_1;
      }
      
      private function get completionProgressBarText() : ITextWindow
      {
         return UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("progress_bar_text") as ITextWindow;
      }
      
      private function get stampPurchasingContainer() : IWindowController_1
      {
         return UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("stamp_purchasing_container") as IWindowController_1;
      }
      
      private function get noWalletContainer() : IWindowController_1
      {
         return UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("no_wallet_container") as IWindowController_1;
      }
      
      private function get createWalletButton() : UnknownICoreWindowComponents4
      {
         return UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("create_wallet_button") as UnknownICoreWindowComponents4;
      }
      
      private function get moreInfoButton() : UnknownICoreWindowComponents4
      {
         return UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("more_info_button") as UnknownICoreWindowComponents4;
      }
      
      private function get mintTokenBalanceText() : ITextWindow
      {
         return UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("mint_token_balance") as ITextWindow;
      }
      
      private function get silverCost() : ITextWindow
      {
         return UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("silver_cost_text") as ITextWindow;
      }
      
      private function get stampBuyButton() : UnknownICoreWindowComponents4
      {
         return UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("silver_buy_button") as UnknownICoreWindowComponents4;
      }
      
      private function get stampsPurchaseDropdown() : IDropBaseController_1
      {
         return UnknownVarFromMintInventoryListTab_IWindowController_1_1.findChildByName("stamps_purchase_dropdown") as IDropBaseController_1;
      }
   }
}

