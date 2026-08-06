package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.menu
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.*;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.menu.elements.MenuItem;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.menu.elements.UnknownHabboRoomeventsWired_SetupUibuilderPresetsMenuElements1;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.menu.elements.UnknownIHabboRoomeventsWired_SetupUibuilderPresetsMenuElements1;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.menu.views.MenuItemView;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import flash.geom.Point;
   
   public class MenuPreset extends WiredUIPreset
   {
      public static const SPACER:UnknownIHabboRoomeventsWired_SetupUibuilderPresetsMenuElements1 = new UnknownHabboRoomeventsWired_SetupUibuilderPresetsMenuElements1();
      
      private var _container:IWindowController_1;
      
      private var _menuItemTemplate:IRegionWindow;
      
      private var UnknownVarFromMenuPreset_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromMenuPreset_Vector_1:Vector.<MenuItemView>;
      
      private var UnknownVarFromMenuPreset_IWindowModel_2:IWindowModel;
      
      public function MenuPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Array, param5:IWindowModel)
      {
         var _loc6_:MenuItem = null;
         var _loc11_:UnknownHabboRoomeventsWired_SetupUibuilderPresetsMenuElements1 = null;
         var _loc10_:MenuItemView = null;
         super(param1,param2,param3);
         UnknownVarFromMenuPreset_IWindowModel_2 = param5;
         _container = param3.createQuickMenu();
         var _loc9_:IItemListWindow = menuList;
         var _loc7_:int = _container.width - _loc9_.width;
         var _loc8_:int = _container.height - _loc9_.height;
         _menuItemTemplate = _loc9_.removeListItem(_loc9_.findChildByName("menu_item_template")) as IRegionWindow;
         UnknownVarFromMenuPreset_IWindowModel_1 = _loc9_.removeListItem(_loc9_.findChildByName("spacer_template"));
         UnknownVarFromMenuPreset_Vector_1 = new Vector.<MenuItemView>();
         var _loc12_:int = 0;
         for each(var _loc13_ in param4)
         {
            _loc6_ = _loc13_ as MenuItem;
            _loc11_ = _loc13_ as UnknownHabboRoomeventsWired_SetupUibuilderPresetsMenuElements1;
            if(_loc6_ != null)
            {
               _loc10_ = new MenuItemView(this,_loc6_);
               UnknownVarFromMenuPreset_Vector_1.push(_loc10_);
               _loc9_.addListItem(_loc10_.window);
               if(_loc10_.requestedMinWidth > _loc12_)
               {
                  _loc12_ = _loc10_.requestedMinWidth;
               }
            }
            else if(_loc11_ != null)
            {
               _loc9_.addListItem(UnknownVarFromMenuPreset_IWindowModel_1.clone());
            }
         }
         _container.width = _loc12_ + _loc7_ + param3.menuRightOffset;
         _container.height = _loc9_.height + _loc8_;
         _container.addEventListener("WE_DEACTIVATED",onDeactivate);
      }
      
      private function onDeactivate(param1:WindowEvent) : void
      {
         requestClose();
      }
      
      public function requestOpen() : void
      {
         var _loc1_:IDesktopController = _roomEvents.windowManager.getDesktop(1);
         if(_loc1_ != null)
         {
            _loc1_.addChild(_container);
         }
         var _loc2_:Point = new Point();
         UnknownVarFromMenuPreset_IWindowModel_2.getGlobalPosition(_loc2_);
         _container.x = _loc2_.x;
         _container.y = _loc2_.y + UnknownVarFromMenuPreset_IWindowModel_2.height;
         _container.visible = true;
         _container.activate();
      }
      
      public function requestClose() : void
      {
         var _loc1_:IDesktopController = _roomEvents.windowManager.getDesktop(1);
         if(_loc1_ != null)
         {
            _loc1_.removeChild(_container);
         }
      }
      
      public function setSelected(param1:int, param2:Boolean) : void
      {
         UnknownVarFromMenuPreset_Vector_1[param1].selected = param2;
      }
      
      public function getSelected(param1:int) : Boolean
      {
         return UnknownVarFromMenuPreset_Vector_1[param1].selected;
      }
      
      public function setDisabled(param1:int, param2:Boolean) : void
      {
         UnknownVarFromMenuPreset_Vector_1[param1].disabled = param2;
      }
      
      public function getDisabled(param1:int) : Boolean
      {
         return UnknownVarFromMenuPreset_Vector_1[param1].disabled;
      }
      
      override public function get window() : IWindowModel
      {
         return _container;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _container.width = param1;
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return false;
      }
      
      override public function get staticWidth() : int
      {
         return _container.width;
      }
      
      override protected function get childPresets() : Array
      {
         return [];
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         for each(var _loc1_ in UnknownVarFromMenuPreset_Vector_1)
         {
            _loc1_.dispose();
         }
         UnknownVarFromMenuPreset_Vector_1 = null;
         _container.dispose();
         _container = null;
         _menuItemTemplate.dispose();
         _menuItemTemplate = null;
         UnknownVarFromMenuPreset_IWindowModel_1.dispose();
         UnknownVarFromMenuPreset_IWindowModel_1 = null;
         UnknownVarFromMenuPreset_IWindowModel_2 = null;
      }
      
      private function get menuList() : IItemListWindow
      {
         return _container.findChildByName("menu_list") as IItemListWindow;
      }
      
      public function get menuItemTemplate() : IRegionWindow
      {
         return _menuItemTemplate;
      }
   }
}

