package com.sulake.habbo.catalog.habbicons
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.purse.ActivityPointTypeEnum;
   import com.sulake.habbo.communication.messages.parser.habbicons.UnknownHabboCommunicationMessagesParserHabbicons2;
   import com.sulake.habbo.communication.messages.parser.habbicons.UnknownHabboCommunicationMessagesParserHabbicons3;
   import com.sulake.habbo.habbicons.assets.HabbiconAssetManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class HabbiconView implements IComponentInterfaceQueue, IProfiler_1
   {
      private static const DESKTOP_WINDOW_LAYER:uint = 1;
      
      private var UnknownVarFromHabbiconView_HabbiconController_1:HabbiconController;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _window:IWindowController_1;
      
      private var _headerView:HabbiconAlbumHeaderView;
      
      private var UnknownVarFromHabbiconView_HabbiconTabView_1:HabbiconTabView;
      
      private var UnknownVarFromHabbiconView_HabbiconSetRailView_1:HabbiconSetRailView;
      
      private var UnknownVarFromHabbiconView_HabbiconSetPageView_1:HabbiconSetPageView;
      
      private var UnknownVarFromHabbiconView_HabbiconCollectionTrayView_1:HabbiconCollectionTrayView;
      
      private var UnknownVarFromHabbiconView_HabbiconPopupController_1:HabbiconPopupController;
      
      private var UnknownVarFromHabbiconView_IWindowController_1_1:IWindowController_1;
      
      private var _emptyTileTemplate:IWindowController_1;
      
      private var UnknownVarFromHabbiconView_IWindowController_1_2:IWindowController_1;
      
      private var UnknownVarFromHabbiconView_IWindowController_1_3:IWindowController_1;
      
      private var UnknownVarFromHabbiconView_HabbiconAlbumModel_1:HabbiconAlbumModel;
      
      private var UnknownVarFromHabbiconView_String_1:String = "all_sets";
      
      private var UnknownVarFromHabbiconView_HabbiconSetModel_1:HabbiconSetModel;
      
      private var UnknownVarFromHabbiconView_HabbiconTileView_1:HabbiconTileView;
      
      private var UnknownVarFromHabbiconView_Boolean_1:Boolean;
      
      private var _disposed:Boolean;
      
      public function HabbiconView(param1:HabbiconController, param2:IHabboWindowManagerComponent)
      {
         super();
         UnknownVarFromHabbiconView_HabbiconController_1 = param1;
         _windowManager = param2;
         _window = _windowManager.buildFromXML(XML(UnknownVarFromHabbiconView_HabbiconController_1.assets.getAssetByName("habbicon_view_xml").content),1) as IWindowController_1;
         _window.center();
         extractTemplates();
         createChildViews();
         addEventListeners();
         UnknownVarFromHabbiconView_HabbiconController_1.registerUpdateReceiver(this,1);
         refreshWholeAlbum(false);
      }
      
      private function extractTemplates() : void
      {
         UnknownVarFromHabbiconView_IWindowController_1_1 = setGrid.getGridItemByName("tile_template") as IWindowController_1;
         setGrid.removeGridItem(UnknownVarFromHabbiconView_IWindowController_1_1);
         _emptyTileTemplate = setGrid.getGridItemByName("empty_tile_template") as IWindowController_1;
         setGrid.removeGridItem(_emptyTileTemplate);
         UnknownVarFromHabbiconView_IWindowController_1_2 = trayGroupList.getListItemByName("tray_group_template") as IWindowController_1;
         UnknownVarFromHabbiconView_IWindowController_1_3 = (UnknownVarFromHabbiconView_IWindowController_1_2.findChildByName("tray_group_grid") as IItemGridWindow).getGridItemByName("tray_tile_template") as IWindowController_1;
      }
      
      private function createChildViews() : void
      {
         _headerView = new HabbiconAlbumHeaderView(UnknownVarFromHabbiconView_HabbiconController_1,albumHeader);
         UnknownVarFromHabbiconView_HabbiconTabView_1 = new HabbiconTabView(_window,onTabChanged);
         UnknownVarFromHabbiconView_HabbiconSetRailView_1 = new HabbiconSetRailView(allSetsContainer,onSetSelected);
         UnknownVarFromHabbiconView_HabbiconSetPageView_1 = new HabbiconSetPageView(UnknownVarFromHabbiconView_HabbiconController_1,setPageContainer,UnknownVarFromHabbiconView_IWindowController_1_1,_emptyTileTemplate,onTileClicked);
         UnknownVarFromHabbiconView_HabbiconCollectionTrayView_1 = new HabbiconCollectionTrayView(UnknownVarFromHabbiconView_HabbiconController_1,trayContainer,UnknownVarFromHabbiconView_IWindowController_1_2,UnknownVarFromHabbiconView_IWindowController_1_3,onTileClicked);
         UnknownVarFromHabbiconView_HabbiconPopupController_1 = new HabbiconPopupController(_window,onPopupActionClicked,onPopupBuyClicked,onPopupHidden,isPointInsideAnyTile,UnknownVarFromHabbiconView_HabbiconController_1.configuration,UnknownVarFromHabbiconView_HabbiconController_1.localizationManager);
      }
      
      private function addEventListeners() : void
      {
         headerButtonClose.addEventListener("WME_CLICK",onWindowClose);
         UnknownVarFromHabbiconView_HabbiconController_1.addEventListener("hce_habbicon_status_changed",onControllerDataUpdated);
         UnknownVarFromHabbiconView_HabbiconController_1.addEventListener("hce_owned_habbicons_updated",onControllerDataUpdated);
         UnknownVarFromHabbiconView_HabbiconController_1.addEventListener("hce_shop_data_updated",onControllerDataUpdated);
      }
      
      private function removeEventListeners() : void
      {
         if(_window != null)
         {
            headerButtonClose.removeEventListener("WME_CLICK",onWindowClose);
         }
         if(UnknownVarFromHabbiconView_HabbiconController_1 != null)
         {
            UnknownVarFromHabbiconView_HabbiconController_1.removeEventListener("hce_habbicon_status_changed",onControllerDataUpdated);
            UnknownVarFromHabbiconView_HabbiconController_1.removeEventListener("hce_owned_habbicons_updated",onControllerDataUpdated);
            UnknownVarFromHabbiconView_HabbiconController_1.removeEventListener("hce_shop_data_updated",onControllerDataUpdated);
         }
      }
      
      private function onControllerDataUpdated(param1:HabbiconControllerEvent) : void
      {
         if(param1.habbiconId > 0)
         {
            refreshChangedHabbicon(param1.habbiconId,param1.collectionId,shouldAnimateProgress());
            return;
         }
         if(param1.type == "hce_owned_habbicons_updated" || param1.type == "hce_shop_data_updated")
         {
            if(UnknownVarFromHabbiconView_HabbiconAlbumModel_1 == null || UnknownVarFromHabbiconView_HabbiconAlbumModel_1.sets.length == 0)
            {
               refreshWholeAlbum(true);
            }
            else
            {
               refreshProgressFromController(shouldAnimateProgress());
            }
         }
      }
      
      private function rebuildAlbum(param1:Boolean) : void
      {
         var _loc2_:int = int(param1 && UnknownVarFromHabbiconView_HabbiconSetModel_1 != null ? UnknownVarFromHabbiconView_HabbiconSetModel_1.collectionId : 0);
         UnknownVarFromHabbiconView_HabbiconAlbumModel_1 = buildAlbumFromController();
         UnknownVarFromHabbiconView_HabbiconSetModel_1 = _loc2_ > 0 ? UnknownVarFromHabbiconView_HabbiconAlbumModel_1.findSetByCollectionId(_loc2_) : null;
         if(UnknownVarFromHabbiconView_HabbiconSetModel_1 == null && UnknownVarFromHabbiconView_HabbiconAlbumModel_1.sets.length > 0)
         {
            UnknownVarFromHabbiconView_HabbiconSetModel_1 = UnknownVarFromHabbiconView_HabbiconAlbumModel_1.sets[0];
         }
      }
      
      private function refreshWholeAlbum(param1:Boolean) : void
      {
         hidePopupAndClearActiveTile();
         rebuildAlbum(param1);
         _headerView.refresh(UnknownVarFromHabbiconView_HabbiconAlbumModel_1.UnknownVarFromHabbiconAlbumModel_HabbiconAlbumStats_1,false);
         UnknownVarFromHabbiconView_HabbiconSetRailView_1.setSets(UnknownVarFromHabbiconView_HabbiconAlbumModel_1.sets);
         UnknownVarFromHabbiconView_HabbiconSetRailView_1.setActiveSet(UnknownVarFromHabbiconView_HabbiconSetModel_1);
         refreshActiveTabContent();
      }
      
      private function refreshChangedHabbicon(param1:int, param2:int, param3:Boolean) : void
      {
         var _loc11_:HabbiconSetModel = null;
         var _loc9_:* = null;
         var _loc10_:Boolean = param3 && UnknownVarFromHabbiconView_String_1 == "all_sets";
         var _loc8_:Boolean = UnknownVarFromHabbiconView_HabbiconPopupController_1.visible && UnknownVarFromHabbiconView_HabbiconPopupController_1.activeTile != null && UnknownVarFromHabbiconView_HabbiconPopupController_1.activeTile.item != null;
         var _loc5_:int = int(_loc8_ ? UnknownVarFromHabbiconView_HabbiconPopupController_1.activeTile.item.habbiconId : 0);
         var _loc4_:HabbiconAlbumModel = buildAlbumFromController();
         var _loc7_:HabbiconEntryModel = _loc4_.findEntryByHabbiconId(param1);
         var _loc6_:HabbiconSetModel = param2 > 0 ? _loc4_.findSetByCollectionId(param2) : null;
         if(_loc6_ == null && _loc7_ != null)
         {
            _loc6_ = _loc4_.findSetByCollectionId(_loc7_.collectionId);
         }
         if(UnknownVarFromHabbiconView_HabbiconAlbumModel_1 == null || _loc6_ == null)
         {
            refreshWholeAlbum(true);
            return;
         }
         _loc11_ = UnknownVarFromHabbiconView_HabbiconAlbumModel_1.findSetByCollectionId(_loc6_.collectionId);
         if(_loc11_ == null)
         {
            refreshWholeAlbum(true);
            return;
         }
         UnknownVarFromHabbiconView_HabbiconAlbumModel_1.UnknownVarFromHabbiconAlbumModel_HabbiconAlbumStats_1 = _loc4_.UnknownVarFromHabbiconAlbumModel_HabbiconAlbumStats_1;
         UnknownVarFromHabbiconView_HabbiconAlbumModel_1.UnknownVarFromHabbiconAlbumModel_Vector_1 = _loc4_.UnknownVarFromHabbiconAlbumModel_Vector_1;
         UnknownVarFromHabbiconView_HabbiconAlbumModel_1.favouriteGroups = _loc4_.favouriteGroups;
         copySetState(_loc11_,_loc6_);
         _loc9_ = _loc11_;
         _headerView.refresh(UnknownVarFromHabbiconView_HabbiconAlbumModel_1.UnknownVarFromHabbiconAlbumModel_HabbiconAlbumStats_1,param3);
         UnknownVarFromHabbiconView_HabbiconSetRailView_1.setActiveSet(UnknownVarFromHabbiconView_HabbiconSetModel_1);
         if(_loc9_ != null)
         {
            UnknownVarFromHabbiconView_HabbiconSetRailView_1.refreshSet(_loc9_,_loc10_);
         }
         if(UnknownVarFromHabbiconView_String_1 == "all_sets")
         {
            refreshActiveSetChange(_loc9_,_loc7_,_loc10_);
            if(_loc8_ && _loc5_ == param1 && UnknownVarFromHabbiconView_HabbiconPopupController_1.activeTile != null && UnknownVarFromHabbiconView_HabbiconPopupController_1.activeTile.item != null)
            {
               UnknownVarFromHabbiconView_HabbiconPopupController_1.showForTile(UnknownVarFromHabbiconView_HabbiconPopupController_1.activeTile);
            }
            return;
         }
         hidePopupAndClearActiveTile();
         refreshActiveTabContent();
      }
      
      private function refreshProgressFromController(param1:Boolean) : void
      {
         var _loc7_:HabbiconSetModel = null;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc2_:HabbiconAlbumModel = buildAlbumFromController();
         var _loc6_:Boolean = param1 && UnknownVarFromHabbiconView_String_1 == "all_sets";
         if(_loc2_.sets.length == 0)
         {
            return;
         }
         if(albumStatsChanged(UnknownVarFromHabbiconView_HabbiconAlbumModel_1.UnknownVarFromHabbiconAlbumModel_HabbiconAlbumStats_1,_loc2_.UnknownVarFromHabbiconAlbumModel_HabbiconAlbumStats_1))
         {
            UnknownVarFromHabbiconView_HabbiconAlbumModel_1.UnknownVarFromHabbiconAlbumModel_HabbiconAlbumStats_1 = _loc2_.UnknownVarFromHabbiconAlbumModel_HabbiconAlbumStats_1;
            _headerView.refresh(UnknownVarFromHabbiconView_HabbiconAlbumModel_1.UnknownVarFromHabbiconAlbumModel_HabbiconAlbumStats_1,param1);
         }
         else
         {
            UnknownVarFromHabbiconView_HabbiconAlbumModel_1.UnknownVarFromHabbiconAlbumModel_HabbiconAlbumStats_1 = _loc2_.UnknownVarFromHabbiconAlbumModel_HabbiconAlbumStats_1;
         }
         UnknownVarFromHabbiconView_HabbiconAlbumModel_1.UnknownVarFromHabbiconAlbumModel_Vector_1 = _loc2_.UnknownVarFromHabbiconAlbumModel_Vector_1;
         UnknownVarFromHabbiconView_HabbiconAlbumModel_1.favouriteGroups = _loc2_.favouriteGroups;
         for each(var _loc5_ in _loc2_.sets)
         {
            _loc7_ = UnknownVarFromHabbiconView_HabbiconAlbumModel_1.findSetByCollectionId(_loc5_.collectionId);
            if(_loc7_ != null)
            {
               _loc3_ = _loc7_.completed != _loc5_.completed || _loc7_.total != _loc5_.total;
               _loc4_ = setRewardPanelChanged(_loc7_,_loc5_);
               copySetState(_loc7_,_loc5_);
               if(_loc3_)
               {
                  UnknownVarFromHabbiconView_HabbiconSetRailView_1.refreshSet(_loc7_,_loc6_);
                  if(UnknownVarFromHabbiconView_HabbiconSetModel_1 != null && UnknownVarFromHabbiconView_HabbiconSetModel_1.collectionId == _loc7_.collectionId)
                  {
                     UnknownVarFromHabbiconView_HabbiconSetPageView_1.refreshProgress(UnknownVarFromHabbiconView_HabbiconSetModel_1,_loc6_);
                  }
               }
               if(_loc3_ || _loc4_)
               {
                  if(UnknownVarFromHabbiconView_HabbiconSetModel_1 != null && UnknownVarFromHabbiconView_HabbiconSetModel_1.collectionId == _loc7_.collectionId)
                  {
                     UnknownVarFromHabbiconView_HabbiconSetPageView_1.refreshReward(UnknownVarFromHabbiconView_HabbiconSetModel_1,_loc6_);
                  }
               }
            }
         }
      }
      
      private function albumStatsChanged(param1:HabbiconAlbumStats, param2:HabbiconAlbumStats) : Boolean
      {
         return param1 == null || param2 == null || param1.ownedHabbicons != param2.ownedHabbicons || param1.completedSets != param2.completedSets || param1.collected != param2.collected || param1.total != param2.total;
      }
      
      private function setRewardPanelChanged(param1:HabbiconSetModel, param2:HabbiconSetModel) : Boolean
      {
         return param1 == null || param2 == null || param1.canBuy != param2.canBuy || param1.priceCredits != param2.priceCredits || param1.priceActivityPoints != param2.priceActivityPoints || param1.activityPointType != param2.activityPointType || rewardHabbiconChanged(param1.rewardHabbicon,param2.rewardHabbicon);
      }
      
      private function rewardHabbiconChanged(param1:HabbiconEntryModel, param2:HabbiconEntryModel) : Boolean
      {
         if(param1 == null || param2 == null)
         {
            return param1 != param2;
         }
         return param1.habbiconId != param2.habbiconId || param1.state != param2.state || param1.owned != param2.owned || param1.favorite != param2.favorite || param1.claimable != param2.claimable;
      }
      
      private function copySetState(param1:HabbiconSetModel, param2:HabbiconSetModel) : void
      {
         param1.id = param2.id;
         param1.collectionId = param2.collectionId;
         param1.name = param2.name;
         param1.title = param2.title;
         param1.description = param2.description;
         param1.UnknownVarFromHabbiconSetModel_BitmapData_1 = param2.UnknownVarFromHabbiconSetModel_BitmapData_1;
         param1.habbicons = param2.habbicons;
         param1.rewardHabbicon = param2.rewardHabbicon;
         param1.completed = param2.completed;
         param1.total = param2.total;
         param1.priceCredits = param2.priceCredits;
         param1.priceActivityPoints = param2.priceActivityPoints;
         param1.activityPointType = param2.activityPointType;
         param1.canBuy = param2.canBuy;
      }
      
      private function refreshActiveSetChange(param1:HabbiconSetModel, param2:HabbiconEntryModel, param3:Boolean) : void
      {
         if(UnknownVarFromHabbiconView_HabbiconSetModel_1 == null || param1 == null || UnknownVarFromHabbiconView_HabbiconSetModel_1.collectionId != param1.collectionId)
         {
            return;
         }
         UnknownVarFromHabbiconView_HabbiconSetPageView_1.refreshProgress(UnknownVarFromHabbiconView_HabbiconSetModel_1,param3);
         UnknownVarFromHabbiconView_HabbiconSetPageView_1.refreshReward(UnknownVarFromHabbiconView_HabbiconSetModel_1,param3);
         if(param2 != null && !param2.isReward)
         {
            UnknownVarFromHabbiconView_HabbiconSetPageView_1.refreshEntry(param2);
         }
      }
      
      private function refreshActiveTabContent() : void
      {
         if(UnknownVarFromHabbiconView_HabbiconAlbumModel_1 == null)
         {
            return;
         }
         if(UnknownVarFromHabbiconView_String_1 == "all_sets")
         {
            allSetsContainer.visible = true;
            trayContainer.visible = false;
            UnknownVarFromHabbiconView_HabbiconSetPageView_1.refresh(UnknownVarFromHabbiconView_HabbiconSetModel_1,false);
         }
         else if(UnknownVarFromHabbiconView_String_1 == "owned")
         {
            allSetsContainer.visible = false;
            trayContainer.visible = true;
            UnknownVarFromHabbiconView_HabbiconCollectionTrayView_1.refresh(UnknownVarFromHabbiconView_String_1,UnknownVarFromHabbiconView_HabbiconAlbumModel_1.UnknownVarFromHabbiconAlbumModel_Vector_1);
         }
         else if(UnknownVarFromHabbiconView_String_1 == "favourited")
         {
            allSetsContainer.visible = false;
            trayContainer.visible = true;
            UnknownVarFromHabbiconView_HabbiconCollectionTrayView_1.refresh(UnknownVarFromHabbiconView_String_1,UnknownVarFromHabbiconView_HabbiconAlbumModel_1.favouriteGroups);
         }
      }
      
      private function selectSet(param1:HabbiconSetModel) : void
      {
         UnknownVarFromHabbiconView_HabbiconSetModel_1 = param1;
         hidePopupAndClearActiveTile();
         UnknownVarFromHabbiconView_HabbiconSetRailView_1.setActiveSet(UnknownVarFromHabbiconView_HabbiconSetModel_1);
         if(UnknownVarFromHabbiconView_String_1 == "all_sets")
         {
            UnknownVarFromHabbiconView_HabbiconSetPageView_1.refresh(UnknownVarFromHabbiconView_HabbiconSetModel_1,false);
         }
      }
      
      private function onTabChanged(param1:String) : void
      {
         UnknownVarFromHabbiconView_String_1 = param1;
         hidePopupAndClearActiveTile();
         allSetsContainer.visible = param1 == "all_sets";
         trayContainer.visible = param1 != "all_sets";
         if(param1 == "owned")
         {
            UnknownVarFromHabbiconView_HabbiconCollectionTrayView_1.refresh(param1,UnknownVarFromHabbiconView_HabbiconAlbumModel_1.UnknownVarFromHabbiconAlbumModel_Vector_1);
         }
         else if(param1 == "favourited")
         {
            UnknownVarFromHabbiconView_HabbiconCollectionTrayView_1.refresh(param1,UnknownVarFromHabbiconView_HabbiconAlbumModel_1.favouriteGroups);
         }
         else
         {
            UnknownVarFromHabbiconView_HabbiconSetPageView_1.refresh(UnknownVarFromHabbiconView_HabbiconSetModel_1,false);
         }
      }
      
      private function onSetSelected(param1:HabbiconSetModel) : void
      {
         selectSet(param1);
      }
      
      private function onTileClicked(param1:HabbiconTileView) : void
      {
         if(param1 == null || param1.item == null)
         {
            return;
         }
         if(UnknownVarFromHabbiconView_HabbiconTileView_1 != null && UnknownVarFromHabbiconView_HabbiconTileView_1 != param1)
         {
            UnknownVarFromHabbiconView_HabbiconTileView_1.setActive(false);
         }
         UnknownVarFromHabbiconView_HabbiconTileView_1 = param1;
         UnknownVarFromHabbiconView_HabbiconTileView_1.setActive(true);
         if(!param1.item.isReward && !param1.item.owned && !param1.item.claimable)
         {
            UnknownVarFromHabbiconView_HabbiconController_1.getHabbiconInfo(param1.item.habbiconId);
         }
         UnknownVarFromHabbiconView_HabbiconPopupController_1.showForTile(param1);
      }
      
      private function onPopupActionClicked(param1:HabbiconTileView, param2:String) : void
      {
         if(param1 == null || param1.item == null)
         {
            return;
         }
         switch(param2)
         {
            case "claim":
               if(param1.item.claimable)
               {
                  UnknownVarFromHabbiconView_HabbiconController_1.claimHabbicon(param1.item.habbiconId);
               }
               break;
            case "add_favorite":
               if(param1.item.owned)
               {
                  UnknownVarFromHabbiconView_HabbiconController_1.favoriteHabbicon(param1.item.habbiconId);
               }
               break;
            case "remove_favorite":
               if(param1.item.favorite)
               {
                  UnknownVarFromHabbiconView_HabbiconController_1.unfavoriteHabbicon(param1.item.habbiconId);
               }
         }
      }
      
      private function onPopupBuyClicked(param1:HabbiconTileView) : void
      {
         if(param1 == null || param1.item == null)
         {
            return;
         }
         if(param1.item.purchasable && hasHabbiconPrice(param1.item))
         {
            UnknownVarFromHabbiconView_HabbiconController_1.openHabbiconPurchaseConfirmation(param1.item);
            hidePopupAndClearActiveTile();
         }
      }
      
      private function onPopupHidden() : void
      {
         clearActiveTile();
      }
      
      private function hidePopupAndClearActiveTile() : void
      {
         if(UnknownVarFromHabbiconView_HabbiconPopupController_1 != null)
         {
            UnknownVarFromHabbiconView_HabbiconPopupController_1.hide(false);
         }
         clearActiveTile();
      }
      
      private function clearActiveTile() : void
      {
         if(UnknownVarFromHabbiconView_HabbiconTileView_1 != null)
         {
            UnknownVarFromHabbiconView_HabbiconTileView_1.setActive(false);
            UnknownVarFromHabbiconView_HabbiconTileView_1 = null;
         }
      }
      
      private function buildAlbumFromController() : HabbiconAlbumModel
      {
         var _loc6_:* = null;
         var _loc2_:HabbiconSetModel = null;
         var _loc4_:* = null;
         var _loc1_:HabbiconEntryModel = null;
         var _loc5_:HabbiconAlbumModel = new HabbiconAlbumModel();
         var _loc3_:Vector.<UnknownHabboCommunicationMessagesParserHabbicons3> = UnknownVarFromHabbiconView_HabbiconController_1.shopCollections;
         if(_loc3_ == null || _loc3_.length == 0)
         {
            return _loc5_;
         }
         for each(_loc6_ in _loc3_)
         {
            if(_loc6_ != null)
            {
               _loc2_ = new HabbiconSetModel();
               _loc2_.collectionId = _loc6_.collectionId;
               _loc2_.id = "collection_" + _loc6_.collectionId;
               _loc2_.name = _loc6_.name;
               _loc2_.title = resolveCollectionTitle(_loc6_);
               _loc2_.description = resolveCollectionDescription(_loc6_);
               _loc2_.priceCredits = _loc6_.priceCredits;
               _loc2_.priceActivityPoints = _loc6_.priceActivityPoints;
               _loc2_.activityPointType = _loc6_.activityPointType;
               _loc2_.UnknownVarFromHabbiconSetModel_BitmapData_1 = HabbiconAssetManager.getCollectionIconBitmap(_loc6_.collectionId);
               if(_loc6_.habbicons != null)
               {
                  for each(_loc4_ in _loc6_.habbicons)
                  {
                     _loc1_ = createEntryFromData(_loc4_,_loc2_);
                     if(_loc1_ != null)
                     {
                        _loc2_.habbicons.push(_loc1_);
                     }
                  }
               }
               _loc2_.rewardHabbicon = createRewardEntry(_loc6_,_loc2_);
               _loc2_.canBuy = (_loc6_.priceCredits > 0 || _loc6_.priceActivityPoints > 0) && !_loc6_.completed;
               updateSetProgress(_loc2_);
               _loc5_.sets.push(_loc2_);
            }
         }
         updateAlbumStats(_loc5_);
         _loc5_.UnknownVarFromHabbiconAlbumModel_Vector_1 = createTrayGroups(_loc5_,false);
         _loc5_.favouriteGroups = createFavouriteTrayGroups(_loc5_);
         return _loc5_;
      }
      
      private function createEntryFromData(param1:UnknownHabboCommunicationMessagesParserHabbicons2, param2:HabbiconSetModel) : HabbiconEntryModel
      {
         var _loc3_:HabbiconEntryModel = null;
         if(param1 == null)
         {
            return null;
         }
         _loc3_ = new HabbiconEntryModel();
         _loc3_.id = String(param1.habbiconId);
         _loc3_.habbiconId = param1.habbiconId;
         _loc3_.collectionId = param1.collectionId;
         _loc3_.collectionName = param2.name;
         _loc3_.collectionTitle = param2.title;
         _loc3_.name = resolveHabbiconDisplayName(param1.habbiconId,param1.name);
         _loc3_.description = "Server-driven habbicon state and price.";
         _loc3_.UnknownVarFromHabbiconEntryModel_Int_1 = param2.habbicons.length;
         _loc3_.state = param1.state;
         _loc3_.favorite = _loc3_.state == 3;
         _loc3_.owned = _loc3_.favorite || _loc3_.state == 2;
         _loc3_.claimable = _loc3_.state == 1;
         _loc3_.isReward = false;
         _loc3_.priceCredits = param1.priceCredits;
         _loc3_.priceActivityPoints = param1.priceActivityPoints;
         _loc3_.activityPointType = param1.activityPointType;
         _loc3_.purchasable = _loc3_.state == 0 && hasHabbiconPrice(_loc3_);
         _loc3_.color = seededColor(_loc3_.habbiconId * 37 + _loc3_.collectionId * 11);
         return _loc3_;
      }
      
      private function createRewardEntry(param1:UnknownHabboCommunicationMessagesParserHabbicons3, param2:HabbiconSetModel) : HabbiconEntryModel
      {
         var _loc3_:HabbiconEntryModel = null;
         var _loc4_:int = 0;
         if(param1.UnknownVarFromUnknownHabboCommunicationMessagesParserHabbicons3_Int_1 <= 0)
         {
            return null;
         }
         _loc4_ = param1.UnknownVarFromUnknownHabboCommunicationMessagesParserHabbicons3_Int_2;
         _loc3_ = new HabbiconEntryModel();
         _loc3_.id = "reward_" + param1.UnknownVarFromUnknownHabboCommunicationMessagesParserHabbicons3_Int_1;
         _loc3_.habbiconId = param1.UnknownVarFromUnknownHabboCommunicationMessagesParserHabbicons3_Int_1;
         _loc3_.collectionId = param1.collectionId;
         _loc3_.collectionName = param2.name;
         _loc3_.collectionTitle = param2.title;
         _loc3_.name = resolveHabbiconDisplayName(param1.UnknownVarFromUnknownHabboCommunicationMessagesParserHabbicons3_Int_1);
         _loc3_.description = "Collection reward habbicon.";
         _loc3_.UnknownVarFromHabbiconEntryModel_Int_1 = param2.habbicons.length;
         _loc3_.state = _loc4_;
         _loc3_.favorite = _loc4_ == 3;
         _loc3_.owned = _loc3_.favorite || _loc4_ == 2;
         _loc3_.claimable = _loc4_ == 1;
         _loc3_.purchasable = false;
         _loc3_.isReward = true;
         _loc3_.priceCredits = 0;
         _loc3_.priceActivityPoints = 0;
         _loc3_.activityPointType = param1.activityPointType;
         _loc3_.color = seededColor(_loc3_.habbiconId * 37 + _loc3_.collectionId * 11);
         return _loc3_;
      }
      
      private function createTrayGroups(param1:HabbiconAlbumModel, param2:Boolean) : Vector.<HabbiconSetModel>
      {
         var _loc3_:* = undefined;
         var _loc4_:* = null;
         var _loc6_:Vector.<HabbiconSetModel> = new Vector.<HabbiconSetModel>(0);
         for each(var _loc5_ in param1.sets)
         {
            _loc3_ = new Vector.<HabbiconEntryModel>(0);
            for each(_loc4_ in _loc5_.habbicons)
            {
               if(param2 ? _loc4_.favorite : _loc4_.owned)
               {
                  _loc3_.push(_loc4_);
               }
            }
            if(_loc5_.rewardHabbicon != null && (param2 ? _loc5_.rewardHabbicon.favorite : _loc5_.rewardHabbicon.owned))
            {
               _loc3_.push(_loc5_.rewardHabbicon);
            }
            if(_loc3_.length > 0)
            {
               _loc6_.push(createTrayGroup(_loc5_,_loc3_));
            }
         }
         return _loc6_;
      }
      
      private function createFavouriteTrayGroups(param1:HabbiconAlbumModel) : Vector.<HabbiconSetModel>
      {
         var _loc3_:* = null;
         var _loc6_:HabbiconSetModel = null;
         var _loc5_:Vector.<HabbiconSetModel> = new Vector.<HabbiconSetModel>(0);
         var _loc2_:Vector.<HabbiconEntryModel> = new Vector.<HabbiconEntryModel>(0);
         for each(var _loc4_ in param1.sets)
         {
            for each(_loc3_ in _loc4_.habbicons)
            {
               if(_loc3_.favorite)
               {
                  _loc2_.push(_loc3_);
               }
            }
            if(_loc4_.rewardHabbicon != null && _loc4_.rewardHabbicon.favorite)
            {
               _loc2_.push(_loc4_.rewardHabbicon);
            }
         }
         if(_loc2_.length > 0)
         {
            _loc6_ = new HabbiconSetModel();
            _loc6_.id = "favourited";
            _loc6_.name = "favourited";
            _loc6_.title = "${habbicons.favourites.title}";
            _loc6_.habbicons = _loc2_;
            _loc5_.push(_loc6_);
         }
         return _loc5_;
      }
      
      private function createTrayGroup(param1:HabbiconSetModel, param2:Vector.<HabbiconEntryModel>) : HabbiconSetModel
      {
         var _loc3_:HabbiconSetModel = new HabbiconSetModel();
         _loc3_.id = param1.id;
         _loc3_.collectionId = param1.collectionId;
         _loc3_.name = param1.name;
         _loc3_.title = param1.title;
         _loc3_.description = param1.description;
         _loc3_.UnknownVarFromHabbiconSetModel_BitmapData_1 = param1.UnknownVarFromHabbiconSetModel_BitmapData_1;
         _loc3_.habbicons = param2;
         _loc3_.rewardHabbicon = null;
         _loc3_.completed = param1.completed;
         _loc3_.total = param1.total;
         _loc3_.priceCredits = param1.priceCredits;
         _loc3_.priceActivityPoints = param1.priceActivityPoints;
         _loc3_.activityPointType = param1.activityPointType;
         _loc3_.canBuy = param1.canBuy;
         return _loc3_;
      }
      
      private function updateSetProgress(param1:HabbiconSetModel) : void
      {
         param1.completed = 0;
         param1.total = 0;
         for each(var _loc2_ in param1.habbicons)
         {
            if(!_loc2_.isReward)
            {
               param1.total++;
               if(_loc2_.owned || _loc2_.claimable)
               {
                  param1.completed++;
               }
            }
         }
      }
      
      private function updateAlbumStats(param1:HabbiconAlbumModel) : void
      {
         param1.UnknownVarFromHabbiconAlbumModel_HabbiconAlbumStats_1 = new HabbiconAlbumStats();
         for each(var _loc3_ in param1.sets)
         {
            param1.UnknownVarFromHabbiconAlbumModel_HabbiconAlbumStats_1.total += _loc3_.total;
            param1.UnknownVarFromHabbiconAlbumModel_HabbiconAlbumStats_1.collected += _loc3_.completed;
            if(_loc3_.complete)
            {
               param1.UnknownVarFromHabbiconAlbumModel_HabbiconAlbumStats_1.completedSets++;
            }
            for each(var _loc2_ in _loc3_.habbicons)
            {
               if(_loc2_.owned)
               {
                  param1.UnknownVarFromHabbiconAlbumModel_HabbiconAlbumStats_1.ownedHabbicons++;
               }
            }
            if(_loc3_.rewardHabbicon != null)
            {
               param1.UnknownVarFromHabbiconAlbumModel_HabbiconAlbumStats_1.total++;
               if(_loc3_.rewardHabbicon.owned)
               {
                  param1.UnknownVarFromHabbiconAlbumModel_HabbiconAlbumStats_1.collected++;
                  param1.UnknownVarFromHabbiconAlbumModel_HabbiconAlbumStats_1.ownedHabbicons++;
               }
            }
         }
      }
      
      private function resolveCollectionTitle(param1:UnknownHabboCommunicationMessagesParserHabbicons3) : String
      {
         if(param1 == null || param1.name == null || param1.name.length == 0)
         {
            return "Habbicon Collection";
         }
         return localize("habbicon_collection_" + param1.name.toLowerCase() + "_name",param1.name);
      }
      
      private function resolveCollectionDescription(param1:UnknownHabboCommunicationMessagesParserHabbicons3) : String
      {
         if(param1 == null || param1.name == null || param1.name.length == 0)
         {
            return "";
         }
         return localize("habbicon_collection_" + param1.name.toLowerCase() + "_description",param1.name + " set description");
      }
      
      private function resolveHabbiconDisplayName(param1:int, param2:String = null) : String
      {
         var _loc3_:String = resolveHabbiconKey(param1,param2);
         if(_loc3_ == null || _loc3_.length == 0)
         {
            return "Habbicon";
         }
         return localize("habbicon_" + _loc3_.toLowerCase() + "_name",param2 != null && param2.length > 0 ? param2 : "Habbicon");
      }
      
      private function resolveHabbiconKey(param1:int, param2:String = null) : String
      {
         var _loc3_:String = HabbiconAssetManager.getHabbiconNameKey(param1);
         return _loc3_ != null && _loc3_.length > 0 ? _loc3_ : param2 ?? "";
      }
      
      private function localize(param1:String, param2:String) : String
      {
         var _loc3_:IHabboLocalizationManager = UnknownVarFromHabbiconView_HabbiconController_1 != null ? UnknownVarFromHabbiconView_HabbiconController_1.localizationManager : null;
         var _loc4_:String = _loc3_ != null ? _loc3_.getLocalization(param1,param2) : param2;
         return _loc4_ != null && _loc4_.length > 0 ? _loc4_ : param2;
      }
      
      private function formatPrice(param1:int, param2:int) : String
      {
         if(param1 > 0 && param2 > 0)
         {
            return param1 + "c + " + param2;
         }
         if(param1 > 0)
         {
            return param1.toString();
         }
         return Math.max(0,param2).toString();
      }
      
      private function hasHabbiconPrice(param1:HabbiconEntryModel) : Boolean
      {
         return param1 != null && (param1.priceCredits > 0 || param1.priceActivityPoints > 0);
      }
      
      private function getPriceIconStyle(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:int = param2 > 0 ? param3 : 7;
         return ActivityPointTypeEnum.getIconStyleFor(_loc4_,UnknownVarFromHabbiconView_HabbiconController_1.configuration,false);
      }
      
      private function seededColor(param1:int) : uint
      {
         var _loc2_:int = param1 % 6;
         switch(_loc2_)
         {
            case 0:
               return 16371247;
            case 1:
               return 15964719;
            case 2:
               return 15695663;
            case 3:
               return 9358143;
            case 4:
               return 5095656;
            default:
               return 12813557;
         }
      }
      
      private function onWindowClose(param1:WindowMouseEvent) : void
      {
         hideWindow();
      }
      
      private function hideWindow() : void
      {
         var _loc1_:IDesktopController = null;
         if(UnknownVarFromHabbiconView_HabbiconPopupController_1 != null)
         {
            UnknownVarFromHabbiconView_HabbiconPopupController_1.hide();
            UnknownVarFromHabbiconView_HabbiconPopupController_1.detachFromStage();
         }
         if(_windowManager != null && _window != null && _window.parent != null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
         }
      }
      
      public function showWindow() : void
      {
         var _loc1_:IDesktopController = _windowManager != null ? _windowManager.getDesktop(1) : null;
         if(_windowManager != null && _window != null && _window.parent == null && _loc1_ != null)
         {
            _loc1_.addChild(_window);
         }
         if(UnknownVarFromHabbiconView_HabbiconPopupController_1 != null && _loc1_ != null)
         {
            UnknownVarFromHabbiconView_HabbiconPopupController_1.attachToDesktop(_loc1_);
         }
         if(!UnknownVarFromHabbiconView_Boolean_1)
         {
            UnknownVarFromHabbiconView_HabbiconTabView_1.select("all_sets");
            onTabChanged("all_sets");
            UnknownVarFromHabbiconView_Boolean_1 = true;
         }
         if(_window != null)
         {
            _window.activate();
         }
      }
      
      public function update(param1:uint) : void
      {
         if(!shouldAnimateProgress())
         {
            return;
         }
         _headerView.update(param1);
         if(UnknownVarFromHabbiconView_String_1 == "all_sets")
         {
            UnknownVarFromHabbiconView_HabbiconSetRailView_1.update(param1);
            UnknownVarFromHabbiconView_HabbiconSetPageView_1.update(param1);
         }
      }
      
      private function shouldAnimateProgress() : Boolean
      {
         return _window != null && _window.parent != null;
      }
      
      private function isPointInsideAnyTile(param1:Point) : Boolean
      {
         return UnknownVarFromHabbiconView_HabbiconTileView_1 != null && UnknownVarFromHabbiconView_HabbiconTileView_1.window != null && Boolean(UnknownVarFromHabbiconView_HabbiconTileView_1.window.visible) && isPointInsideWindow(UnknownVarFromHabbiconView_HabbiconTileView_1.window,param1);
      }
      
      private function isPointInsideWindow(param1:IWindowModel, param2:Point) : Boolean
      {
         if(!param1 || !param2)
         {
            return false;
         }
         var _loc3_:Rectangle = new Rectangle();
         param1.getGlobalRectangle(_loc3_);
         return _loc3_.containsPoint(param2);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         hideWindow();
         removeEventListeners();
         UnknownVarFromHabbiconView_HabbiconController_1.removeUpdateReceiver(this);
         if(_headerView != null)
         {
            _headerView.dispose();
            _headerView = null;
         }
         if(UnknownVarFromHabbiconView_HabbiconTabView_1 != null)
         {
            UnknownVarFromHabbiconView_HabbiconTabView_1.dispose();
            UnknownVarFromHabbiconView_HabbiconTabView_1 = null;
         }
         if(UnknownVarFromHabbiconView_HabbiconSetRailView_1 != null)
         {
            UnknownVarFromHabbiconView_HabbiconSetRailView_1.dispose();
            UnknownVarFromHabbiconView_HabbiconSetRailView_1 = null;
         }
         if(UnknownVarFromHabbiconView_HabbiconSetPageView_1 != null)
         {
            UnknownVarFromHabbiconView_HabbiconSetPageView_1.dispose();
            UnknownVarFromHabbiconView_HabbiconSetPageView_1 = null;
         }
         if(UnknownVarFromHabbiconView_HabbiconCollectionTrayView_1 != null)
         {
            UnknownVarFromHabbiconView_HabbiconCollectionTrayView_1.dispose();
            UnknownVarFromHabbiconView_HabbiconCollectionTrayView_1 = null;
         }
         if(UnknownVarFromHabbiconView_HabbiconPopupController_1 != null)
         {
            UnknownVarFromHabbiconView_HabbiconPopupController_1.dispose();
            UnknownVarFromHabbiconView_HabbiconPopupController_1 = null;
         }
         disposeTemplate(UnknownVarFromHabbiconView_IWindowController_1_1);
         disposeTemplate(_emptyTileTemplate);
         disposeTemplate(UnknownVarFromHabbiconView_IWindowController_1_3);
         disposeTemplate(UnknownVarFromHabbiconView_IWindowController_1_2);
         UnknownVarFromHabbiconView_IWindowController_1_1 = null;
         _emptyTileTemplate = null;
         UnknownVarFromHabbiconView_IWindowController_1_3 = null;
         UnknownVarFromHabbiconView_IWindowController_1_2 = null;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         UnknownVarFromHabbiconView_HabbiconAlbumModel_1 = null;
         UnknownVarFromHabbiconView_HabbiconSetModel_1 = null;
         UnknownVarFromHabbiconView_HabbiconTileView_1 = null;
         UnknownVarFromHabbiconView_HabbiconController_1 = null;
         _windowManager = null;
         _disposed = true;
      }
      
      private function disposeTemplate(param1:IWindowController_1) : void
      {
         if(param1 != null && !param1.disposed)
         {
            param1.dispose();
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get headerButtonClose() : IWindowModel
      {
         return _window.findChildByName("header_button_close");
      }
      
      private function get albumHeader() : IWindowController_1
      {
         return _window.findChildByName("album_header") as IWindowController_1;
      }
      
      private function get allSetsContainer() : IWindowController_1
      {
         return _window.findChildByName("all_sets_container") as IWindowController_1;
      }
      
      private function get setPageContainer() : IWindowController_1
      {
         return _window.findChildByName("set_page_container") as IWindowController_1;
      }
      
      private function get setGrid() : IItemGridWindow
      {
         return _window.findChildByName("set_grid") as IItemGridWindow;
      }
      
      private function get trayContainer() : IWindowController_1
      {
         return _window.findChildByName("tray_container") as IWindowController_1;
      }
      
      private function get trayGroupList() : IItemListWindow
      {
         return _window.findChildByName("tray_group_list") as IItemListWindow;
      }
   }
}

