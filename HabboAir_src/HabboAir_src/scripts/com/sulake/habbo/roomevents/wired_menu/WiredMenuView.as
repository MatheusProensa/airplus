package com.sulake.habbo.roomevents.wired_menu
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.roomevents.wired_menu.tabs.IWiredMenuDefaultTab;
   import com.sulake.habbo.roomevents.wired_menu.tabs.WiredMenuTabConfig;
   import com.sulake.habbo.roomevents.wired_menu.tabs.WiredMenuTabConfigs;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.utils.Dictionary;
   
   public class WiredMenuView implements IComponentInterfaceQueue
   {
      public static const DESKTOP_WINDOW_LAYER:uint = 1;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var UnknownVarFromWiredMenuView_WiredMenuController_1:WiredMenuController;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromWiredMenuView_WiredMenuTabConfigs_1:WiredMenuTabConfigs;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromWiredMenuView_Dictionary_1:Dictionary;
      
      private var _activeTabId:String = null;
      
      private var UnknownVarFromWiredMenuView_Boolean_1:Boolean = false;
      
      public function WiredMenuView(param1:WiredMenuController, param2:IHabboWindowManagerComponent)
      {
         super();
         UnknownVarFromWiredMenuView_WiredMenuController_1 = param1;
         _windowManager = param2;
         UnknownVarFromWiredMenuView_WiredMenuTabConfigs_1 = new WiredMenuTabConfigs(param1);
         _window = param2.buildFromXML(XML(UnknownVarFromWiredMenuView_WiredMenuController_1.assets.getAssetByName("wired_menu_view_xml").content),1) as IWindowController_1;
         closeButton.addEventListener("WME_CLICK",onWindowClose);
         discordRegion.addEventListener("WME_CLICK",onClickDiscord);
      }
      
      public function initialize() : void
      {
         initializeTabs();
      }
      
      public function show() : void
      {
         var _loc1_:IDesktopController = null;
         if(_windowManager != null && _window != null && _window.parent == null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(_window);
            }
         }
         if(!UnknownVarFromWiredMenuView_Boolean_1)
         {
            activeTab.startViewing();
            UnknownVarFromWiredMenuView_Boolean_1 = true;
         }
         _window.activate();
      }
      
      public function isShowing() : Boolean
      {
         return _windowManager != null && _window != null && _window.parent != null;
      }
      
      private function onWindowClose(param1:WindowEvent) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hide();
      }
      
      public function hide() : void
      {
         var _loc1_:IDesktopController = null;
         if(isShowing())
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
            if(UnknownVarFromWiredMenuView_Boolean_1)
            {
               activeTab.stopViewing();
               UnknownVarFromWiredMenuView_Boolean_1 = false;
            }
         }
      }
      
      private function initializeTabs() : void
      {
         var _loc2_:ITabButtonWindow = null;
         UnknownVarFromWiredMenuView_Dictionary_1 = new Dictionary();
         var _loc1_:* = null;
         for each(var _loc3_ in tabConfigs)
         {
            if(_loc3_.isCreateImmediately)
            {
               getOrCreateTab(_loc3_.id);
            }
            if(_loc1_ == null && _loc3_.isEnabled)
            {
               _loc1_ = _loc3_;
            }
            _loc2_ = _window.findChildByName(_loc3_.tabButtonName) as ITabButtonWindow;
            _loc2_.addEventListener("WE_SELECTED",onTabSelected);
            _window.findChildByName(_loc3_.containerName).visible = false;
         }
         selectTab(_loc1_.id);
         alignTabs();
      }
      
      public function selectTab(param1:String) : void
      {
         var _loc2_:WiredMenuTabConfig = getTabConfigById(param1);
         if(_loc2_ == null || !_loc2_.isEnabled)
         {
            return;
         }
         tabContext.selector.setSelected(ISelectableWindow(_window.findChildByName(_loc2_.tabButtonName)));
      }
      
      private function alignTabs() : void
      {
         var _loc2_:int = 0;
         var _loc3_:ITabButtonWindow = null;
         var _loc4_:WiredMenuTabConfig = null;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < tabContext.numTabItems)
         {
            _loc3_ = tabContext.getTabItemAt(_loc2_);
            _loc4_ = getTabConfigByTabName(_loc3_.name);
            if(_loc4_.isEnabled)
            {
               _loc1_ += 1;
            }
            else
            {
               _loc3_.visible = false;
               _loc3_.width = 0;
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < tabContext.numTabItems)
         {
            _loc3_ = tabContext.getTabItemAt(_loc2_);
            if(_loc3_.visible)
            {
               _loc3_.width = _loc3_.parent.width / _loc1_;
            }
            _loc2_++;
         }
      }
      
      private function onTabSelected(param1:WindowEvent) : void
      {
         var _loc2_:String = null;
         var _loc4_:IWindowModel = param1.target;
         for each(var _loc3_ in tabConfigs)
         {
            if(_loc3_.tabButtonName == _loc4_.name)
            {
               _loc2_ = _loc3_.id;
               break;
            }
         }
         setActiveTab(_loc2_);
      }
      
      private function setActiveTab(param1:String) : void
      {
         var _loc2_:IWiredMenuDefaultTab = null;
         var _loc5_:WiredMenuTabConfig = null;
         var _loc4_:WiredMenuTabConfig = getTabConfigById(param1);
         if(_loc4_.id == _activeTabId)
         {
            return;
         }
         if(_activeTabId != null)
         {
            _loc2_ = getTabById(_activeTabId);
            _loc5_ = getTabConfigById(_activeTabId);
            if(UnknownVarFromWiredMenuView_Boolean_1)
            {
               _loc2_.stopViewing();
            }
            _loc2_.setTabInactive();
            if(!_loc5_.isReusable)
            {
               _loc2_.dispose();
               delete UnknownVarFromWiredMenuView_Dictionary_1[_activeTabId];
            }
            _window.findChildByName(_loc5_.containerName).visible = false;
         }
         _activeTabId = param1;
         var _loc3_:IWiredMenuDefaultTab = getOrCreateTab(param1);
         _window.findChildByName(_loc4_.containerName).visible = true;
         _loc3_.setTabActive();
         if(UnknownVarFromWiredMenuView_Boolean_1)
         {
            _loc3_.startViewing();
         }
         headerTitle.text = UnknownVarFromWiredMenuView_WiredMenuController_1.localizationManager.getLocalization(_loc4_.titleLocalizationKey,_loc4_.id);
      }
      
      internal function permissionsUpdated() : void
      {
         for each(var _loc1_ in UnknownVarFromWiredMenuView_Dictionary_1)
         {
            _loc1_.permissionsUpdated();
         }
      }
      
      private function get tabConfigs() : Vector.<WiredMenuTabConfig>
      {
         return UnknownVarFromWiredMenuView_WiredMenuTabConfigs_1.menuTabs;
      }
      
      private function getTabConfigById(param1:String) : WiredMenuTabConfig
      {
         for each(var _loc2_ in tabConfigs)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function getTabConfigByTabName(param1:String) : WiredMenuTabConfig
      {
         for each(var _loc2_ in tabConfigs)
         {
            if(_loc2_.tabButtonName == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function getTabById(param1:String) : IWiredMenuDefaultTab
      {
         return UnknownVarFromWiredMenuView_Dictionary_1[param1];
      }
      
      public function get activeTab() : IWiredMenuDefaultTab
      {
         return getTabById(_activeTabId);
      }
      
      public function get activeTabId() : String
      {
         return _activeTabId;
      }
      
      private function getOrCreateTab(param1:String) : IWiredMenuDefaultTab
      {
         var _loc3_:WiredMenuTabConfig = getTabConfigById(param1);
         var _loc2_:IWiredMenuDefaultTab = UnknownVarFromWiredMenuView_Dictionary_1[param1];
         if(_loc2_ == null)
         {
            _loc2_ = _loc3_.createTab(UnknownVarFromWiredMenuView_WiredMenuController_1,_window.findChildByName(_loc3_.containerName) as IWindowController_1);
            UnknownVarFromWiredMenuView_Dictionary_1[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      private function onClickDiscord(param1:WindowMouseEvent) : void
      {
         HabboWebTools.openWebPageAndMinimizeClient(UnknownVarFromWiredMenuView_WiredMenuController_1.getProperty("wired.discord.link"));
      }
      
      public function dispose() : void
      {
         var _loc1_:IWiredMenuDefaultTab = null;
         var _loc2_:ITabButtonWindow = null;
         if(_disposed)
         {
            return;
         }
         hide();
         closeButton.removeEventListener("WME_CLICK",onWindowClose);
         for each(var _loc3_ in tabConfigs)
         {
            _loc1_ = getTabById(_loc3_.id);
            if(_loc1_ != null)
            {
               if(_loc3_.id == _activeTabId)
               {
                  if(UnknownVarFromWiredMenuView_Boolean_1)
                  {
                     _loc1_.stopViewing();
                  }
                  _loc1_.setTabInactive();
               }
               _loc1_.dispose();
            }
            _loc2_ = _window.findChildByName(_loc3_.tabButtonName) as ITabButtonWindow;
            _loc2_.removeEventListener("WE_SELECTED",onTabSelected);
         }
         UnknownVarFromWiredMenuView_Dictionary_1 = null;
         _activeTabId = null;
         UnknownVarFromWiredMenuView_Boolean_1 = false;
         _window.dispose();
         _window = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get closeButton() : IWindowModel
      {
         return _window.findChildByName("header_button_close");
      }
      
      private function get tabContext() : ITabContextWindow
      {
         return _window.findChildByName("tab_context") as ITabContextWindow;
      }
      
      private function get headerTitle() : ITextWindow
      {
         return _window.findChildByName("header_title") as ITextWindow;
      }
      
      public function get loadingContainer() : IWindowController_1
      {
         return _window.findChildByName("loading_view") as IWindowController_1;
      }
      
      public function get discordRegion() : IRegionWindow
      {
         return _window.findChildByName("discord_region") as IRegionWindow;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
   }
}

