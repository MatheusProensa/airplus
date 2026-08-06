package com.sulake.habbo.catalog.collectibles.tabs
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.collectibles.CollectiblesController;
   import com.sulake.habbo.catalog.collectibles.CollectiblesView;
   import com.sulake.habbo.catalog.collectibles.renderer.collections.CollectionsNavigationNodeRenderer;
   import com.sulake.habbo.catalog.collectibles.tabs.subviews.CollectionView;
   import com.sulake.habbo.catalog.event.CatalogEvent;
   import com.sulake.habbo.communication.messages.incoming.collectibles.NftBonusItemClaimResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.collectibles.NftCollectionsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.collectibles.NftRewardItemClaimResultMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.GetNftCollectionsMessageComposer;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftBonusItemClaimResultMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftCollection;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftRewardItemClaimResultMessageEventParser;
   
   public class CollectionsTab implements IProfiler_1
   {
      public static var BG_STAR_ROTATE_SPEED:Number = 20;
      
      public static var UnknownVarFromShopTab_Number_1:Number = 90;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromCollectionsTab_CollectiblesView_1:CollectiblesView;
      
      private var _controller:CollectiblesController;
      
      private var UnknownVarFromCollectionsTab_IWindowController_1_1:IWindowController_1;
      
      private var _navigationList:IItemListWindow;
      
      private var _renderableItems:Vector.<CollectionsNavigationNodeRenderer>;
      
      private var _navigationItemTemplate:IWindowModel;
      
      private var UnknownVarFromCollectionsTab_Boolean_1:Boolean;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var UnknownVarFromCollectionsTab_CollectionsNavigationNodeRenderer_1:CollectionsNavigationNodeRenderer;
      
      private var UnknownVarFromCollectionsTab_CollectionView_1:CollectionView;
      
      private var UnknownVarFromCollectionsTab_IStaticBitmapWrapperWindow_1:IStaticBitmapWrapperWindow;
      
      private var _loadingIcon:IStaticBitmapWrapperWindow;
      
      private var UnknownVarFromCollectionsTab_Boolean_2:Boolean;
      
      private var _gridItemTemplate:IWindowController_1;
      
      private var _productInfoEntryTemplate:IWindowController_1;
      
      private var _ignoreWalletSelectionEvents:Boolean;
      
      private var UnknownVarFromCollectionsTab_Array_1:Array = [];
      
      public function CollectionsTab(param1:CollectiblesView, param2:CollectiblesController)
      {
         super();
         UnknownVarFromCollectionsTab_CollectiblesView_1 = param1;
         _controller = param2;
         UnknownVarFromCollectionsTab_IWindowController_1_1 = IWindowController_1(UnknownVarFromCollectionsTab_CollectiblesView_1.window.findChildByName("collectionsContainer"));
         _navigationList = IItemListWindow(UnknownVarFromCollectionsTab_IWindowController_1_1.findChildByName("navigationList"));
         _navigationItemTemplate = _navigationList.removeListItem(_navigationList.getListItemByName("item_template"));
         _renderableItems = new Vector.<CollectionsNavigationNodeRenderer>();
         var _loc3_:IItemGridWindow = UnknownVarFromCollectionsTab_IWindowController_1_1.findChildByName("itemgrid_collection") as IItemGridWindow;
         _gridItemTemplate = _loc3_.getGridItemAt(0) as IWindowController_1;
         _loc3_.removeGridItems();
         var _loc4_:IItemListWindow = UnknownVarFromCollectionsTab_IWindowController_1_1.findChildByName("product_info_list") as IItemListWindow;
         _productInfoEntryTemplate = _loc4_.getListItemAt(0) as IWindowController_1;
         _loc4_.removeListItems();
         setReady(false);
         addMessageEvents();
         if(UnknownVarFromCollectionsTab_CollectiblesView_1.walletAddresses)
         {
            initializeWallets(UnknownVarFromCollectionsTab_CollectiblesView_1.walletAddresses);
         }
         walletSelection.addEventListener("WE_SELECTED",onWalletSelectAction);
         populateSortOptions();
         sortSelection.addEventListener("WE_SELECTED",onSortSelectAction);
         searchInput.addEventListener("WE_CHANGE",onFilterChangeAction);
         clearSearchButton.addEventListener("WME_CLICK",onClearSearchAction);
         UnknownVarFromCollectionsTab_IStaticBitmapWrapperWindow_1 = IStaticBitmapWrapperWindow(UnknownVarFromCollectionsTab_IWindowController_1_1.findChildByName("bg_star"));
         _loadingIcon = IStaticBitmapWrapperWindow(UnknownVarFromCollectionsTab_IWindowController_1_1.findChildByName("loading_icon"));
         controller.registerUpdateReceiver(this,1);
      }
      
      private static function sortCollectionsByBonus(param1:Array) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc5_:Array = [];
         for each(var _loc4_ in param1)
         {
            if(_loc4_.canClaimBonus)
            {
               _loc2_.push(_loc4_);
            }
            else if(_loc4_.hasBonusItem && !_loc4_.isBonusSnapshotPassed())
            {
               _loc3_.push(_loc4_);
            }
            else
            {
               _loc5_.push(_loc4_);
            }
         }
         return _loc2_.concat(_loc3_,_loc5_);
      }
      
      private function addMessageEvents() : void
      {
         _messageEvents = new Vector.<IMessageEvent>(0);
         _messageEvents.push(new NftCollectionsMessageEvent(onNftCollectionsMessage));
         _messageEvents.push(new NftBonusItemClaimResultMessageEvent(onBonusClaimResult));
         _messageEvents.push(new NftRewardItemClaimResultMessageEvent(onRewardClaimResult));
         for each(var _loc1_ in _messageEvents)
         {
            _controller.addMessageEvent(_loc1_);
         }
      }
      
      public function onWalletsAddressesUpdated(param1:Array) : void
      {
         initializeWallets(param1);
      }
      
      private function initializeWallets(param1:Array) : void
      {
         if(param1.length == 0)
         {
            walletSelection.color = 13421772;
            walletSelection.disable();
            return;
         }
         walletSelection.color = 16777215;
         walletSelection.enable();
         var _loc3_:Array = [];
         for each(var _loc2_ in param1)
         {
            _loc3_.push(_loc2_ == UnknownVarFromCollectionsTab_CollectiblesView_1.stardustWallet ? "Collector Wallet" : _loc2_);
         }
         walletSelection.populate(_loc3_);
      }
      
      private function populateSortOptions() : void
      {
         var _loc1_:Array = [];
         _loc1_.push(controller.localizationManager.getLocalization("collectibles.sort.default","Default"));
         _loc1_.push(controller.localizationManager.getLocalization("collectibles.sort.progress","Progress"));
         _loc1_.push(controller.localizationManager.getLocalization("collectibles.sort.score","Score"));
         sortSelection.populate(_loc1_);
      }
      
      private function onSortSelectAction(param1:WindowEvent) : void
      {
         var _loc2_:CollectionsNavigationNodeRenderer = null;
         clearNavigationList();
         var _loc3_:Array = [];
         if(sortSelection.selection == 1)
         {
            _loc3_ = sortCollectionsByProgress(UnknownVarFromCollectionsTab_Array_1);
         }
         else if(sortSelection.selection == 2)
         {
            _loc3_ = sortCollectionsByScore(UnknownVarFromCollectionsTab_Array_1);
         }
         else
         {
            _loc3_ = sortCollectionsByBonus(UnknownVarFromCollectionsTab_Array_1);
         }
         for each(var _loc4_ in _loc3_)
         {
            _loc2_ = new CollectionsNavigationNodeRenderer(this,_loc4_);
            _navigationList.addListItem(_loc2_.window);
            _renderableItems.push(_loc2_);
         }
         filterSearchResults();
      }
      
      private function onFilterChangeAction(param1:WindowEvent) : void
      {
         filterSearchResults();
      }
      
      private function filterSearchResults() : void
      {
         var _loc2_:String = null;
         _navigationList.autoArrangeItems = false;
         for each(var _loc1_ in _renderableItems)
         {
            if(searchInput.text.length > 0)
            {
               _loc2_ = _loc1_.nftCollection.collectionName.toLowerCase();
               if(_loc2_.indexOf(searchInput.text) == -1)
               {
                  _loc1_.window.visible = false;
               }
               else
               {
                  _loc1_.window.visible = true;
               }
            }
            else
            {
               _loc1_.window.visible = true;
            }
         }
         _navigationList.autoArrangeItems = true;
         var _loc3_:* = searchInput.text.length > 0;
         setSearchState(_loc3_);
      }
      
      private function setSearchState(param1:Boolean) : void
      {
         searchIcon.visible = param1;
         searchPlaceholder.visible = !param1;
      }
      
      private function onClearSearchAction(param1:WindowMouseEvent) : void
      {
         searchInput.text = "";
         filterSearchResults();
      }
      
      private function onWalletSelectAction(param1:WindowEvent) : void
      {
         if(!_ignoreWalletSelectionEvents)
         {
            UnknownVarFromCollectionsTab_CollectiblesView_1.setActiveWalletIndex(walletSelection.selection);
         }
      }
      
      public function set activeWallet(param1:String) : void
      {
         var _loc3_:int = int(UnknownVarFromCollectionsTab_CollectiblesView_1.walletAddresses.indexOf(param1));
         if(_loc3_ == -1 && param1 != null)
         {
            Logger.log("selected an unavailable wallet");
            return;
         }
         _ignoreWalletSelectionEvents = true;
         walletSelection.selection = _loc3_;
         _ignoreWalletSelectionEvents = false;
         setReady(false);
         requestCollections(param1);
         var _loc2_:String = walletSelection.enumerateSelection()[_loc3_];
         if(_loc2_ && _loc2_.length > 19)
         {
            walletSelection.caption = _loc2_.substring(0,19) + "...";
         }
      }
      
      private function onNftCollectionsMessage(param1:NftCollectionsMessageEvent) : void
      {
         if(!UnknownVarFromCollectionsTab_Boolean_1 || _navigationList.numListItems != 0)
         {
            return;
         }
         UnknownVarFromCollectionsTab_Boolean_1 = false;
         var _loc2_:Array = param1.getParser().nftCollections;
         UnknownVarFromCollectionsTab_Array_1 = _loc2_;
         sortSelection.selection = 0;
         if(_renderableItems.length > 0)
         {
            activateCollection(_renderableItems[0]);
         }
         setReady(true);
         collectionContainer.visible = _renderableItems.length > 0;
      }
      
      private function sortCollectionsByScore(param1:Array) : Array
      {
         var _loc2_:Array = [];
         var _loc4_:Array = [];
         for each(var _loc3_ in param1)
         {
            if(_loc3_.collectionScore > 0)
            {
               _loc2_.push(_loc3_);
            }
            else
            {
               _loc4_.push(_loc3_);
            }
         }
         _loc2_.sort(compareByScore);
         return _loc2_.concat(_loc4_);
      }
      
      private function sortCollectionsByProgress(param1:Array) : Array
      {
         var _loc2_:Array = [];
         var _loc4_:Array = [];
         for each(var _loc3_ in param1)
         {
            if(_loc3_.progressPercentage > 0)
            {
               _loc2_.push(_loc3_);
            }
            else
            {
               _loc4_.push(_loc3_);
            }
         }
         _loc2_.sort(compareByProgress);
         return _loc2_.concat(_loc4_);
      }
      
      private function compareByProgress(param1:NftCollection, param2:NftCollection) : int
      {
         if(param1.progressPercentage >= param2.progressPercentage)
         {
            return -1;
         }
         if(param1.progressPercentage < param2.progressPercentage)
         {
            return 1;
         }
         return 0;
      }
      
      private function compareByScore(param1:NftCollection, param2:NftCollection) : int
      {
         if(param1.collectionScore >= param2.collectionScore)
         {
            return -1;
         }
         if(param1.collectionScore < param2.collectionScore)
         {
            return 1;
         }
         return 0;
      }
      
      private function sendClaimNotification(param1:Boolean) : void
      {
         controller.catalog.events.dispatchEvent(new CatalogEvent(param1 ? "COLLECTIBLE_CLAIM_SUCCESS" : "COLLECTIBLES_CLAIM_FAIL"));
      }
      
      public function sendClaimWaitNotification() : void
      {
         controller.catalog.events.dispatchEvent(new CatalogEvent("COLLECTIBLE_CLAIM_WAIT"));
      }
      
      private function onBonusClaimResult(param1:NftBonusItemClaimResultMessageEvent) : void
      {
         var _loc2_:NftBonusItemClaimResultMessageEventParser = param1.getParser();
         sendClaimNotification(_loc2_.success);
         if(UnknownVarFromCollectionsTab_CollectiblesView_1.activeWallet != _loc2_.walletAddress)
         {
            return;
         }
         var _loc3_:NftCollection = getCollectionById(_loc2_.collectionId);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.claimBonusFinished(_loc2_.success);
         if(UnknownVarFromCollectionsTab_CollectionView_1 != null && UnknownVarFromCollectionsTab_CollectionView_1.nftCollection.collectionId == _loc2_.collectionId)
         {
            UnknownVarFromCollectionsTab_CollectionView_1.claimingFinished(true,_loc2_.success);
         }
      }
      
      private function onRewardClaimResult(param1:NftRewardItemClaimResultMessageEvent) : void
      {
         var _loc2_:NftRewardItemClaimResultMessageEventParser = param1.getParser();
         sendClaimNotification(_loc2_.success);
         if(UnknownVarFromCollectionsTab_CollectiblesView_1.activeWallet != _loc2_.walletAddress)
         {
            return;
         }
         var _loc3_:NftCollection = getCollectionById(_loc2_.collectionId);
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.claimRewardFinished(_loc2_.success);
         if(UnknownVarFromCollectionsTab_CollectionView_1 != null && UnknownVarFromCollectionsTab_CollectionView_1.nftCollection.collectionId == _loc2_.collectionId)
         {
            UnknownVarFromCollectionsTab_CollectionView_1.claimingFinished(true,_loc2_.success);
         }
      }
      
      private function getCollectionById(param1:String) : NftCollection
      {
         var _loc3_:NftCollection = null;
         if(_renderableItems == null)
         {
            return null;
         }
         for each(var _loc2_ in _renderableItems)
         {
            _loc3_ = _loc2_.nftCollection;
            if(_loc3_.collectionId == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private function setReady(param1:Boolean) : void
      {
         loadedContainer.visible = param1;
         loadingContainer.visible = !param1;
         UnknownVarFromCollectionsTab_Boolean_2 = param1;
      }
      
      private function requestCollections(param1:String) : void
      {
         clearNavigationList();
         UnknownVarFromCollectionsTab_Boolean_1 = true;
         _controller.send(new GetNftCollectionsMessageComposer(param1 == null ? "" : param1));
      }
      
      public function get navigationItemTemplate() : IWindowModel
      {
         return _navigationItemTemplate;
      }
      
      public function activateCollection(param1:CollectionsNavigationNodeRenderer) : void
      {
         if(UnknownVarFromCollectionsTab_CollectionsNavigationNodeRenderer_1 == param1)
         {
            return;
         }
         if(UnknownVarFromCollectionsTab_CollectionsNavigationNodeRenderer_1 != null)
         {
            UnknownVarFromCollectionsTab_CollectionsNavigationNodeRenderer_1.deactivate();
         }
         if(UnknownVarFromCollectionsTab_CollectionView_1 != null)
         {
            UnknownVarFromCollectionsTab_CollectionView_1.dispose();
         }
         UnknownVarFromCollectionsTab_CollectionsNavigationNodeRenderer_1 = param1;
         UnknownVarFromCollectionsTab_CollectionView_1 = new CollectionView(this,collectionContainer,UnknownVarFromCollectionsTab_CollectionsNavigationNodeRenderer_1.nftCollection);
         UnknownVarFromCollectionsTab_CollectionsNavigationNodeRenderer_1.activate();
      }
      
      private function get collectionContainer() : IWindowController_1
      {
         return UnknownVarFromCollectionsTab_IWindowController_1_1.findChildByName("collection_content") as IWindowController_1;
      }
      
      private function get loadingContainer() : IWindowController_1
      {
         return UnknownVarFromCollectionsTab_IWindowController_1_1.findChildByName("loading_contents") as IWindowController_1;
      }
      
      private function get loadedContainer() : IWindowController_1
      {
         return UnknownVarFromCollectionsTab_IWindowController_1_1.findChildByName("loaded_content") as IWindowController_1;
      }
      
      private function clearNavigationList() : void
      {
         UnknownVarFromCollectionsTab_CollectionsNavigationNodeRenderer_1 = null;
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
         clearNavigationList();
         removeMessageEvents();
         if(UnknownVarFromCollectionsTab_CollectionsNavigationNodeRenderer_1 != null)
         {
            UnknownVarFromCollectionsTab_CollectionsNavigationNodeRenderer_1.dispose();
            UnknownVarFromCollectionsTab_CollectionsNavigationNodeRenderer_1 = null;
         }
      }
      
      public function get controller() : CollectiblesController
      {
         return _controller;
      }
      
      public function get activeWallet() : String
      {
         return UnknownVarFromCollectionsTab_CollectiblesView_1.activeWallet;
      }
      
      public function get gridItemTemplate() : IWindowController_1
      {
         return _gridItemTemplate;
      }
      
      public function get productInfoEntryTemplate() : IWindowController_1
      {
         return _productInfoEntryTemplate;
      }
      
      private function get walletSelection() : IDropBaseController_1
      {
         return UnknownVarFromCollectionsTab_IWindowController_1_1.findChildByName("wallet_selection") as IDropBaseController_1;
      }
      
      private function get sortSelection() : IDropBaseController_1
      {
         return UnknownVarFromCollectionsTab_IWindowController_1_1.findChildByName("sort_selection") as IDropBaseController_1;
      }
      
      private function get searchInput() : ITextFieldWindow
      {
         return UnknownVarFromCollectionsTab_IWindowController_1_1.findChildByName("search_input") as ITextFieldWindow;
      }
      
      private function get searchPlaceholder() : IWindowModel
      {
         return UnknownVarFromCollectionsTab_IWindowController_1_1.findChildByName("search_placeholder") as IWindowModel;
      }
      
      private function get searchIcon() : IStaticBitmapWrapperWindow
      {
         return UnknownVarFromCollectionsTab_IWindowController_1_1.findChildByName("search_icon") as IStaticBitmapWrapperWindow;
      }
      
      private function get clearSearchButton() : UnknownICoreWindowComponents4
      {
         return UnknownVarFromCollectionsTab_IWindowController_1_1.findChildByName("search_clear_button") as UnknownICoreWindowComponents4;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:Number = NaN;
         _loc2_ = NaN;
         if(UnknownVarFromCollectionsTab_Boolean_2)
         {
            _loc2_ = BG_STAR_ROTATE_SPEED * (param1 / 1000);
            UnknownVarFromCollectionsTab_IStaticBitmapWrapperWindow_1.rotation += _loc2_;
            UnknownVarFromCollectionsTab_IStaticBitmapWrapperWindow_1.rotation %= 360;
            UnknownVarFromCollectionsTab_IStaticBitmapWrapperWindow_1.invalidate();
            if(UnknownVarFromCollectionsTab_CollectionView_1 != null)
            {
               UnknownVarFromCollectionsTab_CollectionView_1.updateBonusProgressBar(false,param1);
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

