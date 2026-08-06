package com.sulake.habbo.catalog.collectibles.tabs.subviews
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.collectibles.IRenderableCollectibleItem;
   import com.sulake.habbo.catalog.collectibles.renderer.collections.CollectibleItemRenderer;
   import com.sulake.habbo.catalog.collectibles.renderer.collections.CollectionProgressColorUtil;
   import com.sulake.habbo.catalog.collectibles.renderer.model.CollectionItemWrapper;
   import com.sulake.habbo.catalog.collectibles.tabs.CollectionsTab;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.NftCollectiblesClaimBonusItemMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.collectibles.NftCollectiblesClaimRewardItemMessageComposer;
   import com.sulake.habbo.communication.messages.parser.collectibles.CollectibleItem;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftCollection;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.utils.FriendlyTime;
   import flash.globalization.DateTimeFormatter;
   
   public class CollectionView implements IComponentInterfaceQueue
   {
      private static var PREVIEW_STATUS_NONE:int = 0;
      
      private static var PREVIEW_STATUS_BONUS:int = 1;
      
      private static var PREVIEW_STATUS_REWARD:int = 2;
      
      private static var PREVIEW_STATUS_COLLECTION:int = 3;
      
      private static var PREVIEW_STATUS_ITEM:int = 4;
      
      private static var BONUS_PROGRESS_ACTIVE_TOP_COLOR:uint = 37130;
      
      private static var BONUS_PROGRESS_ACTIVE_BOTTOM_COLOR:uint = 228352;
      
      private static var BONUS_PROGRESS_EXPIRED_TOP_COLOR:uint = 4294913325;
      
      private static var BONUS_PROGRESS_EXPIRED_BOTTOM_COLOR:uint = 4289724416;
      
      private static var PROGRESS_BAR_UPDATE_THRESHOLD:int = 1000;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromCollectionView_CollectionsTab_1:CollectionsTab;
      
      private var _container:IWindowController_1;
      
      private var _nftCollection:NftCollection;
      
      private var _previewStatus:int;
      
      private var UnknownVarFromCollectionView_Number_1:Number;
      
      private var _gridItems:Vector.<CollectibleItemRenderer>;
      
      private var UnknownVarFromCollectionView_CollectibleItemRenderer_1:CollectibleItemRenderer;
      
      private var UnknownVarFromCollectionView_CollectibleProductPreviewer_1:CollectibleProductPreviewer;
      
      private var UnknownVarFromCollectionView_DateTimeFormatter_1:DateTimeFormatter;
      
      private var UnknownVarFromCollectionView_Boolean_1:Boolean;
      
      public function CollectionView(param1:CollectionsTab, param2:IWindowController_1, param3:NftCollection)
      {
         super();
         UnknownVarFromCollectionView_CollectionsTab_1 = param1;
         _container = param2;
         _nftCollection = param3;
         _gridItems = new Vector.<CollectibleItemRenderer>();
         UnknownVarFromCollectionView_DateTimeFormatter_1 = new DateTimeFormatter("i-default");
         UnknownVarFromCollectionView_DateTimeFormatter_1.setDateTimePattern("dd/MM/yyyy");
         _previewStatus = PREVIEW_STATUS_NONE;
         UnknownVarFromCollectionView_CollectibleProductPreviewer_1 = new CollectibleProductPreviewer(productPreviewBitmap,badgeImageWidget,petImageWidget,unknownImageWindow,avatarImageWidget,placeholderImage,effectImageWidget,param1.controller.avatarRenderManager);
         initHeader();
         initCollectionPreview();
         populateGridItems();
         productNameContainer.addEventListener("WME_OVER",onProductNameHover);
         productNameContainer.addEventListener("WME_OUT",onProductNameUnhover);
         claimButton.addEventListener("WME_CLICK",onClickClaim);
      }
      
      private function initHeader() : void
      {
         titleText.caption = localization.getLocalization("collectibles.set." + _nftCollection.collectionId,_nftCollection.collectionName);
         var _loc1_:int = _nftCollection.collectedItemCount;
         var _loc2_:int = _nftCollection.totalItemCount;
         progressText.caption = _loc1_ + "/" + _loc2_;
         var _loc3_:uint = CollectionProgressColorUtil.getColor(_loc1_,_loc2_);
         progressColorContainer.color = _loc3_;
      }
      
      private function initCollectionPreview() : void
      {
         var _loc2_:CollectibleItem = initRewardClaim();
         var _loc1_:* = _nftCollection.collectedItemCount == _nftCollection.totalItemCount;
         collectionProgressContainer.visible = true;
         collectionProgressScoreText.caption = localization.getLocalizationWithParams("collectibles.preview.score","","progress","<font color=\"#00FF12\">" + _nftCollection.collectionScore + "</font>","goal",_nftCollection.collectionTotalScore + "");
         collectionProgressRewardText.caption = localization.getLocalizationWithParams(_loc1_ ? "collectibles.preview.reward_collected" : "collectibles.preview.reward","","amount","<font color=\"#FFC800\">" + _nftCollection.collectionBoostScore + "</font>");
         productNameContainer.visible = false;
         productProgressContainer.visible = false;
         setProductInfoVisible(false);
         if(_loc2_ == null)
         {
            UnknownVarFromCollectionView_CollectibleProductPreviewer_1.setPlaceholder();
         }
         else
         {
            UnknownVarFromCollectionView_CollectionsTab_1.controller.previewImage(new CollectionItemWrapper(_loc2_),UnknownVarFromCollectionView_CollectibleProductPreviewer_1);
         }
      }
      
      private function initRewardClaim() : CollectibleItem
      {
         var _loc5_:Boolean = nftCollection.hasRewardItem;
         var _loc4_:Boolean = nftCollection.hasBonusItem;
         var _loc3_:Boolean = nftCollection.rewardClaimed;
         var _loc2_:Boolean = nftCollection.canClaimReward;
         var _loc1_:Boolean = nftCollection.bonusClaimed;
         var _loc6_:Boolean = nftCollection.canClaimBonus;
         if(_loc6_)
         {
            initRewardItem(_nftCollection.bonusItem,true,true);
            return _nftCollection.bonusItem;
         }
         if(_loc2_)
         {
            initRewardItem(_nftCollection.rewardItem,true,false);
            return _nftCollection.rewardItem;
         }
         if(_loc4_ && !_loc1_)
         {
            initRewardItem(_nftCollection.bonusItem,_loc6_,true);
            return _nftCollection.bonusItem;
         }
         if(_loc5_ && !_loc3_)
         {
            initRewardItem(_nftCollection.rewardItem,_loc2_,false);
            return _nftCollection.rewardItem;
         }
         _previewStatus = PREVIEW_STATUS_COLLECTION;
         completionContainer.visible = false;
         return null;
      }
      
      private function initRewardItem(param1:CollectibleItem, param2:Boolean, param3:Boolean) : void
      {
         _previewStatus = param3 ? PREVIEW_STATUS_BONUS : PREVIEW_STATUS_REWARD;
         completionContainer.visible = true;
         completionRewardNameText.caption = UnknownVarFromCollectionView_CollectionsTab_1.controller.getProductName(new CollectionItemWrapper(param1));
         completionProgressBar.visible = param3;
         completionHeaderContainer.height = param3 ? 60 : 38;
         if(param3)
         {
            updateBonusProgressBar();
         }
         var _loc4_:int = param3 ? nftCollection.claimingBonusStatus : nftCollection.claimingRewardStatus;
         if(_loc4_ == NftCollection.UnknownVarFromNftCollection_Int_4)
         {
            claimButton.enable();
         }
         else
         {
            claimButton.disable();
         }
         claimButton.visible = param2;
      }
      
      private function onClickClaim(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromCollectionView_CollectionsTab_1.activeWallet == null)
         {
            return;
         }
         if(_previewStatus == PREVIEW_STATUS_BONUS)
         {
            _nftCollection.claimBonusAwaiting();
            UnknownVarFromCollectionView_CollectionsTab_1.controller.send(new NftCollectiblesClaimBonusItemMessageComposer(nftCollection.collectionId,UnknownVarFromCollectionView_CollectionsTab_1.activeWallet));
            UnknownVarFromCollectionView_CollectionsTab_1.sendClaimWaitNotification();
         }
         else
         {
            if(_previewStatus != PREVIEW_STATUS_REWARD)
            {
               return;
            }
            _nftCollection.claimRewardAwaiting();
            UnknownVarFromCollectionView_CollectionsTab_1.controller.send(new NftCollectiblesClaimRewardItemMessageComposer(nftCollection.collectionId,UnknownVarFromCollectionView_CollectionsTab_1.activeWallet));
            UnknownVarFromCollectionView_CollectionsTab_1.sendClaimWaitNotification();
         }
         claimButton.disable();
      }
      
      public function claimingFinished(param1:Boolean, param2:Boolean) : void
      {
         if(_previewStatus == PREVIEW_STATUS_REWARD || _previewStatus == PREVIEW_STATUS_BONUS)
         {
            initCollectionPreview();
         }
      }
      
      public function updateBonusProgressBar(param1:Boolean = true, param2:uint = 0) : void
      {
         UnknownVarFromCollectionView_Number_1 += param2;
         if(_previewStatus != PREVIEW_STATUS_BONUS)
         {
            return;
         }
         var _loc4_:Number = _nftCollection.releasedTime;
         var _loc5_:Number = _nftCollection.snapshotTime;
         var _loc3_:Number = new Date().time;
         var _loc6_:Boolean = param1 || UnknownVarFromCollectionView_Number_1 >= PROGRESS_BAR_UPDATE_THRESHOLD || hasBonusClaimWindow(_loc4_,_loc5_) && _loc3_ >= _loc5_ && !UnknownVarFromCollectionView_Boolean_1;
         if(!_loc6_)
         {
            return;
         }
         UnknownVarFromCollectionView_Number_1 = 0;
         if(!hasBonusClaimWindow(_loc4_,_loc5_))
         {
            UnknownVarFromCollectionView_Boolean_1 = false;
            completionProgressBar.visible = false;
            completionHeaderContainer.height = 38;
            return;
         }
         completionProgressBar.visible = true;
         completionHeaderContainer.height = 60;
         if(_loc3_ >= _loc5_)
         {
            showExpiredBonusClaimState(_loc5_);
            UnknownVarFromCollectionView_Boolean_1 = true;
            return;
         }
         UnknownVarFromCollectionView_Boolean_1 = false;
         showActiveBonusClaimTimer(_loc4_,_loc5_,_loc3_);
      }
      
      private function hasBonusClaimWindow(param1:Number, param2:Number) : Boolean
      {
         return !isNaN(param1) && !isNaN(param2) && param1 != -1 && param2 != -1;
      }
      
      private function showActiveBonusClaimTimer(param1:Number, param2:Number, param3:Number) : void
      {
         completionProgressBarTop.color = BONUS_PROGRESS_ACTIVE_TOP_COLOR;
         completionProgressBarBottom.color = BONUS_PROGRESS_ACTIVE_BOTTOM_COLOR;
         var _loc6_:Number = Math.max(0,param2 - param3);
         var _loc4_:Number = param2 - param1;
         var _loc5_:Number = _loc4_ <= 0 ? 1 : Math.min(1,Math.max(0,_loc6_ / _loc4_));
         var _loc7_:int = completionProgressBarPadded.width * _loc5_;
         completionProgressBarTop.width = _loc7_;
         completionProgressBarBottom.width = _loc7_;
         completionProgressBarTop.invalidate();
         completionProgressBarBottom.invalidate();
         var _loc8_:String = FriendlyTime.getFriendlyTime(localization,_loc6_ / 1000);
         completionProgressBarText.caption = localization.getLocalizationWithParams("collectibles.preview.time_left","") + ": " + _loc8_;
      }
      
      private function showExpiredBonusClaimState(param1:Number) : void
      {
         completionProgressBarTop.color = BONUS_PROGRESS_EXPIRED_TOP_COLOR;
         completionProgressBarBottom.color = BONUS_PROGRESS_EXPIRED_BOTTOM_COLOR;
         completionProgressBarTop.width = completionProgressBarPadded.width;
         completionProgressBarBottom.width = completionProgressBarPadded.width;
         completionProgressBarTop.invalidate();
         completionProgressBarBottom.invalidate();
         var _loc2_:String = UnknownVarFromCollectionView_DateTimeFormatter_1.format(new Date(param1));
         completionProgressBarText.caption = localization.getLocalizationWithParams("collectibles.preview.bonus_claim_ended","Bonus item claim period ended - %date%","date",_loc2_);
      }
      
      private function initMintedItemPreview(param1:CollectibleItem) : void
      {
         _previewStatus = PREVIEW_STATUS_ITEM;
         completionContainer.visible = false;
         collectionProgressContainer.visible = false;
         UnknownVarFromCollectionView_CollectibleProductPreviewer_1.clearPreviewer();
         var _loc2_:IRenderableCollectibleItem = new CollectionItemWrapper(param1);
         UnknownVarFromCollectionView_CollectionsTab_1.controller.previewImage(_loc2_,UnknownVarFromCollectionView_CollectibleProductPreviewer_1);
         productNameContainer.visible = true;
         productNameText.caption = UnknownVarFromCollectionView_CollectionsTab_1.controller.getProductName(_loc2_);
         productProgressContainer.visible = true;
         productProgressScoreText.caption = localization.getLocalizationWithParams(param1.amount > 0 ? "collectibles.preview.product.complete" : "collectibles.preview.product.incomplete","","amount","<font color=\"#FFC800\">" + param1.score + "</font>");
         initInfoEntries(param1);
      }
      
      private function initInfoEntries(param1:CollectibleItem) : void
      {
         clearInfoEntries();
         var _loc3_:String = localization.getLocalization("collectibles.item.type");
         var _loc6_:String = localization.getLocalization("collectibles.item.rarity");
         var _loc7_:String = localization.getLocalization("collectibles.item.xp");
         var _loc5_:String = UnknownVarFromCollectionView_CollectionsTab_1.controller.getProductType(new CollectionItemWrapper(param1));
         var _loc2_:String = param1.rarity;
         var _loc4_:String = String(param1.score);
         addInfoEntry(_loc3_,_loc5_);
         addInfoEntry(_loc6_,_loc2_);
         addInfoEntry(_loc7_,_loc4_);
      }
      
      private function addInfoEntry(param1:String, param2:String) : void
      {
         var _loc3_:IWindowController_1 = UnknownVarFromCollectionView_CollectionsTab_1.productInfoEntryTemplate.clone() as IWindowController_1;
         _loc3_.findChildByName("product_info_key").caption = param1;
         _loc3_.findChildByName("product_info_value").caption = param2;
         productInfoList.addListItem(_loc3_);
      }
      
      private function clearInfoEntries() : void
      {
         productInfoList.removeListItems();
      }
      
      private function setProductInfoVisible(param1:Boolean) : void
      {
         productInfoContainer.visible = param1;
      }
      
      private function onProductNameUnhover(param1:WindowMouseEvent) : void
      {
         setProductInfoVisible(false);
      }
      
      private function onProductNameHover(param1:WindowMouseEvent) : void
      {
         setProductInfoVisible(true);
      }
      
      public function populateGridItems() : void
      {
         var _loc4_:IWindowController_1 = null;
         var _loc3_:CollectibleItemRenderer = null;
         clearGridItems();
         var _loc1_:IWindowController_1 = UnknownVarFromCollectionView_CollectionsTab_1.gridItemTemplate;
         for each(var _loc2_ in _nftCollection.items)
         {
            _loc4_ = _loc1_.clone() as IWindowController_1;
            _loc3_ = new CollectibleItemRenderer(UnknownVarFromCollectionView_CollectionsTab_1.controller,_loc2_,_loc4_,this);
            itemGrid.addGridItem(_loc4_);
            _gridItems.push(_loc3_);
         }
      }
      
      public function clearGridItems() : void
      {
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
      
      public function get nftCollection() : NftCollection
      {
         return _nftCollection;
      }
      
      public function selectItem(param1:CollectibleItemRenderer) : void
      {
         if(UnknownVarFromCollectionView_CollectibleItemRenderer_1 == param1)
         {
            UnknownVarFromCollectionView_CollectibleItemRenderer_1.deactivate();
            UnknownVarFromCollectionView_CollectibleItemRenderer_1 = null;
            initCollectionPreview();
            return;
         }
         if(UnknownVarFromCollectionView_CollectibleItemRenderer_1 != null)
         {
            UnknownVarFromCollectionView_CollectibleItemRenderer_1.deactivate();
            UnknownVarFromCollectionView_CollectibleItemRenderer_1 = null;
         }
         if(param1 != null)
         {
            UnknownVarFromCollectionView_CollectibleItemRenderer_1 = param1;
            UnknownVarFromCollectionView_CollectibleItemRenderer_1.activate();
            initMintedItemPreview(param1.item);
         }
         else
         {
            UnknownVarFromCollectionView_CollectibleItemRenderer_1 = null;
            initCollectionPreview();
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         UnknownVarFromCollectionView_CollectibleProductPreviewer_1.clearPreviewer();
         clearInfoEntries();
         clearGridItems();
         productNameContainer.removeEventListener("WME_OVER",onProductNameHover);
         productNameContainer.removeEventListener("WME_OUT",onProductNameUnhover);
         claimButton.removeEventListener("WME_CLICK",onClickClaim);
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get localization() : IHabboLocalizationManager
      {
         return UnknownVarFromCollectionView_CollectionsTab_1.controller.localizationManager;
      }
      
      private function get titleText() : ITextWindow
      {
         return _container.findChildByName("collection_name") as ITextWindow;
      }
      
      private function get progressColorContainer() : UnknownICoreWindowComponents6
      {
         return _container.findChildByName("progress_color") as UnknownICoreWindowComponents6;
      }
      
      private function get progressText() : ITextWindow
      {
         return _container.findChildByName("progress_text") as ITextWindow;
      }
      
      private function get completionContainer() : IWindowController_1
      {
         return _container.findChildByName("bonus_or_reward_container") as IWindowController_1;
      }
      
      private function get completionHeaderContainer() : IWindowController_1
      {
         return _container.findChildByName("completion_header_container") as IWindowController_1;
      }
      
      private function get completionRewardNameText() : ITextWindow
      {
         return _container.findChildByName("reward_furni_name") as ITextWindow;
      }
      
      private function get completionProgressBar() : IWindowController_1
      {
         return _container.findChildByName("progress_bar") as IWindowController_1;
      }
      
      private function get completionProgressBarPadded() : IWindowController_1
      {
         return _container.findChildByName("progress_padded_bar") as IWindowController_1;
      }
      
      private function get completionProgressBarTop() : IWindowController_1
      {
         return _container.findChildByName("progress_bar_top") as IWindowController_1;
      }
      
      private function get completionProgressBarBottom() : IWindowController_1
      {
         return _container.findChildByName("progress_bar_bottom") as IWindowController_1;
      }
      
      private function get completionProgressBarText() : ITextWindow
      {
         return _container.findChildByName("progress_bar_text") as ITextWindow;
      }
      
      private function get claimButton() : UnknownICoreWindowComponents4
      {
         return _container.findChildByName("claim_button") as UnknownICoreWindowComponents4;
      }
      
      private function get collectionProgressContainer() : IWindowController_1
      {
         return _container.findChildByName("collection_progress_container") as IWindowController_1;
      }
      
      private function get collectionProgressScoreText() : ITextWindow
      {
         return _container.findChildByName("preview_score_text") as ITextWindow;
      }
      
      private function get collectionProgressRewardText() : ITextWindow
      {
         return _container.findChildByName("preview_reward_text") as ITextWindow;
      }
      
      private function get placeholderImage() : IStaticBitmapWrapperWindow
      {
         return _container.findChildByName("placeholder_image") as IStaticBitmapWrapperWindow;
      }
      
      private function get productPreviewBitmap() : IBitmapWrapperController
      {
         return _container.findChildByName("product_preview") as IBitmapWrapperController;
      }
      
      private function get productNameContainer() : IWindowController_1
      {
         return _container.findChildByName("product_name_container") as IWindowController_1;
      }
      
      private function get productNameText() : ITextWindow
      {
         return _container.findChildByName("preview_furni_name") as ITextWindow;
      }
      
      private function get productInfoContainer() : IWindowController_1
      {
         return _container.findChildByName("product_info_container") as IWindowController_1;
      }
      
      private function get productInfoList() : IItemListWindow
      {
         return _container.findChildByName("product_info_list") as IItemListWindow;
      }
      
      private function get productProgressContainer() : IWindowController_1
      {
         return _container.findChildByName("product_progress_container") as IWindowController_1;
      }
      
      private function get productProgressScoreText() : ITextWindow
      {
         return _container.findChildByName("procuct_score_text") as ITextWindow;
      }
      
      private function get itemGrid() : IItemGridWindow
      {
         return _container.findChildByName("itemgrid_collection") as IItemGridWindow;
      }
      
      private function get avatarImageWidget() : IWidgetWindowController
      {
         return _container.findChildByName("avatar_image_widget") as IWidgetWindowController;
      }
      
      private function get badgeImageWidget() : IWidgetWindowController
      {
         return _container.findChildByName("badge_image_widget") as IWidgetWindowController;
      }
      
      private function get petImageWidget() : IWidgetWindowController
      {
         return _container.findChildByName("pet_image_widget") as IWidgetWindowController;
      }
      
      private function get effectImageWidget() : IWidgetWindowController
      {
         return _container.findChildByName("effect_image_widget") as IWidgetWindowController;
      }
      
      private function get unknownImageWindow() : IStaticBitmapWrapperWindow
      {
         return _container.findChildByName("unknown_image") as IStaticBitmapWrapperWindow;
      }
   }
}

