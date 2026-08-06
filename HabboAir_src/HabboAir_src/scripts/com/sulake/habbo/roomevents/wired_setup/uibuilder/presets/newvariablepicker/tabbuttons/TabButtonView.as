package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.tabbuttons
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.ExpandedVariablePickerView;
   
   public class TabButtonView implements IComponentInterfaceQueue
   {
      private static var SELECTED_BG:uint = 14737632;
      
      private static var UnknownVarFromTabButtonView_Uint_1:uint = 4289374890;
      
      private static var HOVER_BG:uint = 15724527;
      
      private static var UnknownVarFromTabButtonView_Uint_2:uint = 4291611852;
      
      private static var NONE_BG:uint = 16448250;
      
      private static var NONE_SHADOW:uint = 4292730333;
      
      private var _parent:ExpandedVariablePickerView;
      
      private var _window:IRegionWindow;
      
      private var _tabConfig:TabButtonConfig;
      
      private var _disposed:Boolean = false;
      
      private var _active:Boolean = false;
      
      private var UnknownVarFromTabButtonView_Boolean_1:Boolean = false;
      
      public function TabButtonView(param1:ExpandedVariablePickerView, param2:TabButtonConfig, param3:int)
      {
         super();
         _parent = param1;
         _tabConfig = param2;
         _window = param1.tabButtonTemplate.clone() as IRegionWindow;
         _window.width = param3;
         _window.toolTipCaption = _parent.roomEvents.localization.getLocalization(param2.tooltipCaption);
         image.assetUri = param2.assetUri;
         _window.addEventListener("WME_CLICK",onClick);
         _window.addEventListener("WME_OVER",onOver);
         _window.addEventListener("WME_OUT",onOut);
         updateColoring();
      }
      
      public function set active(param1:Boolean) : void
      {
         _active = param1;
         updateColoring();
      }
      
      protected function onClick(param1:WindowMouseEvent) : void
      {
         _parent.selectTab(this);
      }
      
      private function onOut(param1:WindowMouseEvent) : void
      {
         UnknownVarFromTabButtonView_Boolean_1 = false;
         updateColoring();
      }
      
      private function onOver(param1:WindowMouseEvent) : void
      {
         UnknownVarFromTabButtonView_Boolean_1 = true;
         updateColoring();
      }
      
      private function updateColoring() : void
      {
         if(_active)
         {
            buttonBorder.color = SELECTED_BG;
            buttonShadow.color = UnknownVarFromTabButtonView_Uint_1;
         }
         else if(UnknownVarFromTabButtonView_Boolean_1)
         {
            buttonBorder.color = HOVER_BG;
            buttonShadow.color = UnknownVarFromTabButtonView_Uint_2;
         }
         else
         {
            buttonBorder.color = NONE_BG;
            buttonShadow.color = NONE_SHADOW;
         }
         image.blend = _active ? 0.6 : (UnknownVarFromTabButtonView_Boolean_1 ? 0.5 : 0.4);
      }
      
      public function get tabConfig() : TabButtonConfig
      {
         return _tabConfig;
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
         _parent = null;
         _window.dispose();
         _window = null;
         _tabConfig = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get buttonBorder() : UnknownICoreWindowComponents6
      {
         return _window.findChildByName("button_border") as UnknownICoreWindowComponents6;
      }
      
      private function get buttonShadow() : IWindowController_1
      {
         return _window.findChildByName("button_shadow") as IWindowController_1;
      }
      
      private function get image() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("button_img") as IStaticBitmapWrapperWindow;
      }
   }
}

