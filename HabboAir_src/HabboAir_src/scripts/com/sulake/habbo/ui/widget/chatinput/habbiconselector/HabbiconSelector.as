package com.sulake.habbo.ui.widget.chatinput.habbiconselector
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.habbicons.HabbiconControllerEvent;
   import com.sulake.habbo.catalog.habbicons.IHabbiconController;
   import com.sulake.habbo.communication.messages.outgoing.habbicons.TriggerHabbiconMessageComposer;
   import com.sulake.habbo.communication.messages.parser.habbicons.UnknownHabboCommunicationMessagesParserHabbicons1;
   import com.sulake.habbo.communication.messages.parser.habbicons.UnknownHabboCommunicationMessagesParserHabbicons2;
   import com.sulake.habbo.communication.messages.parser.habbicons.UnknownHabboCommunicationMessagesParserHabbicons3;
   import com.sulake.habbo.habbicons.assets.HabbiconAssetManager;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.widget.chatinput.RoomChatInputView;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class HabbiconSelector
   {
      private static const SCREEN_LEFT_BORDER:int = 92;
      
      private static const CHAT_BAR_POPUP_OFFSET:int = 55;
      
      private static const MENU_MIN_HEIGHT:int = 91;
      
      private static const MENU_MAX_HEIGHT:int = 292;
      
      private static const TOP_BAR_HEIGHT:int = 42;
      
      private static const BOTTOM_PADDING:int = 6;
      
      private static const GRID_COLUMNS:int = 5;
      
      private static const SLOT_SIZE:int = 42;
      
      private static const SLOT_SPACING:int = 2;
      
      private static const SLOT_FILLED_COLOR:uint = 4280229663;
      
      private static const SLOT_EMPTY_COLOR:uint = 4281611316;
      
      private static const SLOT_FILLED_HOVER_COLOR:uint = 4280953386;
      
      private static const RECENT_LIMIT:int = 10;
      
      private static const SECTION_FAVORITES:String = "favorites";
      
      private static const UnknownConstFromHabbiconSelector_String_1:String = "recent";
      
      private static const UnknownConstFromHabbiconSelector_String_2:String = "collection";
      
      private static const SECTION_SEARCH:String = "search";
      
      private var UnknownVarFromHabbiconSelector_RoomChatInputView_1:RoomChatInputView;
      
      private var UnknownVarFromHabbiconSelector_IHabbiconController_1:IHabbiconController;
      
      private var _window:UnknownICoreWindowComponents6;
      
      private var UnknownVarFromHabbiconSelector_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromHabbiconSelector_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromHabbiconSelector_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromHabbiconSelector_IWindowController_1_2:IWindowController_1;
      
      private var UnknownVarFromHabbiconSelector_ITextFieldWindow_1:ITextFieldWindow;
      
      private var UnknownVarFromHabbiconSelector_ITextWindow_1:ITextWindow;
      
      private var UnknownVarFromHabbiconSelector_IWindowModel_2:IWindowModel;
      
      private var UnknownVarFromHabbiconSelector_IWindowModel_3:IWindowModel;
      
      private var _emptyView:IWindowController_1;
      
      private var UnknownVarFromHabbiconSelector_Array_1:Array;
      
      private var _ownedSearchEntries:Array;
      
      private var UnknownVarFromHabbiconSelector_Dictionary_1:Dictionary;
      
      private var UnknownVarFromHabbiconSelector_Array_2:Array;
      
      private var UnknownVarFromHabbiconSelector_Dictionary_2:Dictionary;
      
      private var UnknownVarFromHabbiconSelector_Dictionary_3:Dictionary;
      
      private var UnknownVarFromHabbiconSelector_Boolean_1:Boolean = true;
      
      private var UnknownVarFromHabbiconSelector_Boolean_2:Boolean = true;
      
      private var UnknownVarFromHabbiconSelector_Boolean_3:Boolean;
      
      private var UnknownVarFromHabbiconSelector_String_1:String;
      
      public function HabbiconSelector(param1:RoomChatInputView, param2:IWindowModel, param3:IWindowController_1)
      {
         var _loc4_:IAssetLibraryCollection = null;
         super();
         UnknownVarFromHabbiconSelector_RoomChatInputView_1 = param1;
         UnknownVarFromHabbiconSelector_IHabbiconController_1 = !!param1.widget.roomUi ? param1.widget.roomUi.habbiconController : null;
         UnknownVarFromHabbiconSelector_IWindowModel_1 = param2;
         UnknownVarFromHabbiconSelector_IWindowController_1_1 = param3;
         UnknownVarFromHabbiconSelector_Array_1 = [];
         _ownedSearchEntries = [];
         UnknownVarFromHabbiconSelector_Dictionary_1 = new Dictionary();
         UnknownVarFromHabbiconSelector_Array_2 = [];
         UnknownVarFromHabbiconSelector_Dictionary_2 = new Dictionary(true);
         UnknownVarFromHabbiconSelector_Dictionary_3 = new Dictionary(true);
         _loc4_ = param1.widget.assets;
         _window = UnknownICoreWindowComponents6(param1.widget.windowManager.buildFromXML(XML(_loc4_.getAssetByName("habbiconselector_menu_xml").content)));
         _window.visible = false;
         UnknownVarFromHabbiconSelector_IWindowController_1_1.addChild(_window);
         UnknownVarFromHabbiconSelector_IItemListWindow_1 = IItemListWindow(_window.findChildByName("habbicon_section_list"));
         UnknownVarFromHabbiconSelector_IWindowController_1_2 = IWindowController_1(UnknownVarFromHabbiconSelector_IItemListWindow_1.removeListItem(UnknownVarFromHabbiconSelector_IItemListWindow_1.getListItemByName("habbicon_section_template")));
         UnknownVarFromHabbiconSelector_ITextFieldWindow_1 = ITextFieldWindow(_window.findChildByName("habbicon_search_input"));
         UnknownVarFromHabbiconSelector_ITextWindow_1 = ITextWindow(_window.findChildByName("habbicon_search_placeholder"));
         UnknownVarFromHabbiconSelector_IWindowModel_2 = _window.findChildByName("habbicon_search_clear_button");
         UnknownVarFromHabbiconSelector_IWindowModel_3 = _window.findChildByName("habbicon_open_hub_button");
         _emptyView = _window.findChildByName("empty_view") as IWindowController_1;
         if(UnknownVarFromHabbiconSelector_ITextFieldWindow_1)
         {
            UnknownVarFromHabbiconSelector_ITextFieldWindow_1.addEventListener("WE_CHANGE",onSearchChanged);
            UnknownVarFromHabbiconSelector_ITextFieldWindow_1.addEventListener("WKE_KEY_DOWN",onSearchKeyDown);
         }
         if(UnknownVarFromHabbiconSelector_ITextWindow_1)
         {
            UnknownVarFromHabbiconSelector_ITextWindow_1.addEventListener("WME_DOWN",onSearchPlaceholderDown);
         }
         if(UnknownVarFromHabbiconSelector_IWindowModel_2)
         {
            UnknownVarFromHabbiconSelector_IWindowModel_2.addEventListener("WME_CLICK",onSearchClearClicked);
         }
         if(UnknownVarFromHabbiconSelector_IWindowModel_3)
         {
            UnknownVarFromHabbiconSelector_IWindowModel_3.addEventListener("WME_CLICK",onOpenHubClicked);
         }
         if(UnknownVarFromHabbiconSelector_IHabbiconController_1)
         {
            UnknownVarFromHabbiconSelector_IHabbiconController_1.addEventListener("hce_owned_habbicons_updated",onControllerDataUpdated);
            UnknownVarFromHabbiconSelector_IHabbiconController_1.addEventListener("hce_shop_data_updated",onControllerDataUpdated);
            UnknownVarFromHabbiconSelector_IHabbiconController_1.addEventListener("hce_recent_habbicons_updated",onRecentHabbiconsUpdated);
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
      
      public function dispose() : void
      {
         if(UnknownVarFromHabbiconSelector_IHabbiconController_1)
         {
            UnknownVarFromHabbiconSelector_IHabbiconController_1.removeEventListener("hce_owned_habbicons_updated",onControllerDataUpdated);
            UnknownVarFromHabbiconSelector_IHabbiconController_1.removeEventListener("hce_shop_data_updated",onControllerDataUpdated);
            UnknownVarFromHabbiconSelector_IHabbiconController_1.removeEventListener("hce_recent_habbicons_updated",onRecentHabbiconsUpdated);
            UnknownVarFromHabbiconSelector_IHabbiconController_1 = null;
         }
         if(UnknownVarFromHabbiconSelector_ITextFieldWindow_1)
         {
            UnknownVarFromHabbiconSelector_ITextFieldWindow_1.removeEventListener("WE_CHANGE",onSearchChanged);
            UnknownVarFromHabbiconSelector_ITextFieldWindow_1.removeEventListener("WKE_KEY_DOWN",onSearchKeyDown);
            UnknownVarFromHabbiconSelector_ITextFieldWindow_1 = null;
         }
         if(UnknownVarFromHabbiconSelector_ITextWindow_1)
         {
            UnknownVarFromHabbiconSelector_ITextWindow_1.removeEventListener("WME_DOWN",onSearchPlaceholderDown);
            UnknownVarFromHabbiconSelector_ITextWindow_1 = null;
         }
         if(UnknownVarFromHabbiconSelector_IWindowModel_2)
         {
            UnknownVarFromHabbiconSelector_IWindowModel_2.removeEventListener("WME_CLICK",onSearchClearClicked);
            UnknownVarFromHabbiconSelector_IWindowModel_2 = null;
         }
         if(UnknownVarFromHabbiconSelector_IWindowModel_3)
         {
            UnknownVarFromHabbiconSelector_IWindowModel_3.removeEventListener("WME_CLICK",onOpenHubClicked);
            UnknownVarFromHabbiconSelector_IWindowModel_3 = null;
         }
         clearSections();
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         UnknownVarFromHabbiconSelector_IItemListWindow_1 = null;
         UnknownVarFromHabbiconSelector_IWindowController_1_2 = null;
         _ownedSearchEntries = null;
         UnknownVarFromHabbiconSelector_Dictionary_1 = null;
         UnknownVarFromHabbiconSelector_IWindowModel_1 = null;
         UnknownVarFromHabbiconSelector_IWindowController_1_1 = null;
         UnknownVarFromHabbiconSelector_RoomChatInputView_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _window == null;
      }
      
      public function get visible() : Boolean
      {
         return _window != null && Boolean(_window.visible);
      }
      
      public function toggle() : void
      {
         if(!_window)
         {
            return;
         }
         if(_window.visible)
         {
            hide();
            return;
         }
         _window.visible = true;
         if(_window.visible)
         {
            applyDeferredRecentSectionUpdate();
            renderIfDirty();
            alignToAnchor();
            focusSearch();
         }
      }
      
      public function hide(param1:Boolean = true) : void
      {
         if(_window && _window.visible)
         {
            _window.visible = false;
            if(param1 && UnknownVarFromHabbiconSelector_IHabbiconController_1)
            {
               UnknownVarFromHabbiconSelector_IHabbiconController_1.resetUnseenHabbicons();
               invalidateLayout();
            }
         }
      }
      
      public function containsWindow(param1:IWindowModel) : Boolean
      {
         return isWindowInTree(param1,_window);
      }
      
      public function focusSearch() : void
      {
         if(UnknownVarFromHabbiconSelector_ITextFieldWindow_1)
         {
            UnknownVarFromHabbiconSelector_ITextFieldWindow_1.focus();
         }
      }
      
      public function alignToAnchor() : void
      {
         var _loc2_:Rectangle = null;
         var _loc1_:IWindowController_1 = null;
         var _loc3_:Point = null;
         if(!_window || !_window.visible || !UnknownVarFromHabbiconSelector_IWindowModel_1 || !_window.parent)
         {
            return;
         }
         _loc2_ = new Rectangle();
         UnknownVarFromHabbiconSelector_IWindowModel_1.getGlobalRectangle(_loc2_);
         _loc1_ = IWindowController_1(_window.parent);
         _loc1_.x = _loc2_.x;
         _loc1_.y = _loc2_.bottom - 55 - _window.height;
         _loc3_ = new Point();
         _loc1_.getGlobalPosition(_loc3_);
         if(_loc3_.x < 92)
         {
            _loc1_.x += 92 - _loc3_.x;
         }
         if(_loc1_.y < 0)
         {
            _loc1_.y = 0;
         }
      }
      
      private function onControllerDataUpdated(param1:Event) : void
      {
         invalidateSections();
         if(_window && _window.visible)
         {
            renderIfDirty();
            alignToAnchor();
         }
      }
      
      private function onRecentHabbiconsUpdated(param1:HabbiconControllerEvent) : void
      {
         var _loc2_:int = 0;
         if(!addRecentHabbicon(param1.habbiconId))
         {
            return;
         }
         if(_window && _window.visible)
         {
            UnknownVarFromHabbiconSelector_Boolean_3 = true;
            return;
         }
         if(UnknownVarFromHabbiconSelector_Boolean_1)
         {
            return;
         }
         _loc2_ = recentSectionIndex();
         if(!refreshRecentSectionState())
         {
            return;
         }
         if(!_window || !_window.visible || normalizedQuery().length > 0)
         {
            UnknownVarFromHabbiconSelector_Boolean_2 = true;
            return;
         }
         renderRecentSection(_loc2_);
         alignToAnchor();
      }
      
      private function applyDeferredRecentSectionUpdate() : void
      {
         if(!UnknownVarFromHabbiconSelector_Boolean_3)
         {
            return;
         }
         UnknownVarFromHabbiconSelector_Boolean_3 = false;
         if(UnknownVarFromHabbiconSelector_Boolean_1)
         {
            return;
         }
         if(refreshRecentSectionState())
         {
            UnknownVarFromHabbiconSelector_Boolean_2 = true;
         }
      }
      
      private function invalidateSections() : void
      {
         UnknownVarFromHabbiconSelector_Boolean_1 = true;
         UnknownVarFromHabbiconSelector_Boolean_2 = true;
      }
      
      private function invalidateLayout() : void
      {
         UnknownVarFromHabbiconSelector_Boolean_2 = true;
      }
      
      private function renderIfDirty() : void
      {
         var _loc1_:String = normalizedQuery();
         if(UnknownVarFromHabbiconSelector_String_1 != _loc1_)
         {
            UnknownVarFromHabbiconSelector_Boolean_2 = true;
         }
         if(!UnknownVarFromHabbiconSelector_Boolean_1 && !UnknownVarFromHabbiconSelector_Boolean_2)
         {
            setSearchState(_loc1_.length > 0);
            return;
         }
         if(UnknownVarFromHabbiconSelector_Boolean_1)
         {
            refreshSections();
            UnknownVarFromHabbiconSelector_Boolean_1 = false;
         }
         refresh(_loc1_);
         UnknownVarFromHabbiconSelector_String_1 = _loc1_;
         UnknownVarFromHabbiconSelector_Boolean_2 = false;
      }
      
      private function refreshSections() : void
      {
         var _loc4_:Array = null;
         var _loc3_:* = null;
         var _loc2_:HabbiconSelectorEntry = null;
         var _loc1_:Array = [];
         var _loc5_:Array = [];
         UnknownVarFromHabbiconSelector_Array_1 = [];
         _ownedSearchEntries = [];
         UnknownVarFromHabbiconSelector_Dictionary_1 = new Dictionary();
         if(UnknownVarFromHabbiconSelector_IHabbiconController_1 == null)
         {
            return;
         }
         syncRecentHabbiconIds();
         _loc4_ = UnknownVarFromHabbiconSelector_IHabbiconController_1.ownedHabbicons;
         for each(_loc3_ in _loc4_)
         {
            _loc2_ = createEntry(_loc3_);
            if(_loc2_ != null)
            {
               UnknownVarFromHabbiconSelector_Dictionary_1[_loc2_.habbiconId] = _loc2_;
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
            UnknownVarFromHabbiconSelector_Array_1.push(new HabbiconSelectorSection("favorites","favorites",localize("habbicons.favourites.title","Favorites"),_loc1_));
         }
         if(_loc5_.length > 0)
         {
            UnknownVarFromHabbiconSelector_Array_1.push(new HabbiconSelectorSection("recent","recent",localize("habbicon.recently.used","Recently used"),_loc5_));
         }
         addOwnedSetSections();
      }
      
      private function addOwnedSetSections() : void
      {
         var _loc3_:* = undefined;
         var _loc5_:* = null;
         var _loc2_:Array = null;
         var _loc4_:* = null;
         var _loc1_:HabbiconSelectorEntry = null;
         if(UnknownVarFromHabbiconSelector_IHabbiconController_1 == null || !UnknownVarFromHabbiconSelector_IHabbiconController_1.hasLoadedShopData)
         {
            return;
         }
         _loc3_ = UnknownVarFromHabbiconSelector_IHabbiconController_1.shopCollections;
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
                        _loc1_ = UnknownVarFromHabbiconSelector_Dictionary_1[_loc4_.habbiconId] as HabbiconSelectorEntry;
                        if(_loc1_ != null)
                        {
                           _loc2_.push(_loc1_);
                        }
                     }
                  }
               }
               if(_loc5_.UnknownVarFromUnknownHabboCommunicationMessagesParserHabbicons3_Int_1 > 0)
               {
                  _loc1_ = UnknownVarFromHabbiconSelector_Dictionary_1[_loc5_.UnknownVarFromUnknownHabboCommunicationMessagesParserHabbicons3_Int_1] as HabbiconSelectorEntry;
                  if(_loc1_ != null)
                  {
                     _loc2_.push(_loc1_);
                  }
               }
               if(_loc2_.length > 0)
               {
                  UnknownVarFromHabbiconSelector_Array_1.push(new HabbiconSelectorSection("collection","collection:" + _loc5_.collectionId,resolveCollectionTitle(_loc5_),_loc2_));
               }
            }
         }
      }
      
      private function buildRecentEntries() : Array
      {
         var _loc1_:int = 0;
         var _loc2_:HabbiconSelectorEntry = null;
         var _loc3_:Array = [];
         for each(_loc1_ in UnknownVarFromHabbiconSelector_Array_2)
         {
            _loc2_ = UnknownVarFromHabbiconSelector_Dictionary_1[_loc1_] as HabbiconSelectorEntry;
            if(_loc2_ != null)
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      private function refreshRecentSectionState() : Boolean
      {
         var _loc2_:HabbiconSelectorSection = null;
         var _loc3_:Array = buildRecentEntries();
         var _loc1_:int = recentSectionIndex();
         if(_loc1_ >= 0)
         {
            _loc2_ = UnknownVarFromHabbiconSelector_Array_1[_loc1_] as HabbiconSelectorSection;
            if(sameEntries(_loc2_.entries,_loc3_))
            {
               return false;
            }
         }
         if(_loc3_.length == 0)
         {
            if(_loc1_ >= 0)
            {
               UnknownVarFromHabbiconSelector_Array_1.splice(_loc1_,1);
               return true;
            }
            return false;
         }
         if(_loc1_ >= 0)
         {
            _loc2_.entries = _loc3_;
            return true;
         }
         UnknownVarFromHabbiconSelector_Array_1.splice(recentInsertIndex(),0,new HabbiconSelectorSection("recent","recent",localize("habbicon.recently.used","Recently used"),_loc3_));
         return true;
      }
      
      private function renderRecentSection(param1:int) : void
      {
         var _loc4_:HabbiconSelectorSection = null;
         var _loc3_:IWindowModel = null;
         var _loc2_:int = recentSectionIndex();
         var _loc5_:Number = Number(UnknownVarFromHabbiconSelector_IItemListWindow_1.scrollV);
         if(param1 >= 0 && param1 < UnknownVarFromHabbiconSelector_IItemListWindow_1.numListItems)
         {
            _loc3_ = UnknownVarFromHabbiconSelector_IItemListWindow_1.removeListItemAt(param1);
            if(_loc3_ != null)
            {
               _loc3_.dispose();
            }
         }
         if(_loc2_ >= 0)
         {
            _loc4_ = UnknownVarFromHabbiconSelector_Array_1[_loc2_] as HabbiconSelectorSection;
            addSectionAt(_loc2_,_loc4_);
         }
         _emptyView.visible = UnknownVarFromHabbiconSelector_Array_1.length == 0;
         updateHeight();
         UnknownVarFromHabbiconSelector_IItemListWindow_1.scrollV = _loc5_;
      }
      
      private function recentSectionIndex() : int
      {
         var _loc1_:int = 0;
         var _loc2_:HabbiconSelectorSection = null;
         _loc1_ = 0;
         while(_loc1_ < UnknownVarFromHabbiconSelector_Array_1.length)
         {
            _loc2_ = UnknownVarFromHabbiconSelector_Array_1[_loc1_] as HabbiconSelectorSection;
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
         var _loc1_:HabbiconSelectorSection = UnknownVarFromHabbiconSelector_Array_1.length > 0 ? UnknownVarFromHabbiconSelector_Array_1[0] as HabbiconSelectorSection : null;
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
      
      private function createEntry(param1:UnknownHabboCommunicationMessagesParserHabbicons1) : HabbiconSelectorEntry
      {
         var _loc3_:int = 0;
         var _loc2_:String = null;
         if(param1 == null)
         {
            return null;
         }
         _loc3_ = param1.habbiconState;
         if(_loc3_ != 2 && _loc3_ != 3)
         {
            return null;
         }
         _loc2_ = resolveEntryName(param1.habbiconId);
         return new HabbiconSelectorEntry(param1.habbiconId,_loc2_,seededColor(param1.habbiconId * 37),_loc3_ == 3);
      }
      
      private function resolveEntryName(param1:int) : String
      {
         var _loc2_:String = HabbiconAssetManager.getHabbiconNameKey(param1);
         return _loc2_ != null && _loc2_.length > 0 ? localize("habbicon_" + _loc2_ + "_name",_loc2_) : "Habbicon";
      }
      
      private function resolveCollectionTitle(param1:UnknownHabboCommunicationMessagesParserHabbicons3) : String
      {
         if(param1 == null || param1.name == null || param1.name.length == 0)
         {
            return "Habbicons";
         }
         return localize("habbicon_collection_" + param1.name + "_name",param1.name);
      }
      
      private function localize(param1:String, param2:String) : String
      {
         var _loc3_:IHabboLocalizationManager = UnknownVarFromHabbiconSelector_RoomChatInputView_1 != null && UnknownVarFromHabbiconSelector_RoomChatInputView_1.widget != null ? UnknownVarFromHabbiconSelector_RoomChatInputView_1.widget.localizations : null;
         var _loc4_:String = _loc3_ != null ? _loc3_.getLocalization(param1,param2) : param2;
         return _loc4_ != null && _loc4_.length > 0 ? _loc4_ : param2;
      }
      
      private function sortEntries(param1:Array) : void
      {
         var entries:Array = param1;
         entries.sort(function(param1:HabbiconSelectorEntry, param2:HabbiconSelectorEntry):int
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
      
      private function refresh(param1:String = null) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc3_:Array = null;
         var _loc2_:* = null;
         clearSections();
         if(param1 == null)
         {
            param1 = normalizedQuery();
         }
         setSearchState(param1.length > 0);
         _loc4_ = 0;
         if(param1.length > 0)
         {
            _loc4_ = addSearchResultsSection(param1);
            _emptyView.visible = _loc4_ == 0;
            updateHeight();
            return;
         }
         for each(_loc5_ in UnknownVarFromHabbiconSelector_Array_1)
         {
            _loc3_ = [];
            for each(_loc2_ in _loc5_.entries)
            {
               if(param1.length == 0 || _loc2_.searchName.indexOf(param1) >= 0)
               {
                  _loc3_.push(_loc2_);
               }
            }
            if(_loc3_.length != 0)
            {
               addSection(new HabbiconSelectorSection(_loc5_.type,_loc5_.key,_loc5_.title,_loc3_));
               _loc4_++;
            }
         }
         _emptyView.visible = _loc4_ == 0;
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
         addSection(new HabbiconSelectorSection("search","search",localize("habbicon.search.results","Search results"),_loc3_));
         return 1;
      }
      
      private function clearSections() : void
      {
         var _loc1_:IWindowModel = null;
         if(!UnknownVarFromHabbiconSelector_IItemListWindow_1)
         {
            return;
         }
         UnknownVarFromHabbiconSelector_Dictionary_2 = new Dictionary(true);
         UnknownVarFromHabbiconSelector_Dictionary_3 = new Dictionary(true);
         while(UnknownVarFromHabbiconSelector_IItemListWindow_1.numListItems > 0)
         {
            _loc1_ = UnknownVarFromHabbiconSelector_IItemListWindow_1.removeListItemAt(0);
            if(_loc1_)
            {
               _loc1_.dispose();
            }
         }
      }
      
      private function addSection(param1:HabbiconSelectorSection) : void
      {
         UnknownVarFromHabbiconSelector_IItemListWindow_1.addListItem(createSectionWindow(param1));
      }
      
      private function addSectionAt(param1:int, param2:HabbiconSelectorSection) : void
      {
         UnknownVarFromHabbiconSelector_IItemListWindow_1.addListItemAt(createSectionWindow(param2),param1);
      }
      
      private function createSectionWindow(param1:HabbiconSelectorSection) : IWindowController_1
      {
         var _loc6_:IWindowController_1 = null;
         var _loc12_:ITextWindow = null;
         var _loc15_:IItemGridWindow = null;
         var _loc2_:IWindowController_1 = null;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc14_:int = 0;
         var _loc7_:int = 0;
         var _loc10_:HabbiconSelectorEntry = null;
         var _loc11_:IRegionWindow = null;
         var _loc5_:IBitmapWrapperController = null;
         var _loc3_:UnknownICoreWindowComponents6 = null;
         var _loc13_:IWindowController_1 = null;
         var _loc9_:ITextWindow = null;
         _loc6_ = UnknownVarFromHabbiconSelector_IWindowController_1_2.clone() as IWindowController_1;
         _loc6_.visible = true;
         _loc12_ = ITextWindow(_loc6_.findChildByName("section_title"));
         _loc12_.caption = param1.title;
         _loc15_ = IItemGridWindow(_loc6_.findChildByName("habbicon_grid"));
         _loc2_ = _loc15_.getGridItemAt(0) as IWindowController_1;
         _loc15_.removeGridItems();
         _loc4_ = int(param1.entries.length);
         _loc8_ = Math.max(1,Math.ceil(_loc4_ / 5));
         _loc14_ = _loc8_ * 5;
         _loc7_ = 0;
         while(_loc7_ < _loc14_)
         {
            _loc10_ = _loc7_ < _loc4_ ? param1.entries[_loc7_] : null;
            _loc11_ = _loc2_.clone() as IRegionWindow;
            _loc11_.toolTipCaption = !!_loc10_ ? _loc10_.name : "";
            addWheelListeners(_loc11_);
            _loc5_ = IBitmapWrapperController(_loc11_.findChildByName("habbicon_icon"));
            if(_loc5_)
            {
               addWheelListeners(_loc5_);
               if(_loc5_.bitmap)
               {
                  _loc5_.bitmap.dispose();
                  _loc5_.bitmap = null;
               }
               if(_loc10_)
               {
                  _loc5_.bitmap = createHabbiconBitmap(_loc10_.habbiconId,_loc10_.color);
                  _loc5_.visible = true;
                  _loc5_.invalidate();
               }
               else
               {
                  _loc5_.visible = false;
               }
            }
            if(_loc10_)
            {
               _loc11_.addEventListener("WME_CLICK",onHabbiconClicked);
               _loc11_.addEventListener("WME_OVER",onHabbiconHovered);
               _loc11_.addEventListener("WME_OUT",onHabbiconOut);
            }
            _loc11_.mouseThreshold = !!_loc10_ ? 0 : 10;
            _loc3_ = UnknownICoreWindowComponents6(_loc11_.findChildByName("habbicon_item_bg"));
            if(_loc3_)
            {
               addWheelListeners(_loc3_);
               _loc3_.color = !!_loc10_ ? 4280229663 : 4281611316;
            }
            if(_loc10_ && isUnseen(_loc10_.habbiconId))
            {
               _loc13_ = UnknownVarFromHabbiconSelector_RoomChatInputView_1.widget.windowManager.createUnseenItemCounter();
               _loc9_ = _loc13_.findChildByName("count") as ITextWindow;
               if(_loc9_)
               {
                  _loc9_.caption = "1";
               }
               _loc13_.x = _loc11_.width - _loc13_.width - 1;
               _loc13_.y = 1;
               _loc11_.addChild(_loc13_);
            }
            _loc15_.addGridItem(_loc11_);
            UnknownVarFromHabbiconSelector_Dictionary_3[_loc11_] = true;
            if(_loc10_)
            {
               UnknownVarFromHabbiconSelector_Dictionary_2[_loc11_] = _loc10_;
            }
            _loc7_++;
         }
         _loc15_.height = _loc8_ * 42 + (_loc8_ - 1) * 2;
         _loc6_.height = 20 + _loc15_.height + 2;
         _loc2_.dispose();
         return _loc6_;
      }
      
      private function updateHeight() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(!_window || !UnknownVarFromHabbiconSelector_IItemListWindow_1)
         {
            return;
         }
         _loc3_ = int(UnknownVarFromHabbiconSelector_IItemListWindow_1.scrollableRegion.height);
         _loc1_ = Math.max(46,_loc3_ + 2);
         _loc2_ = 292 - 42 - 6;
         _loc1_ = Math.min(_loc1_,_loc2_);
         UnknownVarFromHabbiconSelector_IItemListWindow_1.height = _loc1_;
         _window.height = Math.max(91,42 + _loc1_ + 6);
         _window.invalidate();
      }
      
      private function normalizedQuery() : String
      {
         var _loc1_:String = null;
         if(!UnknownVarFromHabbiconSelector_ITextFieldWindow_1)
         {
            return "";
         }
         _loc1_ = UnknownVarFromHabbiconSelector_ITextFieldWindow_1.text;
         if(!_loc1_)
         {
            return "";
         }
         return _loc1_.toLowerCase();
      }
      
      private function onSearchPlaceholderDown(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromHabbiconSelector_ITextFieldWindow_1)
         {
            UnknownVarFromHabbiconSelector_ITextFieldWindow_1.focus();
         }
      }
      
      private function onSearchChanged(param1:WindowEvent) : void
      {
         invalidateLayout();
         renderIfDirty();
         alignToAnchor();
      }
      
      private function onSearchKeyDown(param1:WindowKeyboardEvent) : void
      {
         if(param1.keyCode != 27 || UnknownVarFromHabbiconSelector_ITextFieldWindow_1.text.length == 0)
         {
            return;
         }
         clearSearch();
      }
      
      private function onSearchClearClicked(param1:WindowMouseEvent) : void
      {
         clearSearch();
      }
      
      private function clearSearch() : void
      {
         if(UnknownVarFromHabbiconSelector_ITextFieldWindow_1)
         {
            UnknownVarFromHabbiconSelector_ITextFieldWindow_1.text = "";
         }
         invalidateLayout();
         renderIfDirty();
         alignToAnchor();
      }
      
      private function onOpenHubClicked(param1:WindowMouseEvent) : void
      {
         UnknownVarFromHabbiconSelector_RoomChatInputView_1.openHabbiconHub();
         hide();
      }
      
      private function onHabbiconClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:HabbiconSelectorEntry = resolveEntry(param1.window);
         if(!_loc2_)
         {
            return;
         }
         if(UnknownVarFromHabbiconSelector_IHabbiconController_1)
         {
            UnknownVarFromHabbiconSelector_IHabbiconController_1.removeUnseenHabbicon(_loc2_.habbiconId);
            UnknownVarFromHabbiconSelector_IHabbiconController_1.noteHabbiconUsed(_loc2_.habbiconId);
         }
         else if(addRecentHabbicon(_loc2_.habbiconId))
         {
            UnknownVarFromHabbiconSelector_Boolean_3 = true;
         }
         sendTriggerHabbicon(_loc2_.habbiconId);
         if(!param1.shiftKey)
         {
            hide(false);
         }
      }
      
      private function sendTriggerHabbicon(param1:int) : void
      {
         UnknownVarFromHabbiconSelector_RoomChatInputView_1.widget.handler.container.connection.send(new TriggerHabbiconMessageComposer(param1));
      }
      
      private function isUnseen(param1:int) : Boolean
      {
         return UnknownVarFromHabbiconSelector_IHabbiconController_1 != null && UnknownVarFromHabbiconSelector_IHabbiconController_1.isUnseenHabbicon(param1);
      }
      
      private function syncRecentHabbiconIds() : void
      {
         var _loc2_:Array = null;
         var _loc1_:int = 0;
         if(UnknownVarFromHabbiconSelector_IHabbiconController_1 == null)
         {
            return;
         }
         _loc2_ = UnknownVarFromHabbiconSelector_IHabbiconController_1.recentHabbiconIds;
         UnknownVarFromHabbiconSelector_Array_2 = [];
         for each(_loc1_ in _loc2_)
         {
            UnknownVarFromHabbiconSelector_Array_2.push(_loc1_);
         }
      }
      
      private function addRecentHabbicon(param1:int) : Boolean
      {
         var _loc2_:int = int(UnknownVarFromHabbiconSelector_Array_2.indexOf(param1));
         if(param1 <= 0 || _loc2_ == 0)
         {
            return false;
         }
         if(_loc2_ >= 0)
         {
            UnknownVarFromHabbiconSelector_Array_2.splice(_loc2_,1);
         }
         UnknownVarFromHabbiconSelector_Array_2.unshift(param1);
         if(UnknownVarFromHabbiconSelector_Array_2.length > 10)
         {
            UnknownVarFromHabbiconSelector_Array_2.length = 10;
         }
         return true;
      }
      
      private function addWheelListeners(param1:IWindowModel) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("WME_WHEEL",onSelectorWheel);
         param1.addEventListener("WME_WHEEL_HORIZONTAL",onSelectorWheel);
      }
      
      private function onSelectorWheel(param1:WindowMouseEvent) : void
      {
         var _loc2_:Number = NaN;
         if(!UnknownVarFromHabbiconSelector_IItemListWindow_1)
         {
            return;
         }
         _loc2_ = Number(param1.type == "WME_WHEEL_HORIZONTAL" ? -param1.delta : param1.delta);
         if(UnknownVarFromHabbiconSelector_IItemListWindow_1.scrollWithWheel(_loc2_,param1.type == "WME_WHEEL_HORIZONTAL" || param1.shiftKey))
         {
            param1.stopPropagation();
         }
      }
      
      private function onHabbiconHovered(param1:WindowMouseEvent) : void
      {
         var _loc3_:UnknownICoreWindowComponents6 = null;
         var _loc2_:IWindowController_1 = resolveHabbiconWindow(param1.window);
         if(!_loc2_)
         {
            return;
         }
         _loc3_ = UnknownICoreWindowComponents6(_loc2_.findChildByName("habbicon_item_bg"));
         if(_loc3_)
         {
            _loc3_.color = 4280953386;
         }
      }
      
      private function onHabbiconOut(param1:WindowMouseEvent) : void
      {
         var _loc3_:UnknownICoreWindowComponents6 = null;
         var _loc2_:IWindowController_1 = resolveHabbiconWindow(param1.window);
         if(!_loc2_)
         {
            return;
         }
         _loc3_ = UnknownICoreWindowComponents6(_loc2_.findChildByName("habbicon_item_bg"));
         if(_loc3_)
         {
            _loc3_.color = !!UnknownVarFromHabbiconSelector_Dictionary_2[_loc2_] ? 4280229663 : 4281611316;
         }
      }
      
      private function resolveEntry(param1:IWindowModel) : HabbiconSelectorEntry
      {
         var _loc2_:IWindowController_1 = resolveHabbiconWindow(param1);
         return !!_loc2_ ? UnknownVarFromHabbiconSelector_Dictionary_2[_loc2_] as HabbiconSelectorEntry : null;
      }
      
      private function resolveHabbiconWindow(param1:IWindowModel) : IWindowController_1
      {
         var _loc2_:* = param1;
         while(_loc2_ != null)
         {
            if(_loc2_ is IWindowController_1 && UnknownVarFromHabbiconSelector_Dictionary_3[_loc2_] != null)
            {
               return IWindowController_1(_loc2_);
            }
            _loc2_ = _loc2_.parent;
         }
         return null;
      }
      
      private function setSearchState(param1:Boolean) : void
      {
         if(UnknownVarFromHabbiconSelector_ITextWindow_1)
         {
            UnknownVarFromHabbiconSelector_ITextWindow_1.visible = !param1;
         }
         if(UnknownVarFromHabbiconSelector_IWindowModel_2)
         {
            UnknownVarFromHabbiconSelector_IWindowModel_2.visible = param1;
         }
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
      
      private function createHabbiconBitmap(param1:int, param2:uint) : BitmapData
      {
         var _loc3_:BitmapData = HabbiconAssetManager.getPreviewBitmap(param1,false);
         if(_loc3_ != null)
         {
            return _loc3_.clone();
         }
         return new BitmapData(40,40,false,param2);
      }
   }
}

