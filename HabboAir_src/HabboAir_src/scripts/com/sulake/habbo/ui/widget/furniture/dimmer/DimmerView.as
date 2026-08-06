package com.sulake.habbo.ui.widget.furniture.dimmer
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents2;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class DimmerView
   {
      private static const UnknownConstFromDimmerView_Number_1:Number = 100;
      
      private static const UnknownConstFromDimmerView_Number_2:Number = 100;
      
      private var _window:IWindowController_1;
      
      private var _tabContext:ITabContextWindow;
      
      private var _windowXML:XML;
      
      private var UnknownVarFromDimmerView_DimmerFurniWidget_1:DimmerFurniWidget;
      
      private var UnknownVarFromDimmerView_DimmerViewColorGrid_1:DimmerViewColorGrid;
      
      private var UnknownVarFromDimmerView_DimmerViewAlphaSlider_1:DimmerViewAlphaSlider;
      
      private var _selectedBrightness:int;
      
      private var _selectedColorIndex:int;
      
      private var _selectedType:int;
      
      public function DimmerView(param1:DimmerFurniWidget)
      {
         super();
         UnknownVarFromDimmerView_DimmerFurniWidget_1 = param1;
      }
      
      public function get selectedBrightness() : int
      {
         return _selectedBrightness;
      }
      
      public function get selectedColorIndex() : int
      {
         return _selectedColorIndex;
      }
      
      public function get selectedType() : int
      {
         return _selectedType;
      }
      
      public function dispose() : void
      {
         hideInterface();
         UnknownVarFromDimmerView_DimmerFurniWidget_1 = null;
      }
      
      public function showInterface() : void
      {
         if(_window == null)
         {
            createWindow();
         }
         selectPreset(UnknownVarFromDimmerView_DimmerFurniWidget_1.selectedPresetIndex);
         update();
      }
      
      public function update() : void
      {
         var _loc2_:String = null;
         if(_window == null || UnknownVarFromDimmerView_DimmerFurniWidget_1 == null)
         {
            return;
         }
         var _loc1_:Boolean = UnknownVarFromDimmerView_DimmerFurniWidget_1.isOn;
         var _loc3_:IWindowModel = _window.findChildByName("on_off_button");
         if(_loc3_ != null)
         {
            _loc2_ = _loc1_ ? "${widget.dimmer.button.off}" : "${widget.dimmer.button.on}";
            _loc3_.caption = _loc2_;
         }
         _loc3_ = _window.findChildByName("tabbedview");
         if(_loc3_ != null)
         {
            _loc3_.visible = _loc1_;
         }
         _loc3_ = _window.findChildByName("apply_button");
         if(_loc3_ != null)
         {
            _loc1_ ? _loc3_.enable() : _loc3_.disable();
         }
         _loc3_ = _window.findChildByName("off_border");
         if(_loc3_)
         {
            _loc3_.visible = !_loc1_;
         }
      }
      
      public function hideInterface() : void
      {
         if(UnknownVarFromDimmerView_DimmerFurniWidget_1 != null)
         {
            UnknownVarFromDimmerView_DimmerFurniWidget_1.removePreview();
         }
         if(UnknownVarFromDimmerView_DimmerViewColorGrid_1 != null)
         {
            UnknownVarFromDimmerView_DimmerViewColorGrid_1.dispose();
            UnknownVarFromDimmerView_DimmerViewColorGrid_1 = null;
         }
         if(UnknownVarFromDimmerView_DimmerViewAlphaSlider_1 != null)
         {
            UnknownVarFromDimmerView_DimmerViewAlphaSlider_1.dispose();
            UnknownVarFromDimmerView_DimmerViewAlphaSlider_1 = null;
         }
         _tabContext = null;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function createWindow() : void
      {
         var _loc4_:IWindowModel = null;
         var _loc5_:IWindowModel = null;
         var _loc6_:int = 0;
         var _loc1_:ITabButtonWindow = null;
         var _loc3_:BitmapData = null;
         if(UnknownVarFromDimmerView_DimmerFurniWidget_1 == null || UnknownVarFromDimmerView_DimmerFurniWidget_1.windowManager == null || windowXML == null)
         {
            return;
         }
         _window = UnknownVarFromDimmerView_DimmerFurniWidget_1.windowManager.createWindow("dimmerui_container","",4,0,131072 | 1,new Rectangle(100,100,2,2),null,0) as IWindowController_1;
         _window.buildFromXML(windowXML);
         _loc4_ = _window.findChildByTag("close");
         if(_loc4_ != null)
         {
            _loc4_.procedure = onWindowClose;
         }
         _loc4_ = _window.findChildByName("color_grid_container");
         if(_loc4_ != null)
         {
            _loc5_ = (_loc4_ as IWindowController_1).findChildByName("color_grid");
            if(_loc5_ != null)
            {
               UnknownVarFromDimmerView_DimmerViewColorGrid_1 = new DimmerViewColorGrid(this,_loc5_ as IItemGridWindow,UnknownVarFromDimmerView_DimmerFurniWidget_1.windowManager,UnknownVarFromDimmerView_DimmerFurniWidget_1.assets);
            }
         }
         _loc4_ = _window.findChildByName("brightness_container");
         if(_loc4_ != null)
         {
            UnknownVarFromDimmerView_DimmerViewAlphaSlider_1 = new DimmerViewAlphaSlider(this,_loc4_ as IWindowController_1,UnknownVarFromDimmerView_DimmerFurniWidget_1.assets);
         }
         _tabContext = ITabContextWindow(_window.findChildByName("tab_context"));
         selectTab(UnknownVarFromDimmerView_DimmerFurniWidget_1.selectedPresetIndex);
         _loc6_ = 0;
         while(_loc6_ < _tabContext.numTabItems)
         {
            _loc1_ = _tabContext.getTabItemAt(_loc6_);
            _loc1_.setParamFlag(1,true);
            _loc1_.procedure = onTabClick;
            _loc6_++;
         }
         _loc4_ = _window.findChildByName("type_checkbox");
         if(_loc4_ != null)
         {
            _loc4_.addEventListener("WME_CLICK",onMouseEvent);
         }
         _loc4_ = _window.findChildByName("apply_button");
         if(_loc4_ != null)
         {
            _loc4_.addEventListener("WME_CLICK",onMouseEvent);
         }
         _loc4_ = _window.findChildByName("on_off_button");
         if(_loc4_ != null)
         {
            _loc4_.addEventListener("WME_CLICK",onMouseEvent);
         }
         var _loc2_:IBitmapWrapperController = _window.findChildByName("off_image") as IBitmapWrapperController;
         var _loc7_:BitmapDataAsset = UnknownVarFromDimmerView_DimmerFurniWidget_1.assets.getAssetByName("dimmer_info") as BitmapDataAsset;
         if(_loc2_ != null && _loc7_ != null)
         {
            _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height);
            _loc3_ = _loc7_.content as BitmapData;
            if(_loc3_ != null)
            {
               _loc2_.bitmap.copyPixels(_loc3_,_loc3_.rect,new Point(0,0));
            }
         }
      }
      
      private function onMouseEvent(param1:WindowMouseEvent) : void
      {
         var _loc3_:UnknownICoreWindowComponents2 = null;
         var _loc2_:IWindowModel = param1.target as IWindowModel;
         var _loc4_:String;
         switch(_loc4_ = _loc2_.name)
         {
            case "type_checkbox":
               _loc3_ = param1.target as UnknownICoreWindowComponents2;
               if(_loc3_ == null)
               {
                  return;
               }
               if(_loc3_.isSelected)
               {
                  selectedType = 2;
               }
               else
               {
                  selectedType = 1;
               }
               UnknownVarFromDimmerView_DimmerFurniWidget_1.previewCurrentSetting();
               break;
            case "apply_button":
               UnknownVarFromDimmerView_DimmerFurniWidget_1.storeCurrentSetting(true);
               break;
            case "cancel":
            case "close":
               hideInterface();
               break;
            case "on_off_button":
               UnknownVarFromDimmerView_DimmerFurniWidget_1.changeRoomDimmerState();
         }
      }
      
      private function onTabClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WE_SELECTED")
         {
            return;
         }
         UnknownVarFromDimmerView_DimmerFurniWidget_1.storeCurrentSetting(false);
         var _loc3_:int = param2.id;
         selectPreset(_loc3_);
      }
      
      private function onWindowClose(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hideInterface();
      }
      
      private function selectPreset(param1:int) : void
      {
         if(UnknownVarFromDimmerView_DimmerFurniWidget_1 == null || UnknownVarFromDimmerView_DimmerFurniWidget_1.presets == null || param1 < 0 || param1 >= UnknownVarFromDimmerView_DimmerFurniWidget_1.presets.length)
         {
            return;
         }
         UnknownVarFromDimmerView_DimmerFurniWidget_1.selectedPresetIndex = param1;
         var _loc2_:DimmerFurniWidgetPresetItem = UnknownVarFromDimmerView_DimmerFurniWidget_1.presets[param1];
         if(_loc2_ == null)
         {
            return;
         }
         selectTab(param1);
         _selectedBrightness = _loc2_.light;
         if(UnknownVarFromDimmerView_DimmerViewAlphaSlider_1 != null)
         {
            UnknownVarFromDimmerView_DimmerViewAlphaSlider_1.setValue(_selectedBrightness);
         }
         _selectedColorIndex = colors.indexOf(_loc2_.color);
         if(UnknownVarFromDimmerView_DimmerViewColorGrid_1 != null)
         {
            UnknownVarFromDimmerView_DimmerViewColorGrid_1.setSelectedColorIndex(_selectedColorIndex);
         }
         selectedType = _loc2_.type;
         UnknownVarFromDimmerView_DimmerFurniWidget_1.previewCurrentSetting();
      }
      
      private function selectTab(param1:int) : void
      {
         if(_tabContext == null)
         {
            return;
         }
         var _loc2_:IWindowModel = _tabContext.getTabItemAt(param1);
         if(_loc2_ != null)
         {
            _tabContext.selector.setSelected(_loc2_ as ISelectableWindow);
         }
      }
      
      private function getSelectedTabIndex() : int
      {
         if(_tabContext == null)
         {
            return -1;
         }
         var _loc1_:ISelectableWindow = _tabContext.selector.getSelected();
         return _tabContext.selector.getSelectableIndex(_loc1_);
      }
      
      private function get windowXML() : XML
      {
         if(_windowXML != null)
         {
            return _windowXML;
         }
         if(UnknownVarFromDimmerView_DimmerFurniWidget_1 == null || UnknownVarFromDimmerView_DimmerFurniWidget_1.assets == null || UnknownVarFromDimmerView_DimmerFurniWidget_1.assets.getAssetByName("dimmer_ui") == null)
         {
            return null;
         }
         var _loc1_:XmlAsset = XmlAsset(UnknownVarFromDimmerView_DimmerFurniWidget_1.assets.getAssetByName("dimmer_ui"));
         _windowXML = XML(_loc1_.content);
         return _windowXML;
      }
      
      public function get colors() : Array
      {
         if(UnknownVarFromDimmerView_DimmerFurniWidget_1 == null)
         {
            return null;
         }
         return UnknownVarFromDimmerView_DimmerFurniWidget_1.colors;
      }
      
      public function set selectedType(param1:int) : void
      {
         if(param1 != 1 && param1 != 2)
         {
            return;
         }
         _selectedType = param1;
         var _loc2_:UnknownICoreWindowComponents2 = _window.findChildByName("type_checkbox") as UnknownICoreWindowComponents2;
         if(_loc2_ != null)
         {
            if(param1 == 2)
            {
               _loc2_.select();
            }
            else
            {
               _loc2_.unselect();
            }
         }
         if(UnknownVarFromDimmerView_DimmerViewAlphaSlider_1 != null)
         {
            UnknownVarFromDimmerView_DimmerViewAlphaSlider_1.min = UnknownVarFromDimmerView_DimmerFurniWidget_1.minLights[param1 - 1];
         }
      }
      
      public function set selectedColorIndex(param1:int) : void
      {
         _selectedColorIndex = param1;
         if(UnknownVarFromDimmerView_DimmerViewColorGrid_1 != null)
         {
            UnknownVarFromDimmerView_DimmerViewColorGrid_1.setSelectedColorIndex(param1);
         }
         UnknownVarFromDimmerView_DimmerFurniWidget_1.previewCurrentSetting();
      }
      
      public function set selectedBrightness(param1:int) : void
      {
         _selectedBrightness = param1;
         if(UnknownVarFromDimmerView_DimmerViewAlphaSlider_1 != null)
         {
            UnknownVarFromDimmerView_DimmerViewAlphaSlider_1.setValue(param1);
         }
         UnknownVarFromDimmerView_DimmerFurniWidget_1.previewCurrentSetting();
      }
   }
}

