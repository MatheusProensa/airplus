package com.sulake.habbo.ui.widget.furniture.areahide
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents2;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetAreaHideDataComposer;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomAreaSelectionManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.FurnitureAreaHideWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class AreaHideFurniWidget extends RoomWidgetBase
   {
      private static var AUTO_SAVE:Boolean = true;
      
      private static var _textNames:Array = ["hidearea_info","areaselection_title","areaselection_info","options_title","invisibility_txt","invisibility_info","wallitems_txt","invert_txt","invert_info"];
      
      private var UnknownVarFromAreaHideFurniWidget_IRoomAreaSelectionManager_1:IRoomAreaSelectionManager;
      
      private var _window:IFrameController;
      
      private var UnknownVarFromAreaHideFurniWidget_Int_1:int;
      
      private var UnknownVarFromAreaHideFurniWidget_Boolean_1:Boolean;
      
      private var UnknownVarFromAreaHideFurniWidget_Int_2:int;
      
      private var UnknownVarFromAreaHideFurniWidget_Int_3:int;
      
      private var _width:int;
      
      private var _length:int;
      
      private var UnknownVarFromAreaHideFurniWidget_Boolean_2:Boolean = false;
      
      private var UnknownVarFromAreaHideFurniWidget_Boolean_3:Boolean = false;
      
      private var UnknownVarFromAreaHideFurniWidget_Boolean_4:Boolean = false;
      
      public function AreaHideFurniWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IHabboLocalizationManager, param5:IRoomEngine)
      {
         super(param1,param2,param3,param4);
         this.handler.widget = this;
         UnknownVarFromAreaHideFurniWidget_IRoomAreaSelectionManager_1 = param5.areaSelectionManager;
      }
      
      private static function disableElement(param1:Boolean, param2:IWindowModel) : void
      {
         if(param1)
         {
            param2.disable();
         }
         else
         {
            param2.enable();
         }
      }
      
      public function get handler() : FurnitureAreaHideWidgetHandler
      {
         return _widgetHandler as FurnitureAreaHideWidgetHandler;
      }
      
      override public function dispose() : void
      {
         destroyWindow();
         super.dispose();
      }
      
      public function open(param1:int, param2:Boolean, param3:int, param4:int, param5:int, param6:int, param7:Boolean, param8:Boolean, param9:Boolean) : void
      {
         UnknownVarFromAreaHideFurniWidget_Int_1 = param1;
         UnknownVarFromAreaHideFurniWidget_Boolean_1 = param2;
         UnknownVarFromAreaHideFurniWidget_Int_2 = param3;
         UnknownVarFromAreaHideFurniWidget_Int_3 = param4;
         _width = param5;
         _length = param6;
         createWindow();
         invisibilityCheckbox.isSelected = param7;
         wallItemsEnabledCheckbox.isSelected = param8;
         invertEnabledCheckbox.isSelected = param9;
         UnknownVarFromAreaHideFurniWidget_Boolean_2 = false;
         UnknownVarFromAreaHideFurniWidget_Boolean_3 = false;
         updateAreaSelecting();
         refreshUI();
      }
      
      private function get isActive() : Boolean
      {
         return _window != null && Boolean(_window.visible);
      }
      
      public function updateStatus(param1:int, param2:Boolean) : void
      {
         if(isActive && param1 == UnknownVarFromAreaHideFurniWidget_Int_1 && param2 != UnknownVarFromAreaHideFurniWidget_Boolean_1)
         {
            UnknownVarFromAreaHideFurniWidget_Boolean_1 = param2;
            updateAreaSelecting();
            refreshUI();
         }
      }
      
      private function updateAreaSelecting() : void
      {
         if(!UnknownVarFromAreaHideFurniWidget_Boolean_1)
         {
            if(!UnknownVarFromAreaHideFurniWidget_Boolean_4)
            {
               UnknownVarFromAreaHideFurniWidget_Boolean_4 = UnknownVarFromAreaHideFurniWidget_IRoomAreaSelectionManager_1.activate(onAreaSelected,"highlight_darken");
            }
            if(UnknownVarFromAreaHideFurniWidget_Boolean_4)
            {
               UnknownVarFromAreaHideFurniWidget_IRoomAreaSelectionManager_1.setHighlight(UnknownVarFromAreaHideFurniWidget_Int_2,UnknownVarFromAreaHideFurniWidget_Int_3,_width,_length);
            }
         }
         else if(UnknownVarFromAreaHideFurniWidget_Boolean_4)
         {
            UnknownVarFromAreaHideFurniWidget_IRoomAreaSelectionManager_1.deactivate();
            UnknownVarFromAreaHideFurniWidget_Boolean_4 = false;
         }
      }
      
      private function createWindow() : void
      {
         if(!_window)
         {
            _window = IFrameController(windowManager.buildFromXML(assets.getAssetByName("area_hide_ui_xml").content as XML));
            _window.procedure = windowProcedure;
            invisibilityCheckbox.addEventListener("WE_SELECTED",onSettingsChanged);
            invisibilityCheckbox.addEventListener("WE_UNSELECTED",onSettingsChanged);
            wallItemsEnabledCheckbox.addEventListener("WE_SELECTED",onSettingsChanged);
            wallItemsEnabledCheckbox.addEventListener("WE_UNSELECTED",onSettingsChanged);
            invertEnabledCheckbox.addEventListener("WE_SELECTED",onSettingsChanged);
            invertEnabledCheckbox.addEventListener("WE_UNSELECTED",onSettingsChanged);
            applyButton.visible = !AUTO_SAVE;
            _window.center();
         }
         else
         {
            _window.visible = true;
         }
      }
      
      private function hideWindow() : void
      {
         if(_window)
         {
            _window.visible = false;
            if(UnknownVarFromAreaHideFurniWidget_Boolean_4)
            {
               UnknownVarFromAreaHideFurniWidget_IRoomAreaSelectionManager_1.deactivate();
               UnknownVarFromAreaHideFurniWidget_Boolean_4 = false;
            }
            UnknownVarFromAreaHideFurniWidget_Int_1 = -1;
            UnknownVarFromAreaHideFurniWidget_Boolean_1 = false;
            UnknownVarFromAreaHideFurniWidget_Int_2 = 0;
            UnknownVarFromAreaHideFurniWidget_Int_3 = 0;
            _width = 0;
            _length = 0;
         }
      }
      
      private function destroyWindow() : void
      {
         hideWindow();
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function refreshUI() : void
      {
         if(UnknownVarFromAreaHideFurniWidget_Boolean_1)
         {
            onOffButton.caption = localizations.getLocalization("widget.areahide.button.off");
            disableContents(true);
         }
         else
         {
            onOffButton.caption = localizations.getLocalization("widget.areahide.button.on");
            disableContents(false);
            disableElement(!UnknownVarFromAreaHideFurniWidget_Boolean_2,applyButton);
            disableElement(UnknownVarFromAreaHideFurniWidget_Boolean_3 || !UnknownVarFromAreaHideFurniWidget_Boolean_4,selectButton);
            disableElement(!UnknownVarFromAreaHideFurniWidget_Boolean_4,clearButton);
         }
      }
      
      private function disableContents(param1:Boolean) : void
      {
         var _loc3_:ITextWindow = null;
         disableElement(param1,selectButton);
         disableElement(param1,clearButton);
         disableElement(param1,applyButton);
         disableElement(param1,invisibilityCheckbox);
         invisibilityCheckbox.blend = param1 ? 0.5 : 1;
         disableElement(param1,wallItemsEnabledCheckbox);
         wallItemsEnabledCheckbox.blend = param1 ? 0.5 : 1;
         disableElement(param1,invertEnabledCheckbox);
         invertEnabledCheckbox.blend = param1 ? 0.5 : 1;
         for each(var _loc2_ in _textNames)
         {
            _loc3_ = _window.findChildByName(_loc2_) as ITextWindow;
            _loc3_.blend = param1 ? 0.5 : 1;
         }
      }
      
      private function onAreaSelected(param1:int, param2:int, param3:int, param4:int) : void
      {
         UnknownVarFromAreaHideFurniWidget_Int_2 = param1;
         UnknownVarFromAreaHideFurniWidget_Int_3 = param2;
         _width = param3;
         _length = param4;
         UnknownVarFromAreaHideFurniWidget_Boolean_3 = false;
         onSettingsChanged(null);
      }
      
      private function onClickSelect() : void
      {
         UnknownVarFromAreaHideFurniWidget_Boolean_3 = true;
         UnknownVarFromAreaHideFurniWidget_IRoomAreaSelectionManager_1.startSelecting();
         refreshUI();
      }
      
      private function onClickClear() : void
      {
         UnknownVarFromAreaHideFurniWidget_IRoomAreaSelectionManager_1.clearHighlight();
      }
      
      private function onClickOnOff() : void
      {
         handler.container.connection.send(new UseFurnitureMessageComposer(UnknownVarFromAreaHideFurniWidget_Int_1));
      }
      
      private function onClickApply() : void
      {
         if(!UnknownVarFromAreaHideFurniWidget_Boolean_2 || AUTO_SAVE)
         {
            return;
         }
         updateData();
         applyButton.disable();
      }
      
      private function updateData() : void
      {
         handler.container.connection.send(new SetAreaHideDataComposer(UnknownVarFromAreaHideFurniWidget_Int_1,UnknownVarFromAreaHideFurniWidget_Int_2,UnknownVarFromAreaHideFurniWidget_Int_3,_width,_length,invisibilityCheckbox.isSelected,wallItemsEnabledCheckbox.isSelected,invertEnabledCheckbox.isSelected));
         UnknownVarFromAreaHideFurniWidget_Boolean_2 = false;
      }
      
      private function onSettingsChanged(param1:WindowEvent) : void
      {
         UnknownVarFromAreaHideFurniWidget_Boolean_2 = true;
         if(AUTO_SAVE)
         {
            updateData();
         }
         refreshUI();
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param2 != null && param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "apply_button":
                  onClickApply();
                  break;
               case "on_off_button":
                  onClickOnOff();
                  break;
               case "select_button":
                  onClickSelect();
                  break;
               case "clear_button":
                  onClickClear();
                  break;
               case "header_button_close":
                  hideWindow();
            }
         }
      }
      
      private function get selectButton() : UnknownICoreWindowComponents4
      {
         _window.deactivate();
         return _window.findChildByName("select_button") as UnknownICoreWindowComponents4;
      }
      
      private function get clearButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("clear_button") as UnknownICoreWindowComponents4;
      }
      
      private function get applyButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("apply_button") as UnknownICoreWindowComponents4;
      }
      
      private function get onOffButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("on_off_button") as UnknownICoreWindowComponents4;
      }
      
      private function get invisibilityCheckbox() : UnknownICoreWindowComponents2
      {
         return _window.findChildByName("invisiblity_checkbox") as UnknownICoreWindowComponents2;
      }
      
      private function get wallItemsEnabledCheckbox() : UnknownICoreWindowComponents2
      {
         return _window.findChildByName("wallitems_checkbox") as UnknownICoreWindowComponents2;
      }
      
      private function get invertEnabledCheckbox() : UnknownICoreWindowComponents2
      {
         return _window.findChildByName("invert_checkbox") as UnknownICoreWindowComponents2;
      }
   }
}

