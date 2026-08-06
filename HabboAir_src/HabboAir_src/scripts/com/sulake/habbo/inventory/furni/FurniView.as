package com.sulake.habbo.inventory.furni
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.components.IInteractiveWindow;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.habbo.inventory.IInventoryView;
   import com.sulake.habbo.inventory.items.FurnitureItem;
   import com.sulake.habbo.inventory.items.GroupItem;
   import com.sulake.habbo.inventory.items.IFurnitureItem;
   import com.sulake.habbo.inventory.marketplace.MarketplaceModel;
   import com.sulake.habbo.inventory.wired_trading.requirements.WiredTradeRequirementsModel;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.object.data.MapStuffData;
   import com.sulake.habbo.room.preview.RoomPreviewer;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.widgets.ILimitedItemPreviewOverlayWidget;
   import com.sulake.habbo.window.widgets.IRarityItemPreviewOverlayWidget;
   import com.sulake.habbo.window.widgets.IRoomPreviewerWidget;
   import com.sulake.room.utils.Vector3d;
   import flash.filters.GlowFilter;
   
   public class FurniView implements IInventoryView, IProfiler_1
   {
      private static const STATE_NULL:int = 0;
      
      private static const STATE_INITIALIZING:int = 1;
      
      private static const STATE_EMPTY:int = 2;
      
      private static const STATE_CONTENT:int = 3;
      
      private static const UNSEEN_SYMBOL_MARGIN:int = 4;
      
      private static const MAIN_FILTER_IDS:Array = ["all","floor_items","wall_items","room_layout"];
      
      private var UnknownVarFromFurniView_String_1:String = "";
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var UnknownVarFromFurniView_IAssetLibraryCollection_1:IAssetLibraryCollection;
      
      private var UnknownVarFromFurniView_IWindowController_1_1:IWindowController_1;
      
      private var _grid:FurniGridView;
      
      private var UnknownVarFromFurniView_FurniModel_1:FurniModel;
      
      private var _marketplace:MarketplaceModel;
      
      private var _roomEngine:IRoomEngine;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromFurniView_Int_1:int = 0;
      
      private var UnknownVarFromFurniView_ILimitedItemPreviewOverlayWidget_1:ILimitedItemPreviewOverlayWidget;
      
      private var UnknownVarFromFurniView_IRarityItemPreviewOverlayWidget_1:IRarityItemPreviewOverlayWidget;
      
      private var UnknownVarFromFurniView_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromFurniView_UnknownICoreWindowComponents4_1:UnknownICoreWindowComponents4;
      
      private var UnknownVarFromFurniView_UnknownICoreWindowComponents4_2:UnknownICoreWindowComponents4;
      
      private var UnknownVarFromFurniView_UnknownICoreWindowComponents4_3:UnknownICoreWindowComponents4;
      
      private var _offerInTradingButton:UnknownICoreWindowComponents4;
      
      private var _offerInTradingCountButton:ITextFieldWindow;
      
      private var UnknownVarFromFurniView_UnknownICoreWindowComponents4_4:UnknownICoreWindowComponents4;
      
      private var UnknownVarFromFurniView_UnknownICoreWindowComponents4_5:UnknownICoreWindowComponents4;
      
      private var UnknownVarFromFurniView_UnknownICoreWindowComponents4_6:UnknownICoreWindowComponents4;
      
      private var _isInitialized:Boolean = false;
      
      private var UnknownVarFromFurniView_RoomPreviewer_1:RoomPreviewer;
      
      private var UnknownVarFromFurniView_String_2:String = "all";
      
      private var UnknownVarFromFurniView_String_3:String = "any";
      
      public function FurniView(param1:FurniModel, param2:MarketplaceModel, param3:IHabboWindowManagerComponent, param4:IAssetLibraryCollection, param5:IRoomEngine)
      {
         super();
         UnknownVarFromFurniView_FurniModel_1 = param1;
         _marketplace = param2;
         UnknownVarFromFurniView_IAssetLibraryCollection_1 = param4;
         _windowManager = param3;
         _roomEngine = param5;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get isVisible() : Boolean
      {
         return UnknownVarFromFurniView_IWindowController_1_1 && UnknownVarFromFurniView_IWindowController_1_1.parent != null && UnknownVarFromFurniView_IWindowController_1_1.visible;
      }
      
      public function get isInitialized() : Boolean
      {
         return _isInitialized;
      }
      
      public function get currentPageItems() : Vector.<GroupItem>
      {
         return !!_grid ? _grid.currentPageItems : null;
      }
      
      public function get grid() : FurniGridView
      {
         return _grid;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(UnknownVarFromFurniView_FurniModel_1 && UnknownVarFromFurniView_FurniModel_1.controller)
            {
               UnknownVarFromFurniView_FurniModel_1.controller.removeUpdateReceiver(this);
            }
            UnknownVarFromFurniView_FurniModel_1 = null;
            _marketplace = null;
            UnknownVarFromFurniView_IAssetLibraryCollection_1 = null;
            _windowManager = null;
            _roomEngine = null;
            if(UnknownVarFromFurniView_ILimitedItemPreviewOverlayWidget_1)
            {
               UnknownVarFromFurniView_ILimitedItemPreviewOverlayWidget_1.dispose();
               UnknownVarFromFurniView_ILimitedItemPreviewOverlayWidget_1 = null;
            }
            if(UnknownVarFromFurniView_IRarityItemPreviewOverlayWidget_1)
            {
               UnknownVarFromFurniView_IRarityItemPreviewOverlayWidget_1.dispose();
               UnknownVarFromFurniView_IRarityItemPreviewOverlayWidget_1 = null;
            }
            if(UnknownVarFromFurniView_IWindowController_1_1)
            {
               UnknownVarFromFurniView_IWindowController_1_1.dispose();
               UnknownVarFromFurniView_IWindowController_1_1 = null;
            }
            _disposed = true;
         }
      }
      
      public function getWindowContainer() : IWindowController_1
      {
         if(!_isInitialized)
         {
            init();
         }
         if(UnknownVarFromFurniView_IWindowController_1_1 == null)
         {
            return null;
         }
         if(UnknownVarFromFurniView_IWindowController_1_1.disposed)
         {
            return null;
         }
         updateActionButtons(false);
         return UnknownVarFromFurniView_IWindowController_1_1;
      }
      
      public function setViewToState() : void
      {
         var _loc1_:int = 0;
         if(!UnknownVarFromFurniView_FurniModel_1.isListInited())
         {
            _loc1_ = 1;
         }
         else if(!UnknownVarFromFurniView_FurniModel_1.furniData || UnknownVarFromFurniView_FurniModel_1.furniData.length == 0)
         {
            _loc1_ = 2;
         }
         else
         {
            _loc1_ = 3;
         }
         if(UnknownVarFromFurniView_Int_1 == _loc1_)
         {
            return;
         }
         UnknownVarFromFurniView_Int_1 = _loc1_;
         updateContainerVisibility();
      }
      
      public function clearViews() : void
      {
         updateActionView();
      }
      
      public function getFirstThumb() : IWindowController_1
      {
         return _grid != null ? _grid.getFirstThumb() : null;
      }
      
      public function updateActionView() : void
      {
         var _loc4_:FurnitureItem = null;
         var _loc14_:IStaticBitmapWrapperWindow = null;
         var _loc18_:ITextWindow = null;
         var _loc16_:IRegionWindow = null;
         var _loc5_:String = null;
         var _loc10_:String = null;
         var _loc19_:String = null;
         var _loc8_:String = null;
         var _loc17_:String = null;
         var _loc3_:String = null;
         var _loc20_:String = null;
         var _loc12_:IFurnitureData = null;
         var _loc9_:int = 0;
         var _loc1_:IWidgetWindowController = null;
         var _loc11_:IWidgetWindowController = null;
         var _loc13_:String = null;
         if(UnknownVarFromFurniView_IWindowController_1_1 == null)
         {
            return;
         }
         if(UnknownVarFromFurniView_IWindowController_1_1.disposed)
         {
            return;
         }
         updateContainerVisibility();
         var _loc6_:Boolean = false;
         var _loc7_:GroupItem = UnknownVarFromFurniView_FurniModel_1.getSelectedItem();
         if(_loc7_ != null && _loc7_.peek() != null)
         {
            if(_loc7_.selectedItemIndex >= 0)
            {
               _loc4_ = _loc7_.getAt(_loc7_.selectedItemIndex);
               if(!_loc4_)
               {
                  _loc4_ = _loc7_.peek();
               }
            }
            else
            {
               _loc4_ = _loc7_.peek();
            }
            _loc6_ = true;
            _loc5_ = _roomEngine.getWallItemType(_loc4_.type);
            UnknownVarFromFurniView_IWindowController_1_1.findChildByName("nextItemButton").visible = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("viewItemButton").visible = _loc5_ && _loc5_.indexOf("external_image_wallitem") != -1;
            UnknownVarFromFurniView_IWindowController_1_1.findChildByName("furni_preview_widget").visible = true;
            _loc10_ = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_wall_type");
            _loc19_ = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_floor_type");
            _loc8_ = _roomEngine.getRoomStringValue(_roomEngine.activeRoomId,"room_landscape_type");
            _loc10_ = _loc10_ && _loc10_.length > 0 ? _loc10_ : "101";
            _loc19_ = _loc19_ && _loc19_.length > 0 ? _loc19_ : "101";
            _loc8_ = _loc8_ && _loc8_.length > 0 ? _loc8_ : "1.1";
            UnknownVarFromFurniView_RoomPreviewer_1.reset(false);
            UnknownVarFromFurniView_RoomPreviewer_1.updateObjectRoom(_loc19_,_loc10_,_loc8_);
            if(_loc4_.category == 2 || _loc4_.category == 3 || _loc4_.category == 4)
            {
               UnknownVarFromFurniView_RoomPreviewer_1.updateRoomWallsAndFloorVisibility(true,true);
               _loc17_ = _loc4_.category == 3 ? _loc7_.stuffData.getLegacyString() : _loc19_;
               _loc3_ = _loc4_.category == 2 ? _loc7_.stuffData.getLegacyString() : _loc10_;
               _loc20_ = _loc4_.category == 4 ? _loc7_.stuffData.getLegacyString() : _loc8_;
               UnknownVarFromFurniView_RoomPreviewer_1.updateObjectRoom(_loc17_,_loc3_,_loc20_);
               if(_loc4_.category == 4)
               {
                  _loc12_ = UnknownVarFromFurniView_FurniModel_1.controller.getFurnitureDataByName("ads_twi_windw","i");
                  UnknownVarFromFurniView_RoomPreviewer_1.addWallItemIntoRoom(_loc12_.id,new Vector3d(90,0,0),_loc12_.customParams);
               }
            }
            else if(_loc7_.isWallItem)
            {
               UnknownVarFromFurniView_RoomPreviewer_1.updateRoomWallsAndFloorVisibility(true,true);
               UnknownVarFromFurniView_RoomPreviewer_1.addWallItemIntoRoom(_loc7_.type,new Vector3d(90,0,0),_loc4_.stuffData.getLegacyString());
            }
            else
            {
               UnknownVarFromFurniView_RoomPreviewer_1.updateRoomWallsAndFloorVisibility(false,true);
               UnknownVarFromFurniView_RoomPreviewer_1.addFurnitureIntoRoom(_loc7_.type,new Vector3d(90,0,0),_loc7_.stuffData,_loc7_.extra.toString());
            }
            _loc14_ = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("tradeable_icon") as IStaticBitmapWrapperWindow;
            _loc18_ = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("tradeable_number") as ITextWindow;
            _loc16_ = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("tradeable_info_region") as IRegionWindow;
            if(_loc14_ != null && _loc18_ != null && _loc16_ != null)
            {
               _loc9_ = _loc7_.getTradeableCount();
               if(_loc9_ == 0)
               {
                  _loc14_.assetUri = "inventory_furni_no_trade_icon";
                  _loc18_.visible = false;
                  _loc16_.toolTipCaption = "${inventory.furni.preview.not_tradeable}";
                  _loc18_.filters = [];
               }
               else
               {
                  _loc14_.assetUri = "inventory_furni_trade_icon";
                  _loc18_.visible = true;
                  _loc18_.text = String(_loc9_);
                  _loc16_.toolTipCaption = "${inventory.furni.preview.tradeable_amount}";
                  _loc18_.filters = [new GlowFilter(16777215,1,3,3,300)];
               }
            }
            _loc14_ = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("recyclable_icon") as IStaticBitmapWrapperWindow;
            _loc18_ = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("recyclable_number") as ITextWindow;
            _loc16_ = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("recyclable_info_region") as IRegionWindow;
            if(_loc14_ != null && _loc18_ != null && _loc16_ != null)
            {
               _loc9_ = _loc7_.getRecyclableCount();
               if(_loc9_ == 0)
               {
                  _loc14_.assetUri = "inventory_furni_no_recycle_icon";
                  _loc18_.visible = false;
                  _loc16_.toolTipCaption = "${inventory.furni.preview.not_recyclable}";
                  _loc18_.filters = [];
               }
               else
               {
                  _loc14_.assetUri = "inventory_furni_recycle_icon";
                  _loc18_.visible = true;
                  _loc18_.text = String(_loc9_);
                  _loc16_.toolTipCaption = "${inventory.furni.preview.recyclable_amount}";
                  _loc18_.filters = [new GlowFilter(16777215,1,3,3,300)];
               }
            }
            _loc1_ = IWidgetWindowController(UnknownVarFromFurniView_IWindowController_1_1.findChildByName("unique_limited_item_overlay_widget"));
            if(_loc4_.stuffData && _loc4_.stuffData.uniqueSerialNumber > 0)
            {
               if(UnknownVarFromFurniView_ILimitedItemPreviewOverlayWidget_1 == null)
               {
                  UnknownVarFromFurniView_ILimitedItemPreviewOverlayWidget_1 = ILimitedItemPreviewOverlayWidget(_loc1_.widget);
               }
               UnknownVarFromFurniView_ILimitedItemPreviewOverlayWidget_1.serialNumber = _loc4_.stuffData.uniqueSerialNumber;
               UnknownVarFromFurniView_ILimitedItemPreviewOverlayWidget_1.seriesSize = _loc4_.stuffData.uniqueSeriesSize;
               _loc1_.visible = true;
            }
            else
            {
               _loc1_.visible = false;
            }
            _loc11_ = IWidgetWindowController(UnknownVarFromFurniView_IWindowController_1_1.findChildByName("rarity_item_overlay_widget"));
            if(_loc4_.stuffData && _loc4_.stuffData.rarityLevel >= 0)
            {
               if(UnknownVarFromFurniView_IRarityItemPreviewOverlayWidget_1 == null)
               {
                  UnknownVarFromFurniView_IRarityItemPreviewOverlayWidget_1 = IRarityItemPreviewOverlayWidget(_loc11_.widget);
               }
               UnknownVarFromFurniView_IRarityItemPreviewOverlayWidget_1.rarityLevel = _loc4_.stuffData.rarityLevel;
               _loc11_.visible = true;
            }
            else
            {
               _loc11_.visible = false;
            }
         }
         else
         {
            UnknownVarFromFurniView_IWindowController_1_1.findChildByName("furni_preview_widget").visible = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("nextItemButton").visible = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("viewItemButton").visible = false;
            _loc14_ = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("tradeable_icon") as IStaticBitmapWrapperWindow;
            _loc18_ = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("tradeable_number") as ITextWindow;
            _loc16_ = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("tradeable_info_region") as IRegionWindow;
            if(_loc14_ && _loc18_ && _loc16_)
            {
               _loc14_.assetUri = "";
               _loc18_.visible = false;
            }
            _loc14_ = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("recyclable_icon") as IStaticBitmapWrapperWindow;
            _loc18_ = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("recyclable_number") as ITextWindow;
            _loc16_ = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("recyclable_info_region") as IRegionWindow;
            if(_loc14_ && _loc18_ && _loc16_)
            {
               _loc14_.assetUri = "";
               _loc18_.visible = false;
            }
         }
         var _loc2_:Boolean = UnknownVarFromFurniView_FurniModel_1.isTradingOpen;
         updateActionButtons(_loc6_);
         if(_loc7_ && _loc4_)
         {
            UnknownVarFromFurniView_IWindowController_1_1.findChildByName("furni_name").caption = _loc7_.name;
            if(_loc4_ && _roomEngine.getWallItemType(_loc4_.type) == "external_image_wallitem")
            {
               UnknownVarFromFurniView_IWindowController_1_1.findChildByName("furni_description").caption = _loc4_.stuffData.getJSONValue("m");
            }
            else
            {
               UnknownVarFromFurniView_IWindowController_1_1.findChildByName("furni_description").caption = _loc7_.description;
            }
         }
         else
         {
            UnknownVarFromFurniView_IWindowController_1_1.findChildByName("furni_name").caption = "";
            UnknownVarFromFurniView_IWindowController_1_1.findChildByName("furni_description").caption = "";
         }
         var _loc15_:ITextWindow = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("furni_extra") as ITextWindow;
         if(_loc15_ != null)
         {
            if(_loc4_ != null && _loc4_.stuffData != null)
            {
               if(_loc4_.stuffData.rarityLevel >= 0)
               {
                  _loc13_ = (_loc4_.stuffData as MapStuffData).getValue("rarity");
                  if(_loc13_ != null)
                  {
                     _windowManager.registerLocalizationParameter("inventory.rarity","rarity",String(_loc4_.stuffData.rarityLevel));
                     _loc15_.text = UnknownVarFromFurniView_FurniModel_1.localization.getLocalization("inventory.rarity");
                     _loc15_.visible = true;
                  }
               }
               else if(_loc4_.stuffData.chestName != "")
               {
                  _loc15_.text = UnknownVarFromFurniView_FurniModel_1.localization.getLocalizationWithParams("inventory.chest_name","","chest_name",_loc4_.stuffData.chestName);
                  _loc15_.visible = true;
               }
               else
               {
                  _loc15_.text = "";
                  _loc15_.visible = false;
               }
            }
            else
            {
               _loc15_.text = "";
               _loc15_.visible = false;
            }
         }
         updateRentedItem();
      }
      
      public function displayItemInfo(param1:GroupItem) : void
      {
         if(UnknownVarFromFurniView_IWindowController_1_1 == null)
         {
            return;
         }
         if(UnknownVarFromFurniView_IWindowController_1_1.disposed)
         {
            return;
         }
         var _loc2_:FurnitureItem = param1.peek();
         if(_loc2_.isWallItem)
         {
            UnknownVarFromFurniView_RoomPreviewer_1.addWallItemIntoRoom(_loc2_.type,new Vector3d(90,0,0),_loc2_.stuffData.getLegacyString());
         }
         else
         {
            UnknownVarFromFurniView_RoomPreviewer_1.addFurnitureIntoRoom(_loc2_.type,new Vector3d(90,0,0),_loc2_.stuffData);
         }
         UnknownVarFromFurniView_UnknownICoreWindowComponents4_1.disable();
         _offerInTradingButton.disable();
         _offerInTradingCountButton.disable();
      }
      
      public function addItems(param1:Vector.<GroupItem>) : void
      {
         if(_grid)
         {
            _grid.setItems(param1);
         }
      }
      
      public function updateGridFilters() : void
      {
         if(UnknownVarFromFurniView_IWindowController_1_1 == null || Boolean(UnknownVarFromFurniView_IWindowController_1_1.disposed))
         {
            return;
         }
         if(UnknownVarFromFurniView_FurniModel_1.controller.getSubCategoryViewId() == "wired_trading" && UnknownVarFromFurniView_FurniModel_1.controller.wiredTradingModel != null && UnknownVarFromFurniView_FurniModel_1.controller.wiredTradingModel.running)
         {
            updateGridFiltersWired();
         }
         else
         {
            updateGridFiltersNormal();
         }
      }
      
      private function updateGridFiltersNormal() : void
      {
         var _loc5_:IDropBaseController_1 = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("filter.options") as IDropBaseController_1;
         var _loc3_:IDropBaseController_1 = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("placement.options") as IDropBaseController_1;
         var _loc4_:String = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("filter").caption;
         var _loc2_:String = getSelectedFilterId(_loc5_,MAIN_FILTER_IDS);
         var _loc1_:String = getSelectedFilterId(_loc3_,getTypeFilterIds(_loc2_));
         UnknownVarFromFurniView_String_2 = _loc2_;
         UnknownVarFromFurniView_String_3 = _loc1_;
         _grid.setFilter(_loc2_,_loc1_,UnknownVarFromFurniView_FurniModel_1.showingRentedFurni,UnknownVarFromFurniView_FurniModel_1.controller.mergeRentFurni,_loc4_,UnknownVarFromFurniView_FurniModel_1.showingNfts);
      }
      
      private function updateGridFiltersWired() : void
      {
         var _loc4_:WiredTradeRequirementsModel = UnknownVarFromFurniView_FurniModel_1.controller.wiredTradingModel.tradeRequirementsModel;
         var _loc6_:IDropBaseController_1 = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("filter.options") as IDropBaseController_1;
         var _loc3_:IDropBaseController_1 = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("placement.options") as IDropBaseController_1;
         var _loc5_:String = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("filter").caption;
         var _loc2_:String = getSelectedFilterId(_loc6_,MAIN_FILTER_IDS);
         var _loc1_:String = getSelectedFilterId(_loc3_,getTypeFilterIds(_loc2_));
         UnknownVarFromFurniView_String_2 = _loc2_;
         UnknownVarFromFurniView_String_3 = _loc1_;
         _grid.setFilterByWired(_loc2_,_loc1_,_loc5_,_loc4_);
      }
      
      public function resetFilters(param1:String) : void
      {
         var _loc2_:IDropBaseController_1 = null;
         if(UnknownVarFromFurniView_String_1 != param1)
         {
            _loc2_ = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("filter.options") as IDropBaseController_1;
            _loc2_.selection = 0;
            populateTypeFilterOptions("all","any");
            UnknownVarFromFurniView_IWindowController_1_1.findChildByName("filter").caption = "";
            UnknownVarFromFurniView_IWindowController_1_1.findChildByName("clear_filter_button").visible = false;
         }
         UnknownVarFromFurniView_String_1 = param1;
         updateGridFilters();
      }
      
      private function init() : void
      {
         UnknownVarFromFurniView_IWindowController_1_1 = UnknownVarFromFurniView_FurniModel_1.controller.view.getView("furni");
         UnknownVarFromFurniView_IWindowController_1_1.enableLookupCache();
         UnknownVarFromFurniView_IWindowController_1_1.visible = false;
         UnknownVarFromFurniView_IWindowController_1_1.procedure = windowEventProc;
         var _loc1_:IItemGridWindow = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("item_grid") as IItemGridWindow;
         var _loc3_:IItemListWindow = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("item_grid_pages") as IItemListWindow;
         _grid = new FurniGridView(_loc1_,_loc3_);
         populateFilterOptions();
         UnknownVarFromFurniView_IItemListWindow_1 = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("preview_element_list") as IItemListWindow;
         UnknownVarFromFurniView_UnknownICoreWindowComponents4_1 = UnknownVarFromFurniView_IItemListWindow_1.removeListItem(UnknownVarFromFurniView_IItemListWindow_1.getListItemByName("placeinroom_btn")) as UnknownICoreWindowComponents4;
         UnknownVarFromFurniView_UnknownICoreWindowComponents4_5 = UnknownVarFromFurniView_IItemListWindow_1.removeListItem(UnknownVarFromFurniView_IItemListWindow_1.getListItemByName("extendrent_btn")) as UnknownICoreWindowComponents4;
         UnknownVarFromFurniView_UnknownICoreWindowComponents4_6 = UnknownVarFromFurniView_IItemListWindow_1.removeListItem(UnknownVarFromFurniView_IItemListWindow_1.getListItemByName("buyrenteditem_btn")) as UnknownICoreWindowComponents4;
         UnknownVarFromFurniView_UnknownICoreWindowComponents4_2 = UnknownVarFromFurniView_IItemListWindow_1.removeListItem(UnknownVarFromFurniView_IItemListWindow_1.getListItemByName("goto_room_btn")) as UnknownICoreWindowComponents4;
         UnknownVarFromFurniView_UnknownICoreWindowComponents4_4 = UnknownVarFromFurniView_IItemListWindow_1.removeListItem(UnknownVarFromFurniView_IItemListWindow_1.getListItemByName("use_btn")) as UnknownICoreWindowComponents4;
         _offerInTradingCountButton = UnknownVarFromFurniView_IItemListWindow_1.removeListItem(UnknownVarFromFurniView_IItemListWindow_1.getListItemByName("offertotrade_cnt")) as ITextFieldWindow;
         _offerInTradingButton = UnknownVarFromFurniView_IItemListWindow_1.removeListItem(UnknownVarFromFurniView_IItemListWindow_1.getListItemByName("offertotrade_btn")) as UnknownICoreWindowComponents4;
         UnknownVarFromFurniView_UnknownICoreWindowComponents4_3 = UnknownVarFromFurniView_IItemListWindow_1.removeListItem(UnknownVarFromFurniView_IItemListWindow_1.getListItemByName("sell_btn")) as UnknownICoreWindowComponents4;
         var _loc2_:IRoomPreviewerWidget = (UnknownVarFromFurniView_IWindowController_1_1.findChildByName("furni_preview_widget") as IWidgetWindowController).widget as IRoomPreviewerWidget;
         UnknownVarFromFurniView_RoomPreviewer_1 = _loc2_.roomPreviewer;
         UnknownVarFromFurniView_FurniModel_1.controller.registerUpdateReceiver(this,1);
         setViewToState();
         _isInitialized = true;
      }
      
      private function fixPreviewHeightInTrading() : void
      {
         var _loc1_:IWidgetWindowController = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("furni_preview_widget") as IWidgetWindowController;
         var _loc2_:IRoomPreviewerWidget = (UnknownVarFromFurniView_IWindowController_1_1.findChildByName("furni_preview_widget") as IWidgetWindowController).widget as IRoomPreviewerWidget;
         _loc2_.roomPreviewer.modifyRoomCanvas(_loc1_.width,_loc1_.height);
      }
      
      private function updateActionButtons(param1:Boolean) : void
      {
         if(UnknownVarFromFurniView_FurniModel_1.isTradingOpen)
         {
            fixPreviewHeightInTrading();
         }
         removeButtons();
         var _loc2_:Boolean = UnknownVarFromFurniView_FurniModel_1.isTradingOpen;
         var _loc6_:GroupItem = UnknownVarFromFurniView_FurniModel_1.getSelectedItem();
         var _loc3_:FurnitureItem = null;
         if(_loc6_)
         {
            _loc3_ = _loc6_.peek();
         }
         if(_loc3_ == null)
         {
            return;
         }
         var _loc10_:IFurnitureData = UnknownVarFromFurniView_FurniModel_1.controller.getFurnitureData(_loc3_.type,_loc3_.isWallItem ? "i" : "s");
         var _loc9_:Boolean = param1 && _marketplace && _marketplace.isEnabled && _loc3_.sellable && !UnknownVarFromFurniView_FurniModel_1.controller.sessionData.isAccountSafetyLocked() && !_loc2_;
         var _loc5_:Boolean = UnknownVarFromFurniView_FurniModel_1.isPrivateRoom && param1 && (_loc3_.category == 16 || _loc3_.category == 14 || _loc3_.category == 15 || _loc3_.category == 13 || _loc3_.category == 20);
         var _loc4_:Boolean = true;
         if(_loc3_.isRented)
         {
            if(_loc3_.flatId > -1)
            {
               _loc4_ = false;
            }
         }
         var _loc11_:* = _loc3_.flatId > -1;
         var _loc7_:Boolean = _loc3_.isRented && _loc4_ && _loc10_ && _loc10_.rentCouldBeUsedForBuyout;
         var _loc8_:Boolean = _loc3_.isRented && _loc4_ && _loc10_ && _loc10_.purchaseCouldBeUsedForBuyout;
         if(_loc10_ && _loc10_.isExternalImageType)
         {
            _loc9_ = false;
         }
         updateButtonAvailability(UnknownVarFromFurniView_UnknownICoreWindowComponents4_1,!_loc2_ && _loc4_);
         updateButtonAvailability(UnknownVarFromFurniView_UnknownICoreWindowComponents4_5,!_loc2_ && _loc7_);
         updateButtonAvailability(UnknownVarFromFurniView_UnknownICoreWindowComponents4_6,!_loc2_ && _loc8_);
         updateButtonAvailability(UnknownVarFromFurniView_UnknownICoreWindowComponents4_2,!_loc2_ && _loc11_);
         updateButtonAvailability(_offerInTradingCountButton,_loc2_ && UnknownVarFromFurniView_FurniModel_1.controller.getBoolean("multi.item.trading.enabled"));
         updateButtonAvailability(_offerInTradingButton,_loc2_);
         updateButtonAvailability(UnknownVarFromFurniView_UnknownICoreWindowComponents4_3,_loc9_);
         updateButtonAvailability(UnknownVarFromFurniView_UnknownICoreWindowComponents4_4,_loc5_);
         if(param1 && UnknownVarFromFurniView_FurniModel_1.isPrivateRoom)
         {
            UnknownVarFromFurniView_UnknownICoreWindowComponents4_1.enable();
         }
         else
         {
            UnknownVarFromFurniView_UnknownICoreWindowComponents4_1.disable();
         }
         if(param1 && _loc6_ != null && _loc3_ != null && UnknownVarFromFurniView_FurniModel_1.canUserOfferToTrade())
         {
            if(_loc6_.getUnlockedCount() && _loc3_.tradeable)
            {
               _offerInTradingButton.enable();
               _offerInTradingCountButton.enable();
            }
            else
            {
               _offerInTradingButton.disable();
               _offerInTradingCountButton.disable();
            }
         }
         else
         {
            _offerInTradingButton.disable();
            _offerInTradingCountButton.disable();
         }
      }
      
      private function updateButtonAvailability(param1:IInteractiveWindow, param2:Boolean) : void
      {
         if(UnknownVarFromFurniView_IItemListWindow_1.getListItemByName(param1.name) == null)
         {
            if(param2)
            {
               UnknownVarFromFurniView_IItemListWindow_1.addListItem(param1);
            }
         }
         else if(!param2)
         {
            UnknownVarFromFurniView_IItemListWindow_1.removeListItem(param1);
         }
      }
      
      private function removeButtons() : void
      {
         UnknownVarFromFurniView_IItemListWindow_1.removeListItem(UnknownVarFromFurniView_UnknownICoreWindowComponents4_1);
         UnknownVarFromFurniView_IItemListWindow_1.removeListItem(UnknownVarFromFurniView_UnknownICoreWindowComponents4_5);
         UnknownVarFromFurniView_IItemListWindow_1.removeListItem(UnknownVarFromFurniView_UnknownICoreWindowComponents4_6);
         UnknownVarFromFurniView_IItemListWindow_1.removeListItem(UnknownVarFromFurniView_UnknownICoreWindowComponents4_2);
         UnknownVarFromFurniView_IItemListWindow_1.removeListItem(UnknownVarFromFurniView_UnknownICoreWindowComponents4_4);
         UnknownVarFromFurniView_IItemListWindow_1.removeListItem(_offerInTradingCountButton);
         UnknownVarFromFurniView_IItemListWindow_1.removeListItem(_offerInTradingButton);
         UnknownVarFromFurniView_IItemListWindow_1.removeListItem(UnknownVarFromFurniView_UnknownICoreWindowComponents4_3);
      }
      
      private function updateContainerVisibility() : void
      {
         if(!_isInitialized)
         {
            return;
         }
         if(UnknownVarFromFurniView_FurniModel_1.controller.currentCategoryId != "furni" && UnknownVarFromFurniView_FurniModel_1.controller.currentCategoryId != "rentables")
         {
            return;
         }
         var _loc1_:IWindowController_1 = UnknownVarFromFurniView_FurniModel_1.controller.view.loadingContainer;
         var _loc4_:IWindowController_1 = UnknownVarFromFurniView_FurniModel_1.controller.view.emptyContainer;
         var _loc5_:IWindowController_1 = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("grid_container") as IWindowController_1;
         var _loc2_:IWindowController_1 = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("preview_container") as IWindowController_1;
         var _loc3_:IWindowController_1 = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("options_container") as IWindowController_1;
         switch(UnknownVarFromFurniView_Int_1 - 1)
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
               _loc2_.visible = false;
               _loc3_.visible = false;
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
               _loc2_.visible = false;
               _loc3_.visible = false;
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
               _loc2_.visible = true;
               _loc3_.visible = true;
         }
      }
      
      private function showNextPreviewItem() : void
      {
         UnknownVarFromFurniView_FurniModel_1.getSelectedItem().selectedItemIndex++;
         updateActionView();
      }
      
      private function windowEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc4_:GroupItem = null;
         var _loc5_:FurnitureItem = null;
         var _loc7_:int = 0;
         var _loc8_:GroupItem = null;
         var _loc3_:IFurnitureItem = null;
         var _loc6_:WindowKeyboardEvent = null;
         var _loc9_:String = null;
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "placeinroom_btn":
               case "furni_preview_region":
                  if(!UnknownVarFromFurniView_FurniModel_1.isTradingOpen)
                  {
                     UnknownVarFromFurniView_FurniModel_1.requestSelectedFurniPlacement(false);
                  }
                  break;
               case "nextItemButton":
                  showNextPreviewItem();
                  break;
               case "viewItemButton":
                  _loc4_ = UnknownVarFromFurniView_FurniModel_1.getSelectedItem();
                  _loc5_ = _loc4_.getAt(_loc4_.selectedItemIndex);
                  if(!_loc5_)
                  {
                     _loc5_ = _loc4_.peek();
                  }
                  _roomEngine.showUseProductSelection(_loc5_.ref,_loc5_.type,_loc5_.id);
                  break;
               case "goto_room_btn":
                  UnknownVarFromFurniView_FurniModel_1.gotoRoom();
                  break;
               case "offertotrade_btn":
                  _loc7_ = Math.max(1,int(_offerInTradingCountButton.caption));
                  if(_loc7_ != int(_offerInTradingCountButton.caption))
                  {
                     _offerInTradingCountButton.caption = String(_loc7_);
                  }
                  UnknownVarFromFurniView_FurniModel_1.requestSelectedFurniToTrading(_loc7_,_offerInTradingCountButton);
                  break;
               case "sell_btn":
                  UnknownVarFromFurniView_FurniModel_1.requestSelectedFurniSelling();
                  break;
               case "use_btn":
                  UnknownVarFromFurniView_FurniModel_1.showUseProductSelection();
                  break;
               case "extendrent_btn":
                  UnknownVarFromFurniView_FurniModel_1.extendRentPeriod();
                  break;
               case "buyrenteditem_btn":
                  UnknownVarFromFurniView_FurniModel_1.buyRentedItem();
                  break;
               case "clear_filter_button":
                  UnknownVarFromFurniView_IWindowController_1_1.findChildByName("filter").caption = "";
                  param2.visible = false;
                  updateGridFilters();
                  break;
               default:
                  UnknownVarFromFurniView_FurniModel_1.cancelFurniInMover();
            }
         }
         else if(param1.type == "WME_DOWN")
         {
            var _loc10_:* = param2.name;
            if("furni_preview_region" === _loc10_)
            {
               _loc8_ = UnknownVarFromFurniView_FurniModel_1.getSelectedItem();
               if(_loc8_ == null)
               {
                  return;
               }
               _loc3_ = _loc8_.peek();
               if(_loc3_.category == 2 || _loc3_.category == 3 || _loc3_.category == 4)
               {
                  return;
               }
               if(!UnknownVarFromFurniView_FurniModel_1.isTradingOpen)
               {
                  UnknownVarFromFurniView_FurniModel_1.requestSelectedFurniPlacement(false);
               }
            }
         }
         else if(param1.type == "WKE_KEY_UP")
         {
            _loc6_ = param1 as WindowKeyboardEvent;
            _loc10_ = param2.name;
            if("filter" === _loc10_)
            {
               UnknownVarFromFurniView_IWindowController_1_1.findChildByName("clear_filter_button").visible = param2.caption.length > 0;
               if(_loc6_.keyCode == 27)
               {
                  param2.caption = "";
                  UnknownVarFromFurniView_IWindowController_1_1.findChildByName("clear_filter_button").visible = false;
                  updateGridFilters();
               }
               else if(_loc6_.keyCode == 13)
               {
                  updateGridFilters();
               }
            }
         }
         if(param1.type == "WE_SELECTED")
         {
            switch(param2.name)
            {
               case "filter.options":
                  _loc9_ = getSelectedFilterId(param2 as IDropBaseController_1,MAIN_FILTER_IDS);
                  populateTypeFilterOptions(_loc9_,getPreservedTypeFilter(_loc9_));
                  updateGridFilters();
                  break;
               case "placement.options":
                  updateGridFilters();
            }
         }
      }
      
      public function resetFilterOption() : void
      {
         var _loc1_:IDropBaseController_1 = null;
         if(UnknownVarFromFurniView_IWindowController_1_1)
         {
            _loc1_ = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("filter.options") as IDropBaseController_1;
            _loc1_.selection = 0;
            populateTypeFilterOptions("all","any");
            updateGridFilters();
         }
      }
      
      private function populateFilterOptions() : void
      {
         var _loc3_:IDropBaseController_1 = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("filter.options") as IDropBaseController_1;
         var _loc1_:Array = [];
         for each(var _loc2_ in MAIN_FILTER_IDS)
         {
            _loc1_.push(getMainFilterLabel(_loc2_));
         }
         _loc3_.populate(_loc1_);
         _loc3_.selection = 0;
         populateTypeFilterOptions("all","any");
         UnknownVarFromFurniView_IWindowController_1_1.findChildByName("filter").caption = "";
         UnknownVarFromFurniView_IWindowController_1_1.findChildByName("items.shown").visible = false;
         UnknownVarFromFurniView_IWindowController_1_1.invalidate();
      }
      
      private function populateTypeFilterOptions(param1:String, param2:String) : void
      {
         var _loc6_:IDropBaseController_1 = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("placement.options") as IDropBaseController_1;
         var _loc3_:Array = getTypeFilterIds(param1);
         var _loc5_:Array = [];
         for each(var _loc4_ in _loc3_)
         {
            _loc5_.push(getTypeFilterLabel(_loc4_));
         }
         _loc6_.populate(_loc5_);
         _loc6_.selection = findFilterIndex(_loc3_,param2);
      }
      
      private function getPreservedTypeFilter(param1:String) : String
      {
         return findFilterIndex(getTypeFilterIds(param1),UnknownVarFromFurniView_String_3) >= 0 ? UnknownVarFromFurniView_String_3 : "any";
      }
      
      private function getTypeFilterIds(param1:String) : Array
      {
         switch(param1)
         {
            case "all":
            case "floor_items":
               break;
            case "wall_items":
               return ["any","windows","dimmers","stickies","paintings","collectibles","tradable","non_tradable","recyclable"];
            case "room_layout":
               return ["any","floors","wallpapers","landscape"];
            default:
               return ["any"];
         }
         return ["any","sittable","layable","tiles_or_rugs","ltd","wired","credit_furni","clothes","pet_food","collectibles","tradable","non_tradable","recyclable"];
      }
      
      private function getSelectedFilterId(param1:IDropBaseController_1, param2:Array) : String
      {
         if(param2 == null || param2.length == 0)
         {
            return "";
         }
         var _loc3_:int = int(param1 != null ? param1.selection : 0);
         if(_loc3_ < 0 || _loc3_ >= param2.length)
         {
            _loc3_ = 0;
         }
         return String(param2[_loc3_]);
      }
      
      private function findFilterIndex(param1:Array, param2:String) : int
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_] == param2)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return 0;
      }
      
      private function getMainFilterLabel(param1:String) : String
      {
         return UnknownVarFromFurniView_FurniModel_1.controller.localization.getLocalization("inventory.furni.filter.main." + param1);
      }
      
      private function getTypeFilterLabel(param1:String) : String
      {
         return UnknownVarFromFurniView_FurniModel_1.controller.localization.getLocalization("inventory.furni.filter.type." + param1);
      }
      
      public function updateRentedItem() : void
      {
         if(UnknownVarFromFurniView_FurniModel_1 == null)
         {
            return;
         }
         var _loc2_:GroupItem = UnknownVarFromFurniView_FurniModel_1.getSelectedItem();
         var _loc1_:FurnitureItem = null;
         if(_loc2_)
         {
            _loc1_ = _loc2_.peek();
         }
         if(_loc1_ == null)
         {
            return;
         }
         if(!_loc1_.isRented)
         {
            return;
         }
         var _loc3_:IWindowModel = UnknownVarFromFurniView_IWindowController_1_1.findChildByName("furni_extra") as ITextWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.visible = true;
         if(_loc1_.hasRentPeriodStarted)
         {
            UnknownVarFromFurniView_FurniModel_1.controller.localization.registerParameter("inventory.rent.expiration","time",FriendlyTime.getFriendlyTime(UnknownVarFromFurniView_FurniModel_1.controller.localization,_loc1_.secondsToExpiration));
            _loc3_.caption = UnknownVarFromFurniView_FurniModel_1.controller.localization.getLocalization("inventory.rent.expiration");
         }
         else
         {
            UnknownVarFromFurniView_FurniModel_1.controller.localization.registerParameter("inventory.rent.inactive","time",FriendlyTime.getFriendlyTime(UnknownVarFromFurniView_FurniModel_1.controller.localization,_loc1_.secondsToExpiration));
            _loc3_.caption = UnknownVarFromFurniView_FurniModel_1.controller.localization.getLocalization("inventory.rent.inactive");
         }
      }
      
      public function update(param1:uint) : void
      {
         if(UnknownVarFromFurniView_RoomPreviewer_1 != null)
         {
            UnknownVarFromFurniView_RoomPreviewer_1.updatePreviewRoomView();
         }
      }
   }
}

