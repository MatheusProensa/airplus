package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.UnknownIHabboCatalog1;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetRoomPreviewerStuffDataEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboUserBadgesMessageEvent;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.object.data.StringArrayStuffData;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   
   public class UserBadgeSelectorCatalogWidget extends CatalogWidget implements ICatalogWidget
   {
      private static const BADGE_GRID_ITEM_NAME:String = "badgeGridItem";
      
      private static const MAX_SEARCH_STRING_LENGTH:int = 40;
      
      private var _itemGrid:IItemGridWindow;
      
      private var _gridItemLayout:XML;
      
      private var _catalog:HabboCatalog;
      
      private var UnknownVarFromUserBadgeSelectorCatalogWidget_String_1:String;
      
      private var UnknownVarFromUserBadgeSelectorCatalogWidget_IMessageEvent_1:IMessageEvent;
      
      private var _excludedBadges:Array;
      
      private var UnknownVarFromUserBadgeSelectorCatalogWidget_Array_1:Array;
      
      private var UnknownVarFromUserBadgeSelectorCatalogWidget_Array_2:Array;
      
      private var UnknownVarFromUserBadgeSelectorCatalogWidget_String_2:String = "";
      
      private var UnknownVarFromUserBadgeSelectorCatalogWidget_Object_1:Object;
      
      public function UserBadgeSelectorCatalogWidget(param1:IWindowController_1, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
         _excludedBadges = _catalog.getProperty("badge.display.excluded.badgeCodes").split(",");
      }
      
      override public function dispose() : void
      {
         if(UnknownVarFromUserBadgeSelectorCatalogWidget_IMessageEvent_1)
         {
            _catalog.connection.removeMessageEvent(UnknownVarFromUserBadgeSelectorCatalogWidget_IMessageEvent_1);
         }
         _catalog = null;
         _excludedBadges = null;
         UnknownVarFromUserBadgeSelectorCatalogWidget_Array_1 = null;
         UnknownVarFromUserBadgeSelectorCatalogWidget_Array_2 = null;
         UnknownVarFromUserBadgeSelectorCatalogWidget_Object_1 = null;
         UnknownVarFromUserBadgeSelectorCatalogWidget_String_1 = null;
         super.dispose();
      }
      
      override public function init() : Boolean
      {
         _itemGrid = _window.findChildByName("badgeGrid") as IItemGridWindow;
         var _loc1_:XmlAsset = page.viewer.catalog.assets.getAssetByName("badgeGridItem") as XmlAsset;
         _gridItemLayout = _loc1_.content as XML;
         _window.procedure = onWidgetEvent;
         refreshBadgeData();
         applyBadgeFilter(false);
         updateSearchUiState();
         events.addEventListener("WIDGETS_INITIALIZED",onWidgetsInitialized);
         UnknownVarFromUserBadgeSelectorCatalogWidget_IMessageEvent_1 = new HabboUserBadgesMessageEvent(onUserBadgesUpdated);
         _catalog.connection.addMessageEvent(UnknownVarFromUserBadgeSelectorCatalogWidget_IMessageEvent_1);
         return true;
      }
      
      private function refreshBadgeData() : void
      {
         UnknownVarFromUserBadgeSelectorCatalogWidget_Array_1 = _catalog.inventory.getAllMyBadgeIds(_excludedBadges);
         if(UnknownVarFromUserBadgeSelectorCatalogWidget_Array_1 == null)
         {
            UnknownVarFromUserBadgeSelectorCatalogWidget_Array_1 = [];
         }
         if(UnknownVarFromUserBadgeSelectorCatalogWidget_String_1 != null && UnknownVarFromUserBadgeSelectorCatalogWidget_Array_1.indexOf(UnknownVarFromUserBadgeSelectorCatalogWidget_String_1) == -1)
         {
            UnknownVarFromUserBadgeSelectorCatalogWidget_String_1 = null;
         }
         rebuildBadgeSearchCache();
      }
      
      private function rebuildBadgeSearchCache() : void
      {
         UnknownVarFromUserBadgeSelectorCatalogWidget_Object_1 = {};
         for each(var _loc1_ in UnknownVarFromUserBadgeSelectorCatalogWidget_Array_1)
         {
            UnknownVarFromUserBadgeSelectorCatalogWidget_Object_1[_loc1_] = buildBadgeSearchText(_loc1_);
         }
      }
      
      private function resetBadgeSelectorGrid() : void
      {
         if(_itemGrid == null)
         {
            return;
         }
         _itemGrid.destroyGridItems();
         var _loc2_:int = 0;
         for each(var _loc1_ in UnknownVarFromUserBadgeSelectorCatalogWidget_Array_2)
         {
            _itemGrid.addGridItem(createGridItem(_loc1_,_loc2_++));
         }
         restoreSelectionState();
      }
      
      private function onWidgetsInitialized(param1:CatalogWidgetEvent) : void
      {
         if(page.offers.length == 0)
         {
            return;
         }
         var _loc2_:UnknownIHabboCatalog1 = page.offers[0];
         events.dispatchEvent(new CatalogWidgetEvent("CWE_EXTRA_PARAM_REQUIRED_FOR_BUY"));
         events.dispatchEvent(new SelectProductEvent(_loc2_));
      }
      
      protected function createGridItem(param1:String, param2:int) : IWindowController_1
      {
         var _loc4_:IWindowController_1 = page.viewer.catalog.windowManager.buildFromXML(_gridItemLayout) as IWindowController_1;
         var _loc3_:IBadgeImageWidget = IBadgeImageWidget(IWidgetWindowController(_loc4_.findChildByName("badgeWidget")).widget);
         _loc3_.type = "normal";
         _loc3_.badgeId = param1;
         _loc4_.id = param2;
         _loc4_.name = "badgeGridItem";
         _loc4_.procedure = badgeGridItemWindowProc;
         return _loc4_;
      }
      
      private function setBadgeGridItemSelectionBg(param1:int, param2:Boolean) : void
      {
         var _loc3_:IWindowController_1 = IWindowController_1(_itemGrid.getGridItemAt(param1));
         if(_loc3_ != null)
         {
            UnknownICoreWindowComponents6(_loc3_.findChildByName("bg")).style = param2 ? 0 : 2;
         }
      }
      
      private function restoreSelectionState() : void
      {
         if(UnknownVarFromUserBadgeSelectorCatalogWidget_String_1 == null || UnknownVarFromUserBadgeSelectorCatalogWidget_Array_2 == null)
         {
            return;
         }
         var _loc1_:int = int(UnknownVarFromUserBadgeSelectorCatalogWidget_Array_2.indexOf(UnknownVarFromUserBadgeSelectorCatalogWidget_String_1));
         if(_loc1_ >= 0)
         {
            setBadgeGridItemSelectionBg(_loc1_,true);
         }
      }
      
      private function clearSelectedBadge(param1:Boolean = true) : void
      {
         var _loc2_:int = 0;
         if(UnknownVarFromUserBadgeSelectorCatalogWidget_String_1 != null && UnknownVarFromUserBadgeSelectorCatalogWidget_Array_2 != null)
         {
            _loc2_ = int(UnknownVarFromUserBadgeSelectorCatalogWidget_Array_2.indexOf(UnknownVarFromUserBadgeSelectorCatalogWidget_String_1));
            if(_loc2_ >= 0)
            {
               setBadgeGridItemSelectionBg(_loc2_,false);
            }
         }
         UnknownVarFromUserBadgeSelectorCatalogWidget_String_1 = null;
         if(param1)
         {
            events.dispatchEvent(new SetExtraPurchaseParameterEvent(""));
            page.dispatchWidgetEvent(new SetRoomPreviewerStuffDataEvent(getPreviewerStuffData("")));
         }
      }
      
      private function setSelectedBadgeByIndex(param1:int) : void
      {
         if(UnknownVarFromUserBadgeSelectorCatalogWidget_Array_2 == null || param1 < 0 || param1 >= UnknownVarFromUserBadgeSelectorCatalogWidget_Array_2.length)
         {
            return;
         }
         if(UnknownVarFromUserBadgeSelectorCatalogWidget_String_1 != null && UnknownVarFromUserBadgeSelectorCatalogWidget_Array_2.indexOf(UnknownVarFromUserBadgeSelectorCatalogWidget_String_1) >= 0)
         {
            setBadgeGridItemSelectionBg(UnknownVarFromUserBadgeSelectorCatalogWidget_Array_2.indexOf(UnknownVarFromUserBadgeSelectorCatalogWidget_String_1),false);
         }
         UnknownVarFromUserBadgeSelectorCatalogWidget_String_1 = UnknownVarFromUserBadgeSelectorCatalogWidget_Array_2[param1];
         setBadgeGridItemSelectionBg(param1,true);
         events.dispatchEvent(new SetExtraPurchaseParameterEvent(UnknownVarFromUserBadgeSelectorCatalogWidget_String_1));
         page.dispatchWidgetEvent(new SetRoomPreviewerStuffDataEvent(getPreviewerStuffData(UnknownVarFromUserBadgeSelectorCatalogWidget_String_1)));
      }
      
      private function getBadgeGridItemWindow(param1:IWindowModel) : IWindowController_1
      {
         var _loc2_:* = param1;
         while(_loc2_ != null)
         {
            if(_loc2_.name == "badgeGridItem")
            {
               return _loc2_ as IWindowController_1;
            }
            _loc2_ = _loc2_.parent;
         }
         return null;
      }
      
      private function badgeGridItemWindowProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var _loc3_:IWindowController_1 = getBadgeGridItemWindow(param2);
         if(_loc3_ != null)
         {
            setSelectedBadgeByIndex(_loc3_.id);
         }
      }
      
      private function getPreviewerStuffData(param1:String) : IStuffData
      {
         var _loc2_:Array = [];
         _loc2_.push("0");
         _loc2_.push(param1 == null ? "" : param1);
         _loc2_.push("");
         _loc2_.push("");
         var _loc3_:StringArrayStuffData = new StringArrayStuffData();
         _loc3_.setArray(_loc2_);
         return _loc3_;
      }
      
      private function onWidgetEvent(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:ITextFieldWindow = null;
         var _loc4_:WindowKeyboardEvent = null;
         if(param2 == null)
         {
            param2 = param1.target as IWindowModel;
         }
         if(param1.type == "WME_CLICK")
         {
            if(param2 != null && param2.name == "search_placeholder")
            {
               focusSearchInput();
            }
            else if(param2 != null && (param2.name == "cancel_search_btn" || param2.parent != null && param2.parent.name == "cancel_search_btn"))
            {
               clearSearch();
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
            UnknownVarFromUserBadgeSelectorCatalogWidget_String_2 = normalizeSearchText(_loc3_.text);
            applyBadgeFilter();
            updateSearchUiState();
         }
         else if(param1.type == "WKE_KEY_DOWN")
         {
            if(param2 is ITextFieldWindow && param2.name == "search_input")
            {
               _loc4_ = param1 as WindowKeyboardEvent;
               if(_loc4_ != null && _loc4_.keyCode == 27)
               {
                  clearSearch();
               }
            }
         }
      }
      
      private function focusSearchInput() : void
      {
         var _loc1_:ITextFieldWindow = _window.findChildByName("search_input") as ITextFieldWindow;
         if(_loc1_ != null)
         {
            _loc1_.focus();
            _loc1_.setSelection(0,_loc1_.text.length);
         }
      }
      
      private function clearSearch() : void
      {
         var _loc1_:ITextFieldWindow = _window.findChildByName("search_input") as ITextFieldWindow;
         if(_loc1_ != null)
         {
            _loc1_.text = "";
            _loc1_.scrollH = 0;
         }
         UnknownVarFromUserBadgeSelectorCatalogWidget_String_2 = "";
         applyBadgeFilter();
         updateSearchUiState();
      }
      
      private function applyBadgeFilter(param1:Boolean = true) : void
      {
         UnknownVarFromUserBadgeSelectorCatalogWidget_Array_2 = [];
         for each(var _loc2_ in UnknownVarFromUserBadgeSelectorCatalogWidget_Array_1)
         {
            if(matchesSearch(_loc2_))
            {
               UnknownVarFromUserBadgeSelectorCatalogWidget_Array_2.push(_loc2_);
            }
         }
         if(param1 && UnknownVarFromUserBadgeSelectorCatalogWidget_String_1 != null && UnknownVarFromUserBadgeSelectorCatalogWidget_Array_2.indexOf(UnknownVarFromUserBadgeSelectorCatalogWidget_String_1) == -1)
         {
            clearSelectedBadge();
         }
         resetBadgeSelectorGrid();
      }
      
      private function matchesSearch(param1:String) : Boolean
      {
         if(UnknownVarFromUserBadgeSelectorCatalogWidget_String_2 == "")
         {
            return true;
         }
         var _loc2_:String = UnknownVarFromUserBadgeSelectorCatalogWidget_Object_1[param1];
         return _loc2_ != null && _loc2_.indexOf(UnknownVarFromUserBadgeSelectorCatalogWidget_String_2) >= 0;
      }
      
      private function buildBadgeSearchText(param1:String) : String
      {
         if(param1 == null || _catalog == null || _catalog.localization == null)
         {
            return "";
         }
         return normalizeSearchText(param1 + " " + _catalog.localization.getBadgeName(param1) + " " + _catalog.localization.getBadgeDesc(param1));
      }
      
      private function normalizeSearchText(param1:String) : String
      {
         return param1 == null ? "" : param1.toLowerCase();
      }
      
      private function updateSearchUiState() : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc1_:ITextFieldWindow = _window.findChildByName("search_input") as ITextFieldWindow;
         var _loc3_:IWindowModel = _window.findChildByName("search_placeholder");
         var _loc2_:IWindowModel = _window.findChildByName("cancel_search_btn");
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
      
      private function onUserBadgesUpdated(param1:IMessageEvent) : void
      {
         refreshBadgeData();
         applyBadgeFilter();
         updateSearchUiState();
      }
   }
}

