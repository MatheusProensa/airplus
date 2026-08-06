package com.sulake.habbo.groups.badge_leaderboard
{
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class BadgeLeaderboardView implements IComponentInterfaceQueue
   {
      public static const DESKTOP_WINDOW_LAYER:uint = 1;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromBadgeLeaderboardView_BadgeLeaderboardController_1:BadgeLeaderboardController;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _window:IFrameController;
      
      private var _ownEntryView:BadgeLeaderboardEntryView;
      
      private var UnknownVarFromBadgeLeaderboardView_IWindowController_1_1:IWindowController_1;
      
      private var _entryViews:Vector.<BadgeLeaderboardEntryView>;
      
      private var UnknownVarFromBadgeLeaderboardView_Int_1:int;
      
      public function BadgeLeaderboardView(param1:BadgeLeaderboardController, param2:IHabboWindowManagerComponent)
      {
         super();
         UnknownVarFromBadgeLeaderboardView_BadgeLeaderboardController_1 = param1;
         _windowManager = param2;
         createWindow();
         hide();
      }
      
      private function createWindow() : void
      {
         var _loc4_:ISoundAsset = null;
         var _loc1_:XmlAsset = null;
         var _loc2_:int = 0;
         var _loc3_:BadgeLeaderboardEntryView = null;
         if(_window != null)
         {
            return;
         }
         _loc4_ = UnknownVarFromBadgeLeaderboardView_BadgeLeaderboardController_1.assets.getAssetByName("badge_leaderboard_view");
         _loc1_ = XmlAsset(_loc4_);
         _window = _windowManager.buildFromXML(XML(_loc1_.content),1) as IFrameController;
         UnknownVarFromBadgeLeaderboardView_Int_1 = rankTypeExtendedImage.y;
         closeButton.procedure = onClose;
         dropdownRegion.procedure = onDropdownOpen;
         dropdownOpener.procedure = onDropdownOpen;
         hiddenDropdown.procedure = onDropdownSelection;
         previousButton.procedure = onPreviousPage;
         nextButton.procedure = onNextPage;
         UnknownVarFromBadgeLeaderboardView_IWindowController_1_1 = rankingList.getListItemByName("entry_template") as IWindowController_1;
         rankingList.removeListItem(UnknownVarFromBadgeLeaderboardView_IWindowController_1_1);
         _entryViews = new Vector.<BadgeLeaderboardEntryView>();
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc3_ = new BadgeLeaderboardEntryView(UnknownVarFromBadgeLeaderboardView_IWindowController_1_1.clone() as IWindowController_1);
            _loc3_.profileRegion.id = _loc2_;
            _loc3_.profileRegion.procedure = onProfileClicked;
            _loc3_.window.visible = false;
            rankingList.addListItem(_loc3_.window);
            _entryViews.push(_loc3_);
            _loc2_++;
         }
         _ownEntryView = new BadgeLeaderboardEntryView(ownContainer,false,"rank_own");
         _ownEntryView.profileRegion.id = -1;
         _ownEntryView.profileRegion.procedure = onProfileClicked;
         ownContainer.visible = false;
      }
      
      private function onClose(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            hide();
         }
      }
      
      private function onDropdownOpen(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            UnknownVarFromBadgeLeaderboardView_BadgeLeaderboardController_1.onDropdownOpenClicked();
         }
      }
      
      private function onDropdownSelection(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WE_SELECTED")
         {
            UnknownVarFromBadgeLeaderboardView_BadgeLeaderboardController_1.onDropdownSelectionChanged(hiddenDropdown.selection);
         }
      }
      
      private function onPreviousPage(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            UnknownVarFromBadgeLeaderboardView_BadgeLeaderboardController_1.onPreviousPageClicked();
         }
      }
      
      private function onNextPage(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            UnknownVarFromBadgeLeaderboardView_BadgeLeaderboardController_1.onNextPageClicked();
         }
      }
      
      private function onProfileClicked(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            UnknownVarFromBadgeLeaderboardView_BadgeLeaderboardController_1.onProfileRegionClicked(param2.id);
         }
      }
      
      public function setDropdownOptions(param1:Array, param2:int) : void
      {
         hiddenDropdown.procedure = null;
         hiddenDropdown.populate(param1);
         hiddenDropdown.selection = param2;
         hiddenDropdown.procedure = onDropdownSelection;
      }
      
      public function setFrameStyle(param1:uint) : void
      {
         if(_window != null && _window.style != param1)
         {
            _window.style = param1;
         }
      }
      
      public function openDropdownMenu() : void
      {
         hiddenDropdown.openMenu();
         hiddenDropdown.activate();
      }
      
      public function setTitle(param1:String) : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in titleTexts)
         {
            _loc2_.text = param1;
         }
      }
      
      public function setInfo(param1:String, param2:String) : void
      {
         rankTypeExtendedImage.assetUri = param1;
         rankTypeInfoText.text = param2;
      }
      
      public function setRankTypeExtendedImageYOffset(param1:int) : void
      {
         rankTypeExtendedImage.y = UnknownVarFromBadgeLeaderboardView_Int_1 + param1;
      }
      
      public function setPagerEnabled(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            previousButton.enable();
         }
         else
         {
            previousButton.disable();
         }
         if(param2)
         {
            nextButton.enable();
         }
         else
         {
            nextButton.disable();
         }
      }
      
      public function setEntryVisible(param1:int, param2:Boolean) : void
      {
         if(param1 >= 0 && param1 < _entryViews.length)
         {
            _entryViews[param1].window.visible = param2;
         }
      }
      
      public function setOwnEntryVisible(param1:Boolean) : void
      {
         ownContainer.visible = param1;
      }
      
      public function hide() : void
      {
         var _loc1_:IDesktopController = null;
         if(!isShowing())
         {
            return;
         }
         _loc1_ = _windowManager.getDesktop(1);
         if(_loc1_ != null)
         {
            _loc1_.removeChild(_window);
         }
      }
      
      public function show() : void
      {
         var _loc1_:IDesktopController = null;
         if(_window == null)
         {
            return;
         }
         if(isShowing())
         {
            _window.activate();
            return;
         }
         _loc1_ = _windowManager.getDesktop(1);
         if(_loc1_ != null)
         {
            _loc1_.addChild(_window);
            if(_window.parent == _loc1_)
            {
               _window.center();
            }
            _window.activate();
         }
      }
      
      public function isShowing() : Boolean
      {
         return _window != null && _window.parent != null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         if(_disposed)
         {
            return;
         }
         hide();
         if(_entryViews != null)
         {
            for each(_loc1_ in _entryViews)
            {
               _loc1_.dispose();
            }
            _entryViews = null;
         }
         if(UnknownVarFromBadgeLeaderboardView_IWindowController_1_1 != null)
         {
            UnknownVarFromBadgeLeaderboardView_IWindowController_1_1.dispose();
            UnknownVarFromBadgeLeaderboardView_IWindowController_1_1 = null;
         }
         if(_ownEntryView != null)
         {
            _ownEntryView.dispose();
            _ownEntryView = null;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         UnknownVarFromBadgeLeaderboardView_BadgeLeaderboardController_1 = null;
         _windowManager = null;
         _disposed = true;
      }
      
      public function get closeButton() : IWindowModel
      {
         return _window.findChildByTag("close");
      }
      
      public function get frameTitleContainer() : IWindowController_1
      {
         return _window.findChildByName("hacky_title") as IWindowController_1;
      }
      
      public function get titleShadow0Text() : ITextWindow
      {
         return _window.findChildByName("title_txt_shadow_0") as ITextWindow;
      }
      
      public function get titleShadow1Text() : ITextWindow
      {
         return _window.findChildByName("title_txt_shadow_1") as ITextWindow;
      }
      
      public function get titleShadow2Text() : ITextWindow
      {
         return _window.findChildByName("title_txt_shadow_2") as ITextWindow;
      }
      
      public function get titleShadow3Text() : ITextWindow
      {
         return _window.findChildByName("title_txt_shadow_3") as ITextWindow;
      }
      
      public function get titleText() : ITextWindow
      {
         return _window.findChildByName("title_txt") as ITextWindow;
      }
      
      public function get titleTexts() : Vector.<ITextWindow>
      {
         return new <ITextWindow>[titleShadow0Text,titleShadow1Text,titleShadow2Text,titleShadow3Text,titleText];
      }
      
      public function get dropdownRegion() : IRegionWindow
      {
         return _window.findChildByName("dropdown_region") as IRegionWindow;
      }
      
      public function get dropdownOpener() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("dropdown_opener") as IStaticBitmapWrapperWindow;
      }
      
      public function get hiddenDropdown() : IDropBaseController_1
      {
         return _window.findChildByName("hidden_dropdown") as IDropBaseController_1;
      }
      
      public function get bodyContainer() : IWindowController_1
      {
         return _window.findChildByName("body") as IWindowController_1;
      }
      
      public function get infoContainer() : IWindowController_1
      {
         return _window.findChildByName("info_container") as IWindowController_1;
      }
      
      public function get rankTypeExtendedImage() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("rank_type_extended_img") as IStaticBitmapWrapperWindow;
      }
      
      public function get rankTypeInfoText() : ITextWindow
      {
         return _window.findChildByName("rank_type_info") as ITextWindow;
      }
      
      public function get rankingList() : IItemListWindow
      {
         return _window.findChildByName("ranking_list") as IItemListWindow;
      }
      
      public function get ownContainer() : IWindowController_1
      {
         return _window.findChildByName("own_container") as IWindowController_1;
      }
      
      public function get ownEntryView() : BadgeLeaderboardEntryView
      {
         return _ownEntryView;
      }
      
      public function get entryViews() : Vector.<BadgeLeaderboardEntryView>
      {
         return _entryViews;
      }
      
      public function get buttonsList() : IItemListWindow
      {
         return _window.findChildByName("buttons") as IItemListWindow;
      }
      
      public function get previousButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("previous_btn") as UnknownICoreWindowComponents4;
      }
      
      public function get nextButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("next_btn") as UnknownICoreWindowComponents4;
      }
   }
}

