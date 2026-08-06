package com.sulake.habbo.messenger.habbicons
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.habbicons.HabbiconControllerEvent;
   import com.sulake.habbo.catalog.habbicons.IHabbiconController;
   import com.sulake.habbo.communication.messages.parser.habbicons.UnknownHabboCommunicationMessagesParserHabbicons1;
   import com.sulake.habbo.communication.messages.parser.habbicons.UnknownHabboCommunicationMessagesParserHabbicons2;
   import com.sulake.habbo.communication.messages.parser.habbicons.UnknownHabboCommunicationMessagesParserHabbicons3;
   import com.sulake.habbo.habbicons.assets.HabbiconAssetManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class MessengerHabbiconPicker implements IComponentInterfaceQueue
   {
      private static const SECTION_FAVORITES:String = "favorites";
      
      private static const UnknownConstFromMessengerHabbiconPicker_String_1:String = "recent";
      
      private static const UnknownConstFromMessengerHabbiconPicker_String_2:String = "collection";
      
      private static const SECTION_SEARCH:String = "search";
      
      private static const MENU_MIN_HEIGHT:int = 94;
      
      private static const MENU_MAX_HEIGHT:int = 304;
      
      private static const TOP_BAR_HEIGHT:int = 42;
      
      private static const BOTTOM_PADDING:int = 6;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromMessengerHabbiconPicker_IHabbiconController_1:IHabbiconController;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var UnknownVarFromMessengerHabbiconPicker_Function_1:Function;
      
      private var UnknownVarFromMessengerHabbiconPicker_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromMessengerHabbiconPicker_Vector_1:Vector.<MessengerHabbiconPickerSectionView>;
      
      private var UnknownVarFromMessengerHabbiconPicker_Array_1:Array;
      
      private var _ownedSearchEntries:Array;
      
      private var UnknownVarFromMessengerHabbiconPicker_Dictionary_1:Dictionary;
      
      private var UnknownVarFromMessengerHabbiconPicker_Boolean_1:Boolean = true;
      
      private var UnknownVarFromMessengerHabbiconPicker_Boolean_2:Boolean = true;
      
      private var UnknownVarFromMessengerHabbiconPicker_Boolean_3:Boolean;
      
      private var UnknownVarFromMessengerHabbiconPicker_String_1:String;
      
      private var _disposed:Boolean;
      
      public function MessengerHabbiconPicker(param1:IWindowController_1, param2:IHabbiconController, param3:IHabboLocalizationManager, param4:IHabboWindowManagerComponent, param5:Function)
      {
         super();
         _window = param1;
         UnknownVarFromMessengerHabbiconPicker_IHabbiconController_1 = param2;
         _localization = param3;
         _windowManager = param4;
         UnknownVarFromMessengerHabbiconPicker_Function_1 = param5;
         UnknownVarFromMessengerHabbiconPicker_Vector_1 = new Vector.<MessengerHabbiconPickerSectionView>(0);
         UnknownVarFromMessengerHabbiconPicker_Array_1 = [];
         _ownedSearchEntries = [];
         UnknownVarFromMessengerHabbiconPicker_Dictionary_1 = new Dictionary();
         _window.visible = false;
         UnknownVarFromMessengerHabbiconPicker_IWindowController_1_1 = sectionList.removeListItem(sectionList.getListItemByName("habbicon_section_template")) as IWindowController_1;
         searchInput.addEventListener("WE_CHANGE",onSearchChanged);
         searchInput.addEventListener("WKE_KEY_DOWN",onSearchKeyDown);
         searchPlaceholder.addEventListener("WME_DOWN",onSearchPlaceholderDown);
         searchClearButton.addEventListener("WME_CLICK",onSearchClearClicked);
         openHubButton.addEventListener("WME_CLICK",onOpenHubClicked);
         if(UnknownVarFromMessengerHabbiconPicker_IHabbiconController_1 != null)
         {
            UnknownVarFromMessengerHabbiconPicker_IHabbiconController_1.addEventListener("hce_owned_habbicons_updated",onControllerDataUpdated);
            UnknownVarFromMessengerHabbiconPicker_IHabbiconController_1.addEventListener("hce_shop_data_updated",onControllerDataUpdated);
            UnknownVarFromMessengerHabbiconPicker_IHabbiconController_1.addEventListener("hce_recent_habbicons_updated",onRecentHabbiconsUpdated);
         }
         setSearchState(false);
      }
      
      private static function isWindowInTree(param1:IWindowModel, param2:IWindowModel) : Boolean
      {
         while(param1 != null)
         {
            if(param1 == param2)
            {
               return true;
            }
            param1 = param1.parent;
         }
         return false;
      }
      
      public function show() : void
      {
         if(_disposed)
         {
            return;
         }
         applyDeferredRecentSectionUpdate();
         renderIfDirty();
         _window.visible = true;
         _window.activate();
         focusSearch();
      }
      
      public function hide(param1:Boolean = true) : void
      {
         if(!_disposed)
         {
            _window.visible = false;
            if(param1 && UnknownVarFromMessengerHabbiconPicker_IHabbiconController_1 != null)
            {
               UnknownVarFromMessengerHabbiconPicker_IHabbiconController_1.resetUnseenHabbicons();
               invalidateLayout();
            }
         }
      }
      
      public function toggle() : void
      {
         if(visible)
         {
            hide();
         }
         else
         {
            show();
         }
      }
      
      public function get visible() : Boolean
      {
         return !_disposed && Boolean(_window.visible);
      }
      
      public function containsWindow(param1:IWindowModel) : Boolean
      {
         return !_disposed && isWindowInTree(param1,_window);
      }
      
      public function focusSearch() : void
      {
         if(!_disposed)
         {
            searchInput.focus();
         }
      }
      
      public function setPosition(param1:int, param2:int) : void
      {
         if(!_disposed)
         {
            _window.x = param1;
            _window.y = param2;
         }
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(UnknownVarFromMessengerHabbiconPicker_IHabbiconController_1 != null)
         {
            UnknownVarFromMessengerHabbiconPicker_IHabbiconController_1.removeEventListener("hce_owned_habbicons_updated",onControllerDataUpdated);
            UnknownVarFromMessengerHabbiconPicker_IHabbiconController_1.removeEventListener("hce_shop_data_updated",onControllerDataUpdated);
            UnknownVarFromMessengerHabbiconPicker_IHabbiconController_1.removeEventListener("hce_recent_habbicons_updated",onRecentHabbiconsUpdated);
            UnknownVarFromMessengerHabbiconPicker_IHabbiconController_1 = null;
         }
         searchInput.removeEventListener("WE_CHANGE",onSearchChanged);
         searchInput.removeEventListener("WKE_KEY_DOWN",onSearchKeyDown);
         searchPlaceholder.removeEventListener("WME_DOWN",onSearchPlaceholderDown);
         searchClearButton.removeEventListener("WME_CLICK",onSearchClearClicked);
         openHubButton.removeEventListener("WME_CLICK",onOpenHubClicked);
         clearSections();
         if(UnknownVarFromMessengerHabbiconPicker_IWindowController_1_1 != null)
         {
            UnknownVarFromMessengerHabbiconPicker_IWindowController_1_1.dispose();
            UnknownVarFromMessengerHabbiconPicker_IWindowController_1_1 = null;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         _localization = null;
         _windowManager = null;
         UnknownVarFromMessengerHabbiconPicker_Function_1 = null;
         UnknownVarFromMessengerHabbiconPicker_Array_1 = null;
         _ownedSearchEntries = null;
         UnknownVarFromMessengerHabbiconPicker_Dictionary_1 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function onControllerDataUpdated(param1:Event) : void
      {
         var _loc2_:HabbiconControllerEvent = param1 as HabbiconControllerEvent;
         if(_loc2_ != null && _loc2_.habbiconId > 0 && !UnknownVarFromMessengerHabbiconPicker_Boolean_1 && !UnknownVarFromMessengerHabbiconPicker_Boolean_2)
         {
            if(visible)
            {
               refreshNarrowControllerUpdate();
            }
            else
            {
               invalidateSections();
            }
            return;
         }
         invalidateSections();
         if(visible)
         {
            renderIfDirty();
         }
      }
      
      private function onRecentHabbiconsUpdated(param1:HabbiconControllerEvent) : void
      {
         if(visible)
         {
            UnknownVarFromMessengerHabbiconPicker_Boolean_3 = true;
            return;
         }
         if(UnknownVarFromMessengerHabbiconPicker_Boolean_1)
         {
            return;
         }
         if(refreshRecentSectionState())
         {
            invalidateLayout();
         }
      }
      
      private function applyDeferredRecentSectionUpdate() : void
      {
         if(!UnknownVarFromMessengerHabbiconPicker_Boolean_3)
         {
            return;
         }
         UnknownVarFromMessengerHabbiconPicker_Boolean_3 = false;
         if(UnknownVarFromMessengerHabbiconPicker_Boolean_1)
         {
            return;
         }
         if(refreshRecentSectionState())
         {
            UnknownVarFromMessengerHabbiconPicker_Boolean_2 = true;
         }
      }
      
      private function invalidateSections() : void
      {
         UnknownVarFromMessengerHabbiconPicker_Boolean_1 = true;
         UnknownVarFromMessengerHabbiconPicker_Boolean_2 = true;
      }
      
      private function invalidateLayout() : void
      {
         UnknownVarFromMessengerHabbiconPicker_Boolean_2 = true;
      }
      
      private function renderIfDirty() : void
      {
         var _loc1_:String = normalizedQuery();
         if(UnknownVarFromMessengerHabbiconPicker_String_1 != _loc1_)
         {
            UnknownVarFromMessengerHabbiconPicker_Boolean_2 = true;
         }
         if(!UnknownVarFromMessengerHabbiconPicker_Boolean_1 && !UnknownVarFromMessengerHabbiconPicker_Boolean_2)
         {
            setSearchState(_loc1_.length > 0);
            return;
         }
         if(UnknownVarFromMessengerHabbiconPicker_Boolean_1)
         {
            refreshSections();
            UnknownVarFromMessengerHabbiconPicker_Boolean_1 = false;
         }
         refresh(_loc1_);
         UnknownVarFromMessengerHabbiconPicker_String_1 = _loc1_;
         UnknownVarFromMessengerHabbiconPicker_Boolean_2 = false;
      }
      
      private function refreshSections() : void
      {
         var _loc4_:Array = null;
         var _loc3_:* = null;
         var _loc2_:MessengerHabbiconPickerEntry = null;
         var _loc1_:Array = [];
         var _loc5_:Array = [];
         UnknownVarFromMessengerHabbiconPicker_Array_1 = [];
         _ownedSearchEntries = [];
         UnknownVarFromMessengerHabbiconPicker_Dictionary_1 = new Dictionary();
         if(UnknownVarFromMessengerHabbiconPicker_IHabbiconController_1 == null)
         {
            return;
         }
         _loc4_ = UnknownVarFromMessengerHabbiconPicker_IHabbiconController_1.ownedHabbicons;
         for each(_loc3_ in _loc4_)
         {
            _loc2_ = createEntry(_loc3_);
            if(_loc2_ != null)
            {
               UnknownVarFromMessengerHabbiconPicker_Dictionary_1[_loc2_.habbiconId] = _loc2_;
               _ownedSearchEntries.push(_loc2_);
               if(_loc2_.favorite)
               {
                  _loc1_.push(_loc2_);
               }
            }
         }
         sortEntries(_ownedSearchEntries);
         sortEntries(_loc1_);
         _loc5_ = buildRecentEntries();
         if(_loc1_.length > 0)
         {
            UnknownVarFromMessengerHabbiconPicker_Array_1.push(new MessengerHabbiconPickerSection("favorites","favorites",localize("habbicons.favourites.title","Favorites"),_loc1_));
         }
         if(_loc5_.length > 0)
         {
            UnknownVarFromMessengerHabbiconPicker_Array_1.push(new MessengerHabbiconPickerSection("recent","recent",localize("habbicon.recently.used","Recently used"),_loc5_));
         }
         addOwnedSetSections();
      }
      
      private function addOwnedSetSections() : void
      {
         var _loc3_:* = undefined;
         var _loc5_:* = null;
         var _loc2_:Array = null;
         var _loc4_:* = null;
         var _loc1_:MessengerHabbiconPickerEntry = null;
         if(UnknownVarFromMessengerHabbiconPicker_IHabbiconController_1 == null || !UnknownVarFromMessengerHabbiconPicker_IHabbiconController_1.hasLoadedShopData)
         {
            return;
         }
         _loc3_ = UnknownVarFromMessengerHabbiconPicker_IHabbiconController_1.shopCollections;
         for each(_loc5_ in _loc3_)
         {
            if(_loc5_ != null)
            {
               _loc2_ = [];
               if(_loc5_.habbicons != null)
               {
                  for each(_loc4_ in _loc5_.habbicons)
                  {
                     if(_loc4_ != null)
                     {
                        _loc1_ = UnknownVarFromMessengerHabbiconPicker_Dictionary_1[_loc4_.habbiconId] as MessengerHabbiconPickerEntry;
                        if(_loc1_ != null)
                        {
                           _loc2_.push(_loc1_);
                        }
                     }
                  }
               }
               if(_loc5_.UnknownVarFromUnknownHabboCommunicationMessagesParserHabbicons3_Int_1 > 0)
               {
                  _loc1_ = UnknownVarFromMessengerHabbiconPicker_Dictionary_1[_loc5_.UnknownVarFromUnknownHabboCommunicationMessagesParserHabbicons3_Int_1] as MessengerHabbiconPickerEntry;
                  if(_loc1_ != null)
                  {
                     _loc2_.push(_loc1_);
                  }
               }
               if(_loc2_.length > 0)
               {
                  UnknownVarFromMessengerHabbiconPicker_Array_1.push(new MessengerHabbiconPickerSection("collection","collection:" + _loc5_.collectionId,resolveCollectionTitle(_loc5_),_loc2_));
               }
            }
         }
      }
      
      private function refreshNarrowControllerUpdate() : void
      {
         var _loc1_:String = normalizedQuery();
         var _loc2_:Array = UnknownVarFromMessengerHabbiconPicker_Array_1.concat();
         refreshSections();
         UnknownVarFromMessengerHabbiconPicker_Boolean_1 = false;
         UnknownVarFromMessengerHabbiconPicker_Boolean_2 = false;
         UnknownVarFromMessengerHabbiconPicker_String_1 = _loc1_;
         if(_loc1_.length > 0)
         {
            refreshSearchResultsSection(_loc1_);
            return;
         }
         renderChangedSections(_loc2_);
      }
      
      private function refreshSearchResultsSection(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = Number(sectionList.scrollV);
         clearSections();
         setSearchState(true);
         _loc2_ = addSearchResultsSection(param1);
         emptyView.visible = _loc2_ == 0;
         updateHeight();
         sectionList.scrollV = _loc3_;
      }
      
      private function renderChangedSections(param1:Array) : void
      {
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc7_:MessengerHabbiconPickerSectionView = null;
         var _loc2_:int = 0;
         var _loc5_:Vector.<MessengerHabbiconPickerSectionView> = UnknownVarFromMessengerHabbiconPicker_Vector_1;
         var _loc4_:Dictionary = new Dictionary();
         var _loc8_:Number = Number(sectionList.scrollV);
         if(sameSections(param1,UnknownVarFromMessengerHabbiconPicker_Array_1))
         {
            emptyView.visible = UnknownVarFromMessengerHabbiconPicker_Array_1.length == 0;
            return;
         }
         sectionList.removeListItems();
         UnknownVarFromMessengerHabbiconPicker_Vector_1 = new Vector.<MessengerHabbiconPickerSectionView>(0);
         for each(_loc3_ in UnknownVarFromMessengerHabbiconPicker_Array_1)
         {
            _loc6_ = findSectionIndexByKey(param1,_loc3_.key);
            if(_loc6_ >= 0 && _loc6_ < _loc5_.length && sameSection(param1[_loc6_] as MessengerHabbiconPickerSection,_loc3_))
            {
               _loc7_ = _loc5_[_loc6_];
               _loc4_[_loc6_] = true;
            }
            else
            {
               if(_loc6_ >= 0 && _loc6_ < _loc5_.length)
               {
                  _loc5_[_loc6_].dispose();
                  _loc4_[_loc6_] = true;
               }
               _loc7_ = createSectionView(_loc3_);
            }
            UnknownVarFromMessengerHabbiconPicker_Vector_1.push(_loc7_);
            sectionList.addListItem(_loc7_.window);
         }
         _loc2_ = 0;
         while(_loc2_ < _loc5_.length)
         {
            if(_loc4_[_loc2_] != true)
            {
               _loc5_[_loc2_].dispose();
            }
            _loc2_++;
         }
         emptyView.visible = UnknownVarFromMessengerHabbiconPicker_Array_1.length == 0;
         updateHeight();
         sectionList.scrollV = _loc8_;
      }
      
      private function buildRecentEntries() : Array
      {
         var _loc1_:int = 0;
         var _loc2_:MessengerHabbiconPickerEntry = null;
         var _loc3_:Array = [];
         if(UnknownVarFromMessengerHabbiconPicker_IHabbiconController_1 == null)
         {
            return _loc3_;
         }
         for each(_loc1_ in UnknownVarFromMessengerHabbiconPicker_IHabbiconController_1.recentHabbiconIds)
         {
            _loc2_ = UnknownVarFromMessengerHabbiconPicker_Dictionary_1[_loc1_] as MessengerHabbiconPickerEntry;
            if(_loc2_ != null)
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      private function refreshRecentSectionState() : Boolean
      {
         var _loc2_:MessengerHabbiconPickerSection = null;
         var _loc3_:Array = buildRecentEntries();
         var _loc1_:int = recentSectionIndex();
         if(_loc1_ >= 0)
         {
            _loc2_ = UnknownVarFromMessengerHabbiconPicker_Array_1[_loc1_] as MessengerHabbiconPickerSection;
            if(sameEntries(_loc2_.entries,_loc3_))
            {
               return false;
            }
         }
         if(_loc3_.length == 0)
         {
            if(_loc1_ >= 0)
            {
               UnknownVarFromMessengerHabbiconPicker_Array_1.splice(_loc1_,1);
               return true;
            }
            return false;
         }
         if(_loc1_ >= 0)
         {
            _loc2_.entries = _loc3_;
            return true;
         }
         UnknownVarFromMessengerHabbiconPicker_Array_1.splice(recentInsertIndex(),0,new MessengerHabbiconPickerSection("recent","recent",localize("habbicon.recently.used","Recently used"),_loc3_));
         return true;
      }
      
      private function renderRecentSection() : void
      {
         var _loc3_:MessengerHabbiconPickerSection = null;
         var _loc2_:MessengerHabbiconPickerSectionView = null;
         var _loc1_:int = recentSectionIndex();
         var _loc4_:Number = Number(sectionList.scrollV);
         if(_loc1_ < 0)
         {
            removeRecentSectionView(_loc4_);
            return;
         }
         if(_loc1_ < UnknownVarFromMessengerHabbiconPicker_Vector_1.length && UnknownVarFromMessengerHabbiconPicker_Vector_1[_loc1_].key == "recent")
         {
            UnknownVarFromMessengerHabbiconPicker_Vector_1[_loc1_].dispose();
            UnknownVarFromMessengerHabbiconPicker_Vector_1.splice(_loc1_,1);
         }
         _loc3_ = UnknownVarFromMessengerHabbiconPicker_Array_1[_loc1_] as MessengerHabbiconPickerSection;
         _loc2_ = createSectionView(_loc3_);
         UnknownVarFromMessengerHabbiconPicker_Vector_1.splice(_loc1_,0,_loc2_);
         sectionList.addListItemAt(_loc2_.window,_loc1_);
         updateHeight();
         sectionList.scrollV = _loc4_;
         emptyView.visible = UnknownVarFromMessengerHabbiconPicker_Array_1.length == 0;
      }
      
      private function removeRecentSectionView(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MessengerHabbiconPickerSectionView = null;
         _loc2_ = 0;
         while(_loc2_ < UnknownVarFromMessengerHabbiconPicker_Vector_1.length)
         {
            _loc3_ = UnknownVarFromMessengerHabbiconPicker_Vector_1[_loc2_];
            if(_loc3_.key == "recent")
            {
               _loc3_.dispose();
               UnknownVarFromMessengerHabbiconPicker_Vector_1.splice(_loc2_,1);
               updateHeight();
               sectionList.scrollV = param1;
               emptyView.visible = UnknownVarFromMessengerHabbiconPicker_Array_1.length == 0;
               return;
            }
            _loc2_++;
         }
      }
      
      private function recentSectionIndex() : int
      {
         var _loc1_:int = 0;
         var _loc2_:MessengerHabbiconPickerSection = null;
         _loc1_ = 0;
         while(_loc1_ < UnknownVarFromMessengerHabbiconPicker_Array_1.length)
         {
            _loc2_ = UnknownVarFromMessengerHabbiconPicker_Array_1[_loc1_] as MessengerHabbiconPickerSection;
            if(_loc2_.type == "recent")
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return -1;
      }
      
      private function recentInsertIndex() : int
      {
         var _loc1_:MessengerHabbiconPickerSection = UnknownVarFromMessengerHabbiconPicker_Array_1.length > 0 ? UnknownVarFromMessengerHabbiconPicker_Array_1[0] as MessengerHabbiconPickerSection : null;
         return _loc1_ != null && _loc1_.type == "favorites" ? 1 : 0;
      }
      
      private function sameEntries(param1:Array, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         if(param1 == null || param2 == null || param1.length != param2.length)
         {
            return false;
         }
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_].habbiconId != param2[_loc3_].habbiconId)
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      private function sameSection(param1:MessengerHabbiconPickerSection, param2:MessengerHabbiconPickerSection) : Boolean
      {
         return param1 != null && param2 != null && param1.type == param2.type && param1.key == param2.key && param1.title == param2.title && sameEntries(param1.entries,param2.entries);
      }
      
      private function sameSections(param1:Array, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         if(param1 == null || param2 == null || param1.length != param2.length)
         {
            return false;
         }
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(!sameSection(param1[_loc3_] as MessengerHabbiconPickerSection,param2[_loc3_] as MessengerHabbiconPickerSection))
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      private function findSectionIndexByKey(param1:Array, param2:String) : int
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(MessengerHabbiconPickerSection(param1[_loc3_]).key == param2)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      private function createEntry(param1:UnknownHabboCommunicationMessagesParserHabbicons1) : MessengerHabbiconPickerEntry
      {
         var _loc2_:int = param1.habbiconState;
         if(_loc2_ != 2 && _loc2_ != 3)
         {
            return null;
         }
         return new MessengerHabbiconPickerEntry(param1.habbiconId,resolveEntryName(param1.habbiconId),_loc2_ == 3);
      }
      
      private function resolveEntryName(param1:int) : String
      {
         var _loc2_:String = HabbiconAssetManager.getHabbiconNameKey(param1);
         return _loc2_ != null && _loc2_.length > 0 ? localize("habbicon_" + _loc2_ + "_name",_loc2_) : "Habbicon";
      }
      
      private function resolveCollectionTitle(param1:UnknownHabboCommunicationMessagesParserHabbicons3) : String
      {
         if(param1.name == null || param1.name.length == 0)
         {
            return "Habbicons";
         }
         return localize("habbicon_collection_" + param1.name + "_name",param1.name);
      }
      
      private function refresh(param1:String) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         clearSections();
         setSearchState(param1.length > 0);
         if(param1.length > 0)
         {
            _loc2_ = addSearchResultsSection(param1);
            emptyView.visible = _loc2_ == 0;
            updateHeight();
            return;
         }
         for each(_loc3_ in UnknownVarFromMessengerHabbiconPicker_Array_1)
         {
            addSection(_loc3_.type,_loc3_.key,_loc3_.title,_loc3_.entries);
            _loc2_++;
         }
         emptyView.visible = _loc2_ == 0;
         updateHeight();
      }
      
      private function addSearchResultsSection(param1:String) : int
      {
         var _loc2_:* = null;
         var _loc3_:Array = [];
         for each(_loc2_ in _ownedSearchEntries)
         {
            if(_loc2_.searchName.indexOf(param1) >= 0)
            {
               _loc3_.push(_loc2_);
            }
         }
         if(_loc3_.length == 0)
         {
            return 0;
         }
         addSection("search","search",localize("habbicon.search.results","Search results"),_loc3_);
         return 1;
      }
      
      private function addSection(param1:String, param2:String, param3:String, param4:Array) : void
      {
         var _loc5_:MessengerHabbiconPickerSectionView = new MessengerHabbiconPickerSectionView(UnknownVarFromMessengerHabbiconPicker_IWindowController_1_1,param1,param2,param3,param4,onHabbiconSelected,_windowManager,isUnseenHabbicon,onSelectorWheel);
         UnknownVarFromMessengerHabbiconPicker_Vector_1.push(_loc5_);
         sectionList.addListItem(_loc5_.window);
      }
      
      private function createSectionView(param1:MessengerHabbiconPickerSection) : MessengerHabbiconPickerSectionView
      {
         return new MessengerHabbiconPickerSectionView(UnknownVarFromMessengerHabbiconPicker_IWindowController_1_1,param1.type,param1.key,param1.title,param1.entries,onHabbiconSelected,_windowManager,isUnseenHabbicon,onSelectorWheel);
      }
      
      private function clearSections() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in UnknownVarFromMessengerHabbiconPicker_Vector_1)
         {
            _loc1_.dispose();
         }
         UnknownVarFromMessengerHabbiconPicker_Vector_1.length = 0;
      }
      
      private function onHabbiconSelected(param1:int, param2:Boolean) : void
      {
         if(UnknownVarFromMessengerHabbiconPicker_IHabbiconController_1 != null)
         {
            UnknownVarFromMessengerHabbiconPicker_IHabbiconController_1.removeUnseenHabbicon(param1);
         }
         if(UnknownVarFromMessengerHabbiconPicker_Function_1 != null)
         {
            UnknownVarFromMessengerHabbiconPicker_Function_1(param1,param2);
         }
         if(!param2)
         {
            hide(false);
         }
         else
         {
            clearUnseenCounterForHabbicon(param1);
         }
      }
      
      private function clearUnseenCounterForHabbicon(param1:int) : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in UnknownVarFromMessengerHabbiconPicker_Vector_1)
         {
            _loc2_.clearUnseenCounterForHabbicon(param1);
         }
      }
      
      private function isUnseenHabbicon(param1:int) : Boolean
      {
         return UnknownVarFromMessengerHabbiconPicker_IHabbiconController_1 != null && UnknownVarFromMessengerHabbiconPicker_IHabbiconController_1.isUnseenHabbicon(param1);
      }
      
      private function updateHeight() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_window == null || sectionList == null)
         {
            return;
         }
         _loc3_ = int(sectionList.scrollableRegion.height);
         _loc1_ = Math.max(46,_loc3_ + 2);
         _loc2_ = 304 - 42 - 6;
         _loc1_ = Math.min(_loc1_,_loc2_);
         sectionList.height = _loc1_;
         _window.height = Math.max(94,42 + _loc1_ + 6);
         _window.invalidate();
      }
      
      private function normalizedQuery() : String
      {
         var _loc1_:String = searchInput.text;
         return _loc1_ != null ? _loc1_.toLowerCase() : "";
      }
      
      private function onSearchChanged(param1:WindowEvent) : void
      {
         invalidateLayout();
         renderIfDirty();
      }
      
      private function onSearchKeyDown(param1:WindowKeyboardEvent) : void
      {
         if(param1.keyCode == 27 && searchInput.text.length > 0)
         {
            clearSearch();
         }
      }
      
      private function onSearchPlaceholderDown(param1:WindowMouseEvent) : void
      {
         searchInput.focus();
      }
      
      private function onSearchClearClicked(param1:WindowMouseEvent) : void
      {
         clearSearch();
      }
      
      private function onOpenHubClicked(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromMessengerHabbiconPicker_IHabbiconController_1 != null)
         {
            UnknownVarFromMessengerHabbiconPicker_IHabbiconController_1.openHabbiconHub();
         }
         hide(false);
      }
      
      private function onSelectorWheel(param1:WindowMouseEvent) : void
      {
         var _loc2_:Number = NaN;
         if(sectionList == null)
         {
            return;
         }
         _loc2_ = Number(param1.type == "WME_WHEEL_HORIZONTAL" ? -param1.delta : param1.delta);
         if(sectionList.scrollWithWheel(_loc2_,param1.type == "WME_WHEEL_HORIZONTAL" || param1.shiftKey))
         {
            param1.stopPropagation();
         }
      }
      
      private function clearSearch() : void
      {
         searchInput.text = "";
         invalidateLayout();
         renderIfDirty();
      }
      
      private function setSearchState(param1:Boolean) : void
      {
         searchPlaceholder.visible = !param1;
         searchClearButton.visible = param1;
      }
      
      private function localize(param1:String, param2:String) : String
      {
         var _loc3_:String = _localization != null ? _localization.getLocalization(param1,param2) : param2;
         return _loc3_ != null && _loc3_.length > 0 ? _loc3_ : param2;
      }
      
      private function sortEntries(param1:Array) : void
      {
         var entries:Array = param1;
         entries.sort(function(param1:MessengerHabbiconPickerEntry, param2:MessengerHabbiconPickerEntry):int
         {
            if(param1.favorite != param2.favorite)
            {
               return param1.favorite ? -1 : 1;
            }
            if(param1.name < param2.name)
            {
               return -1;
            }
            if(param1.name > param2.name)
            {
               return 1;
            }
            return param1.habbiconId - param2.habbiconId;
         });
      }
      
      private function get sectionList() : IItemListWindow
      {
         return _window.findChildByName("habbicon_section_list") as IItemListWindow;
      }
      
      private function get searchInput() : ITextFieldWindow
      {
         return _window.findChildByName("habbicon_search_input") as ITextFieldWindow;
      }
      
      private function get searchPlaceholder() : ITextWindow
      {
         return _window.findChildByName("habbicon_search_placeholder") as ITextWindow;
      }
      
      private function get searchClearButton() : IWindowModel
      {
         return _window.findChildByName("habbicon_search_clear_button");
      }
      
      private function get openHubButton() : IWindowModel
      {
         return _window.findChildByName("habbicon_open_hub_button");
      }
      
      private function get emptyView() : IWindowController_1
      {
         return _window.findChildByName("empty_view") as IWindowController_1;
      }
   }
}

