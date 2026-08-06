package com.sulake.habbo.roomevents.wired_trading.chests.subcontrollers.views
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IScrollableGridWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage.ChestItemType;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage.ChestStorage;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage.IChestStorage;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_trading.chests.subcontrollers.FurniChestSubController;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.window.widgets.ProductImageWidget;
   import flash.utils.Dictionary;
   
   public class FurniChestView implements IComponentInterfaceQueue
   {
      private static const GRID_OFFSET_SEARCH:int = 28;
      
      private static const UnknownConstFromFurniChestView_Int_1:int = 31;
      
      private static var ITEM_POOL_MAX_SIZE:int = 1000;
      
      private static var ITEM_POOL:Vector.<FurniChestItemView> = new Vector.<FurniChestItemView>();
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromFurniChestView_FurniChestSubController_1:FurniChestSubController;
      
      private var _container:IWindowController_1;
      
      private var _itemTemplate:IRegionWindow;
      
      private var UnknownVarFromFurniChestView_Map_1:Map;
      
      private var UnknownVarFromFurniChestView_Map_2:Map;
      
      private var UnknownVarFromFurniChestView_FurniChestItemView_1:FurniChestItemView;
      
      private var UnknownVarFromFurniChestView_Vector_1:Vector.<FurniChestItemView>;
      
      private var UnknownVarFromFurniChestView_Boolean_1:Boolean = false;
      
      private var UnknownVarFromFurniChestView_String_1:String = "";
      
      public function FurniChestView(param1:FurniChestSubController)
      {
         super();
         UnknownVarFromFurniChestView_FurniChestSubController_1 = param1;
         _container = roomEvents.getXmlWindow("furni_chest_contents") as IWindowController_1;
         _itemTemplate = itemGrid.removeGridItemAt(0) as IRegionWindow;
         UnknownVarFromFurniChestView_Map_1 = new Map();
         UnknownVarFromFurniChestView_Map_2 = new Map();
         UnknownVarFromFurniChestView_Vector_1 = new Vector.<FurniChestItemView>();
         withdrawInput.restrict = "0-9";
         withdrawButton.addEventListener("WME_CLICK",onWithdrawClick);
         viewLogsButton.addEventListener("WME_CLICK",onViewLogsClick);
         searchInput.addEventListener("WE_CHANGE",onSearchChanged);
         searchInput.addEventListener("WKE_KEY_DOWN",onSearchMaybeEnter);
         searchClearButton.addEventListener("WME_CLICK",onClearSearchClicked);
      }
      
      public static function findReusableGroupedView(param1:IChestStorage, param2:Map) : IFurniChestItemView
      {
         var _loc3_:int = 0;
         var _loc9_:IChestStorage = null;
         var _loc5_:ChestItemType = param1.type;
         var _loc6_:int = param1.specialType;
         var _loc8_:IStuffData = param1.stuffData;
         var _loc7_:Vector.<IFurniChestItemView> = param2.getValue(itemTypeKey(_loc5_));
         if(_loc7_ == null || _loc7_.length == 0)
         {
            return null;
         }
         if(_loc8_.uniqueSerialNumber > 0)
         {
            return null;
         }
         if(_loc6_ == 19)
         {
            _loc3_ = _loc8_.rarityLevel;
            for each(var _loc4_ in _loc7_)
            {
               _loc9_ = _loc4_.chestBasedItemSample;
               if(_loc9_ != null && _loc3_ == _loc9_.stuffData.rarityLevel)
               {
                  return _loc4_;
               }
            }
            return null;
         }
         return _loc7_[0];
      }
      
      public static function itemTypeKey(param1:ChestItemType) : String
      {
         return (param1.isWallItem ? "1" : "0") + "-" + param1.typeId + "-" + param1.legacyPosterId;
      }
      
      public static function getChestBasedItemName(param1:IChestStorage, param2:IHabboLocalizationManager, param3:ISessionDataManager) : String
      {
         var _loc5_:IFurnitureData = null;
         var _loc4_:ChestItemType = param1.type;
         if(param1.type.isWallItem)
         {
            if(param1.specialType == 6 && _loc4_.legacyPosterId != "")
            {
               return param2.getLocalization("poster_" + _loc4_.legacyPosterId + "_name");
            }
            _loc5_ = param3.getWallItemData(_loc4_.typeId);
         }
         else
         {
            _loc5_ = param3.getFloorItemData(_loc4_.typeId);
         }
         if(_loc5_ == null)
         {
            return "(missing item name)";
         }
         return _loc5_.localizedName;
      }
      
      private static function claimView(param1:IRegionWindow, param2:FurniChestView, param3:Vector.<ChestStorage>) : FurniChestItemView
      {
         var _loc4_:FurniChestItemView = null;
         if(ITEM_POOL.length > 0)
         {
            _loc4_ = ITEM_POOL.pop();
         }
         else
         {
            _loc4_ = new FurniChestItemView(param1);
         }
         _loc4_.initialize(param2,param3);
         return _loc4_;
      }
      
      private static function recycleView(param1:FurniChestItemView) : void
      {
         if(ITEM_POOL.length < ITEM_POOL_MAX_SIZE)
         {
            param1.recycle();
            ITEM_POOL.push(param1);
         }
         else
         {
            param1.dispose();
         }
      }
      
      private function onClearSearchClicked(param1:WindowMouseEvent) : void
      {
         clearSearch();
         updateGrid();
      }
      
      private function onSearchMaybeEnter(param1:WindowKeyboardEvent) : void
      {
         if(!searchInput.visible)
         {
            return;
         }
         if(param1.keyCode == 13)
         {
            if(UnknownVarFromFurniChestView_String_1 == searchInput.text)
            {
               return;
            }
            UnknownVarFromFurniChestView_String_1 = searchInput.text;
            updateGrid();
         }
         else if(param1.keyCode == 27)
         {
            if(UnknownVarFromFurniChestView_String_1.length == 0)
            {
               clearSearch();
               return;
            }
            clearSearch();
            updateGrid();
         }
      }
      
      private function onSearchChanged(param1:WindowEvent) : void
      {
         searchPlaceholder.visible = searchInput.text.length == 0;
         searchClearButton.visible = searchInput.text.length > 0;
      }
      
      private function onViewLogsClick(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromFurniChestView_FurniChestItemView_1 != null && UnknownVarFromFurniChestView_FurniChestItemView_1.peek() != null)
         {
            UnknownVarFromFurniChestView_FurniChestSubController_1.viewLogsWithType(UnknownVarFromFurniChestView_FurniChestItemView_1.peek().type);
         }
      }
      
      private function onWithdrawClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:Number = parseInt(withdrawInput.text);
         if(isNaN(_loc2_))
         {
            return;
         }
         if(UnknownVarFromFurniChestView_FurniChestItemView_1 != null && UnknownVarFromFurniChestView_FurniChestItemView_1.peek() != null)
         {
            UnknownVarFromFurniChestView_FurniChestSubController_1.withdrawItemsWithType(UnknownVarFromFurniChestView_FurniChestItemView_1.peek().type,int(_loc2_));
         }
      }
      
      public function get itemTemplate() : IRegionWindow
      {
         return _itemTemplate;
      }
      
      private function get roomEvents() : HabboUserDefinedRoomEvents
      {
         return UnknownVarFromFurniChestView_FurniChestSubController_1.roomEvents;
      }
      
      public function get container() : IWindowController_1
      {
         return _container;
      }
      
      public function itemsUpdated(param1:Vector.<ChestStorage>, param2:Vector.<ChestStorage>) : void
      {
         var _loc4_:FurniChestItemView = null;
         var _loc6_:* = undefined;
         var _loc8_:Dictionary = new Dictionary();
         var _loc11_:Boolean = false;
         var _loc7_:Vector.<FurniChestItemView> = new Vector.<FurniChestItemView>();
         for each(var _loc3_ in param1)
         {
            _loc4_ = removeStorage(_loc3_);
            if(_loc4_ != null)
            {
               _loc8_[_loc4_] = true;
               _loc11_ = true;
               if(_loc4_ == UnknownVarFromFurniChestView_FurniChestItemView_1)
               {
                  selectItemView(null);
               }
            }
         }
         for each(var _loc9_ in param2)
         {
            _loc4_ = addStorage(_loc9_);
            if(_loc4_ != null)
            {
               _loc7_.push(_loc4_);
            }
         }
         if(_loc11_ || _loc7_.length > 0)
         {
            _loc6_ = new Vector.<FurniChestItemView>();
            for each(var _loc10_ in UnknownVarFromFurniChestView_Vector_1)
            {
               if(!(_loc10_ in _loc8_))
               {
                  _loc6_.push(_loc10_);
               }
            }
            for each(var _loc5_ in _loc7_)
            {
               _loc6_.push(_loc5_);
            }
            UnknownVarFromFurniChestView_Vector_1 = _loc6_;
            updateGrid();
            maybeSelectNewItemView();
         }
         UnknownVarFromFurniChestView_FurniChestSubController_1.wrapperView.updateUI();
      }
      
      public function itemsInitialize(param1:Vector.<ChestStorage>) : void
      {
         var _loc2_:FurniChestItemView = null;
         clearSearch();
         clear();
         var _loc4_:Vector.<FurniChestItemView> = new Vector.<FurniChestItemView>();
         for each(var _loc3_ in param1)
         {
            _loc2_ = addStorage(_loc3_);
            if(_loc2_ != null)
            {
               _loc4_.push(_loc2_);
            }
         }
         UnknownVarFromFurniChestView_Vector_1 = _loc4_;
         updateGrid();
         maybeSelectNewItemView();
      }
      
      private function addStorage(param1:ChestStorage) : FurniChestItemView
      {
         var _loc3_:FurniChestItemView = findReusableGroupedView(param1,UnknownVarFromFurniChestView_Map_1) as FurniChestItemView;
         if(_loc3_ != null)
         {
            _loc3_.add(param1);
            UnknownVarFromFurniChestView_Map_2.add(param1,_loc3_);
            return null;
         }
         var _loc2_:Vector.<ChestStorage> = new Vector.<ChestStorage>();
         _loc2_.push(param1);
         var _loc6_:FurniChestItemView = claimView(itemTemplate,this,_loc2_);
         UnknownVarFromFurniChestView_Map_2.add(param1,_loc6_);
         var _loc4_:String = itemTypeKey(param1.type);
         var _loc5_:Vector.<FurniChestItemView> = UnknownVarFromFurniChestView_Map_1.getValue(_loc4_);
         if(_loc5_ == null)
         {
            _loc5_ = new Vector.<FurniChestItemView>();
            UnknownVarFromFurniChestView_Map_1.add(_loc4_,_loc5_);
         }
         _loc5_.push(_loc6_);
         return _loc6_;
      }
      
      private function removeStorage(param1:ChestStorage) : FurniChestItemView
      {
         var _loc4_:* = undefined;
         var _loc2_:FurniChestItemView = UnknownVarFromFurniChestView_Map_2.getValue(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         _loc2_.remove(param1);
         UnknownVarFromFurniChestView_Map_2.remove(param1);
         var _loc3_:String = itemTypeKey(param1.type);
         if(_loc2_.numItems == 0)
         {
            _loc4_ = UnknownVarFromFurniChestView_Map_1.getValue(_loc3_);
            if(_loc4_ != null && _loc4_.indexOf(_loc2_) != -1)
            {
               _loc4_.removeAt(_loc4_.indexOf(_loc2_));
            }
            if(_loc4_.length == 0)
            {
               UnknownVarFromFurniChestView_Map_1.remove(_loc3_);
            }
            recycleView(_loc2_);
            return _loc2_;
         }
         return null;
      }
      
      public function clear() : void
      {
         itemGrid.removeGridItems();
         for each(var _loc1_ in UnknownVarFromFurniChestView_Vector_1)
         {
            recycleView(_loc1_);
         }
         UnknownVarFromFurniChestView_Vector_1 = new Vector.<FurniChestItemView>();
         UnknownVarFromFurniChestView_Map_1 = new Map();
         UnknownVarFromFurniChestView_Map_2 = new Map();
         selectItemView(null);
         updatePreviewUI();
      }
      
      public function updateGrid() : void
      {
         var _loc5_:int = 0;
         var _loc1_:FurniChestItemView = null;
         var _loc3_:String = null;
         var _loc4_:Boolean = false;
         updateSearchbarVisibility();
         itemGrid.removeGridItems();
         var _loc6_:Array = UnknownVarFromFurniChestView_String_1.length > 0 ? UnknownVarFromFurniChestView_String_1.toLowerCase().split(" ") : null;
         _loc5_ = 0;
         for(; _loc5_ < UnknownVarFromFurniChestView_Vector_1.length; _loc5_++)
         {
            _loc1_ = UnknownVarFromFurniChestView_Vector_1[_loc5_];
            if(_loc6_ != null)
            {
               _loc3_ = getChestStorageName(_loc1_.peek()).toLowerCase();
               _loc4_ = true;
               for each(var _loc2_ in _loc6_)
               {
                  if(_loc3_.indexOf(_loc2_) == -1)
                  {
                     _loc4_ = false;
                     break;
                  }
               }
               if(!_loc4_)
               {
                  continue;
               }
            }
            itemGrid.addGridItem(UnknownVarFromFurniChestView_Vector_1[_loc5_].window);
         }
         noItemsText.visible = itemGrid.numGridItems == 0;
      }
      
      private function updateSearchbarVisibility() : void
      {
         if(!searchBorder.visible && UnknownVarFromFurniChestView_Vector_1.length >= 31)
         {
            searchBorder.visible = true;
            clearSearch();
            itemGrid.y += 28;
            itemGrid.height -= 28;
         }
         else if(searchBorder.visible && UnknownVarFromFurniChestView_Vector_1.length < 31)
         {
            searchBorder.visible = false;
            clearSearch();
            itemGrid.y -= 28;
            itemGrid.height += 28;
         }
      }
      
      private function clearSearch() : void
      {
         UnknownVarFromFurniChestView_Boolean_1 = true;
         searchInput.text = "";
         searchClearButton.visible = false;
         searchPlaceholder.visible = true;
         UnknownVarFromFurniChestView_String_1 = "";
         UnknownVarFromFurniChestView_Boolean_1 = false;
      }
      
      public function selectItemView(param1:FurniChestItemView) : void
      {
         if(UnknownVarFromFurniChestView_FurniChestItemView_1 != null)
         {
            UnknownVarFromFurniChestView_FurniChestItemView_1.deactivate();
            UnknownVarFromFurniChestView_FurniChestItemView_1 = null;
         }
         if(param1 != null)
         {
            UnknownVarFromFurniChestView_FurniChestItemView_1 = param1;
            UnknownVarFromFurniChestView_FurniChestItemView_1.activate();
         }
         updatePreviewUI();
      }
      
      public function maybeSelectNewItemView() : void
      {
         if(UnknownVarFromFurniChestView_FurniChestItemView_1 == null && UnknownVarFromFurniChestView_Vector_1.length > 0)
         {
            selectItemView(UnknownVarFromFurniChestView_Vector_1[0]);
         }
      }
      
      public function updatePreviewUI() : void
      {
         var _loc2_:ChestStorage = null;
         var _loc1_:ProductImageWidget = previewWidget.widget as ProductImageWidget;
         if(UnknownVarFromFurniChestView_FurniChestItemView_1 == null || UnknownVarFromFurniChestView_FurniChestItemView_1.peek() == null)
         {
            previewFurniName.text = "";
            _loc1_.clearPreviewer();
            viewLogsButton.disable();
            withdrawButton.disable();
            placeholderPreviewImage.visible = true;
         }
         else
         {
            placeholderPreviewImage.visible = false;
            _loc2_ = UnknownVarFromFurniChestView_FurniChestItemView_1.peek();
            Util.disableSection(viewLogsButton,!UnknownVarFromFurniChestView_FurniChestSubController_1.canRead);
            Util.disableSection(withdrawButton,!UnknownVarFromFurniChestView_FurniChestSubController_1.canWithdraw);
            previewFurniName.text = getChestStorageName(_loc2_);
            _loc1_.productInfo = new ChestItemTypeRenderableWrapper(_loc2_.type);
         }
      }
      
      public function getChestStorageName(param1:ChestStorage) : String
      {
         return getChestBasedItemName(param1,UnknownVarFromFurniChestView_FurniChestSubController_1.localization,UnknownVarFromFurniChestView_FurniChestSubController_1.parentController.sessionDataManager);
      }
      
      public function updateUI() : void
      {
         updatePreviewUI();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _container.dispose();
         _container = null;
         _itemTemplate.dispose();
         _itemTemplate = null;
         UnknownVarFromFurniChestView_Map_1 = null;
         UnknownVarFromFurniChestView_Map_2 = null;
         for each(var _loc1_ in UnknownVarFromFurniChestView_Vector_1)
         {
            recycleView(_loc1_);
         }
         UnknownVarFromFurniChestView_Vector_1 = null;
         UnknownVarFromFurniChestView_FurniChestItemView_1 = null;
         UnknownVarFromFurniChestView_FurniChestSubController_1 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get itemGrid() : IScrollableGridWindow
      {
         return _container.findChildByName("grid_items") as IScrollableGridWindow;
      }
      
      private function get searchBorder() : UnknownICoreWindowComponents6
      {
         return _container.findChildByName("search_border") as UnknownICoreWindowComponents6;
      }
      
      private function get searchPlaceholder() : ITextWindow
      {
         return _container.findChildByName("search_placeholder") as ITextWindow;
      }
      
      private function get searchInput() : ITextFieldWindow
      {
         return _container.findChildByName("search_input") as ITextFieldWindow;
      }
      
      private function get searchClearButton() : IRegionWindow
      {
         return _container.findChildByName("clear_search_button") as IRegionWindow;
      }
      
      private function get noItemsText() : ITextWindow
      {
         return _container.findChildByName("no_items_text") as ITextWindow;
      }
      
      private function get previewFurniName() : ITextWindow
      {
         return _container.findChildByName("furni_name") as ITextWindow;
      }
      
      private function get previewWidget() : IWidgetWindowController
      {
         return _container.findChildByName("preview_image") as IWidgetWindowController;
      }
      
      private function get placeholderPreviewImage() : IStaticBitmapWrapperWindow
      {
         return _container.findChildByName("placeholder_preview_image") as IStaticBitmapWrapperWindow;
      }
      
      private function get withdrawInput() : ITextFieldWindow
      {
         return _container.findChildByName("withdraw_input") as ITextFieldWindow;
      }
      
      private function get withdrawButton() : UnknownICoreWindowComponents4
      {
         return _container.findChildByName("withdraw_btn") as UnknownICoreWindowComponents4;
      }
      
      private function get viewLogsButton() : UnknownICoreWindowComponents4
      {
         return _container.findChildByName("view_logs_by_furni_btn") as UnknownICoreWindowComponents4;
      }
   }
}

