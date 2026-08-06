package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.menu.views
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents2;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.menu.MenuPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.menu.elements.MenuItem;
   
   public class MenuItemView implements IComponentInterfaceQueue
   {
      private var _disposed:Boolean = false;
      
      private var _window:IRegionWindow;
      
      private var UnknownVarFromMenuItemView_MenuPreset_1:MenuPreset;
      
      private var _menuItem:MenuItem;
      
      private var UnknownVarFromMenuItemView_Boolean_1:Boolean = false;
      
      private var UnknownVarFromMenuItemView_Boolean_2:Boolean = false;
      
      private var _disabled:Boolean = false;
      
      private var _ignoreEvents:Boolean = false;
      
      public function MenuItemView(param1:MenuPreset, param2:MenuItem)
      {
         super();
         UnknownVarFromMenuItemView_MenuPreset_1 = param1;
         _menuItem = param2;
         _window = param1.menuItemTemplate.clone() as IRegionWindow;
         textWindow.text = param2.name;
         checkboxWindow.visible = param2.hasCheckbox;
         if(param2.tooltip != null && param2.tooltip.length > 0)
         {
            _window.toolTipCaption = param2.tooltip;
         }
         _window.addEventListener("WME_OVER",onHover);
         _window.addEventListener("WME_OUT",onHoverEnd);
         _window.addEventListener("WME_CLICK",onClick);
         checkboxWindow.addEventListener("WME_OVER",onCheckboxHover);
         checkboxWindow.addEventListener("WME_OUT",onCheckboxHoverEnd);
         checkboxWindow.addEventListener("WE_SELECTED",onSelectedChange);
         checkboxWindow.addEventListener("WE_UNSELECTED",onSelectedChange);
         updateUI();
      }
      
      private function onSelectedChange(param1:WindowEvent) : void
      {
         if(_ignoreEvents)
         {
            return;
         }
         if(_menuItem.selectedChange != null)
         {
            _menuItem.selectedChange(checkboxWindow.isSelected);
         }
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         if(_disabled)
         {
            return;
         }
         if(_menuItem.hasCheckbox)
         {
            selected = !selected;
         }
         if(_menuItem.onClick != null)
         {
            _menuItem.onClick();
         }
         if(!_menuItem.hasCheckbox)
         {
            UnknownVarFromMenuItemView_MenuPreset_1.requestClose();
         }
      }
      
      private function onHoverEnd(param1:WindowMouseEvent) : void
      {
         UnknownVarFromMenuItemView_Boolean_1 = false;
         updateUI();
      }
      
      private function onHover(param1:WindowMouseEvent) : void
      {
         UnknownVarFromMenuItemView_Boolean_1 = true;
         updateUI();
      }
      
      private function onCheckboxHoverEnd(param1:WindowMouseEvent) : void
      {
         UnknownVarFromMenuItemView_Boolean_2 = false;
         updateUI();
      }
      
      private function onCheckboxHover(param1:WindowMouseEvent) : void
      {
         UnknownVarFromMenuItemView_Boolean_2 = true;
         updateUI();
      }
      
      private function updateUI() : void
      {
         _window.background = (UnknownVarFromMenuItemView_Boolean_1 || UnknownVarFromMenuItemView_Boolean_2) && !_disabled;
         Util.disableSection(_window,_disabled);
      }
      
      public function get selected() : Boolean
      {
         if(_menuItem.hasCheckbox)
         {
            return checkboxWindow.isSelected;
         }
         return false;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _ignoreEvents = true;
         if(_menuItem.hasCheckbox)
         {
            if(param1)
            {
               checkboxWindow.select();
            }
            else
            {
               checkboxWindow.unselect();
            }
            if(_menuItem.selectedChange != null)
            {
               _menuItem.selectedChange(checkboxWindow.isSelected);
            }
            if(_menuItem.onClick != null)
            {
               _menuItem.onClick();
            }
         }
         _ignoreEvents = false;
      }
      
      public function get disabled() : Boolean
      {
         return _disabled;
      }
      
      public function set disabled(param1:Boolean) : void
      {
         _disabled = param1;
         updateUI();
      }
      
      public function get requestedMinWidth() : int
      {
         return textWindow.x + textWindow.width;
      }
      
      public function get menuItem() : MenuItem
      {
         return _menuItem;
      }
      
      public function get window() : IRegionWindow
      {
         return _window;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _window = null;
         UnknownVarFromMenuItemView_MenuPreset_1 = null;
         _menuItem = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get textWindow() : ITextWindow
      {
         return _window.findChildByName("text") as ITextWindow;
      }
      
      private function get checkboxWindow() : UnknownICoreWindowComponents2
      {
         return _window.findChildByName("checkbox") as UnknownICoreWindowComponents2;
      }
   }
}

