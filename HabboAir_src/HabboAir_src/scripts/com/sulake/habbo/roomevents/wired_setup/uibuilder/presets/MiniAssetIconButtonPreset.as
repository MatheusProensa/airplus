package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IInteractiveWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class MiniAssetIconButtonPreset extends WiredUIPreset
   {
      private static const COLOR_BLUE_CLICKED:uint = 4409728;
      
      private static const COLOR_YELLOW_CLICKED:uint = 6975025;
      
      protected static const YELLOW_ASSETS:Array = ["furni_picks_1"];
      
      protected static const BLUE_ASSETS:Array = ["furni_picks_2"];
      
      protected var _container:IWindowModel;
      
      protected var _selected:Boolean;
      
      protected var UnknownVarFromMiniAssetIconButtonPreset_Boolean_1:Boolean;
      
      protected var _assetName:String;
      
      private var UnknownVarFromMiniAssetIconButtonPreset_Function_1:Function;
      
      public function MiniAssetIconButtonPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:String, param6:Function)
      {
         super(param1,param2,param3);
         _assetName = param4;
         _container = param3.createMiniButton();
         UnknownVarFromMiniAssetIconButtonPreset_Function_1 = param6;
         iconWrapper.assetUri = resolveAssetFullName(param4);
         clickArea.addEventListener("WME_OVER",onHoverStart);
         clickArea.addEventListener("WME_OUT",onHoverEnd);
         clickArea.addEventListener("WME_CLICK",iconClicked);
         clickArea.toolTipCaption = param5;
         updateUI();
      }
      
      private function onHoverEnd(param1:WindowMouseEvent) : void
      {
         UnknownVarFromMiniAssetIconButtonPreset_Boolean_1 = false;
         updateUI();
      }
      
      private function onHoverStart(param1:WindowMouseEvent) : void
      {
         UnknownVarFromMiniAssetIconButtonPreset_Boolean_1 = true;
         updateUI();
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         updateUI();
      }
      
      protected function get selectedColor() : uint
      {
         if(YELLOW_ASSETS.indexOf(_assetName) != -1)
         {
            return 6975025;
         }
         if(BLUE_ASSETS.indexOf(_assetName) != -1)
         {
            return 4409728;
         }
         throw new Exception("Color for asset not configured");
      }
      
      protected function updateUI() : void
      {
      }
      
      protected function iconClicked(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromMiniAssetIconButtonPreset_Function_1 != null && !_selected)
         {
            UnknownVarFromMiniAssetIconButtonPreset_Function_1();
         }
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
         return true;
      }
      
      override public function get staticWidth() : int
      {
         return _container.width;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _container.dispose();
         _container = null;
         _assetName = null;
         UnknownVarFromMiniAssetIconButtonPreset_Function_1 = null;
      }
      
      protected function get clickArea() : IInteractiveWindow
      {
         return _container.findChildByName("mini_button_click") as IInteractiveWindow;
      }
      
      private function get iconWrapper() : IStaticBitmapWrapperWindow
      {
         return _container.findChildByName("mini_button_icon") as IStaticBitmapWrapperWindow;
      }
   }
}

