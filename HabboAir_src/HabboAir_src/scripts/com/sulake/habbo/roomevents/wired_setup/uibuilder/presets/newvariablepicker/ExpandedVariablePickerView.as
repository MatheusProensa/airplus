package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.overview.VariableNode;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.overview.VariableNodeListView;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.tabbuttons.TabButtonConfig;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.tabbuttons.TabButtonConfigs;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.tabbuttons.TabButtonView;
   
   public class ExpandedVariablePickerView implements IComponentInterfaceQueue
   {
      private var _picker:NewVariablePicker;
      
      private var _window:IWindowController_1;
      
      private var _tabButtonTemplate:IRegionWindow;
      
      private var _overviewTemplate:UnknownICoreWindowComponents6;
      
      private var UnknownVarFromExpandedVariablePickerView_Vector_1:Vector.<TabButtonView>;
      
      private var UnknownVarFromExpandedVariablePickerView_TabButtonConfigs_1:TabButtonConfigs;
      
      private var _selectedTab:TabButtonView;
      
      private var _activeItemsView:VariableNodeListView;
      
      private var _disposed:Boolean = false;
      
      public function ExpandedVariablePickerView(param1:NewVariablePicker, param2:IWindowController_1)
      {
         var _loc7_:int = 0;
         var _loc3_:TabButtonView = null;
         super();
         _picker = param1;
         _window = param2;
         _tabButtonTemplate = buttonList.removeListItemAt(0) as IRegionWindow;
         _overviewTemplate = contentBox.removeChild(contentBox.getChildByName("variable_overview_template")) as UnknownICoreWindowComponents6;
         contentBox.removeChild(contentBox.getChildByName("node_template"));
         UnknownVarFromExpandedVariablePickerView_TabButtonConfigs_1 = new TabButtonConfigs(param1);
         UnknownVarFromExpandedVariablePickerView_Vector_1 = new Vector.<TabButtonView>();
         expandedWindow.width = param1.window.width;
         var _loc5_:int = (expandedWindow.width - 3) / UnknownVarFromExpandedVariablePickerView_TabButtonConfigs_1.tabButtons.length;
         var _loc4_:int = _loc5_ % UnknownVarFromExpandedVariablePickerView_TabButtonConfigs_1.tabButtons.length;
         for each(var _loc6_ in UnknownVarFromExpandedVariablePickerView_TabButtonConfigs_1.tabButtons)
         {
            _loc7_ = 0;
            if(_loc4_ > 0)
            {
               _loc7_ += 1;
               _loc4_ -= 1;
            }
            _loc3_ = new TabButtonView(this,_loc6_,_loc5_ + _loc7_);
            UnknownVarFromExpandedVariablePickerView_Vector_1.push(_loc3_);
            buttonList.addListItem(_loc3_.window);
         }
      }
      
      internal function onHide() : void
      {
         if(_activeItemsView != null)
         {
            contentBox.removeChild(_activeItemsView.window);
            _activeItemsView.dispose();
            _activeItemsView = null;
         }
      }
      
      internal function onVisible() : void
      {
         loadTab(_selectedTab.tabConfig);
      }
      
      public function get roomEvents() : HabboUserDefinedRoomEvents
      {
         return _picker.roomEvents;
      }
      
      public function tabById(param1:int) : TabButtonView
      {
         for each(var _loc2_ in UnknownVarFromExpandedVariablePickerView_Vector_1)
         {
            if(_loc2_.tabConfig.tabId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get selectedTab() : TabButtonView
      {
         return _selectedTab;
      }
      
      public function get activeItemsView() : VariableNodeListView
      {
         return _activeItemsView;
      }
      
      public function selectTab(param1:TabButtonView, param2:Boolean = false) : void
      {
         if(_selectedTab == param1)
         {
            if(param2 && _selectedTab != null)
            {
               loadTab(_selectedTab.tabConfig);
            }
            return;
         }
         if(_selectedTab != null)
         {
            _selectedTab.active = false;
            _selectedTab = null;
         }
         if(param1 != null)
         {
            _selectedTab = param1;
            _selectedTab.active = true;
            loadTab(_selectedTab.tabConfig);
         }
         _picker.inputField.focus();
      }
      
      public function loadTab(param1:TabButtonConfig) : void
      {
         var _loc2_:* = undefined;
         if(_activeItemsView != null)
         {
            contentBox.removeChild(_activeItemsView.window);
            _activeItemsView.dispose();
            _activeItemsView = null;
         }
         var _loc3_:VariableNode = param1.filteredVariables();
         if(_loc3_.childrenCount == 0)
         {
            emptyContainer.visible = true;
            contentBox.height = emptyContainer.height;
         }
         else
         {
            _loc2_ = _loc3_.children;
            emptyContainer.visible = false;
            _activeItemsView = new VariableNodeListView(_picker,_loc2_,contentBox.width,true);
            contentBox.addChild(_activeItemsView.window);
            contentBox.height = _activeItemsView.window.height;
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         buttonList.removeListItems();
         for each(var _loc1_ in UnknownVarFromExpandedVariablePickerView_Vector_1)
         {
            _loc1_.dispose();
         }
         if(_activeItemsView != null)
         {
            _activeItemsView.dispose();
            _activeItemsView = null;
         }
         UnknownVarFromExpandedVariablePickerView_Vector_1 = null;
         _picker = null;
         _window = null;
         _tabButtonTemplate = null;
         UnknownVarFromExpandedVariablePickerView_TabButtonConfigs_1 = null;
         _selectedTab = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get tabButtonTemplate() : IRegionWindow
      {
         return _tabButtonTemplate;
      }
      
      public function get overviewTemplate() : UnknownICoreWindowComponents6
      {
         return _overviewTemplate;
      }
      
      private function get buttonList() : IItemListWindow
      {
         return _window.findChildByName("button_list") as IItemListWindow;
      }
      
      private function get expandedWindow() : UnknownICoreWindowComponents6
      {
         return _window.findChildByName("expanded_view") as UnknownICoreWindowComponents6;
      }
      
      private function get contentBox() : IWindowController_1
      {
         return _window.findChildByName("content_box") as IWindowController_1;
      }
      
      private function get emptyContainer() : IWindowController_1
      {
         return _window.findChildByName("empty_container") as IWindowController_1;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
   }
}

