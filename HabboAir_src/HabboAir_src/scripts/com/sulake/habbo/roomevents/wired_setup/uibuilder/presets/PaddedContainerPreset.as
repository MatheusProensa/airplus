package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class PaddedContainerPreset extends WiredUIPreset
   {
      protected var _window:IWindowController_1;
      
      private var UnknownVarFromPaddedContainerPreset_WiredUIPreset_1:WiredUIPreset;
      
      private var UnknownVarFromPaddedContainerPreset_Int_1:int;
      
      private var _top:int;
      
      private var UnknownVarFromPaddedContainerPreset_Int_2:int;
      
      private var UnknownVarFromPaddedContainerPreset_Int_3:int;
      
      private var _stretchMode:Boolean;
      
      private var _cachedWidth:int;
      
      private var _ignoreListeners:Boolean = false;
      
      public function PaddedContainerPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:WiredUIPreset, param5:int, param6:int, param7:int, param8:int, param9:IWindowController_1 = null, param10:Boolean = false)
      {
         super(param1,param2,param3);
         UnknownVarFromPaddedContainerPreset_Int_1 = param5;
         _top = param6;
         UnknownVarFromPaddedContainerPreset_Int_2 = param7;
         UnknownVarFromPaddedContainerPreset_Int_3 = param8;
         _stretchMode = param10;
         _window = param9;
         if(_window == null)
         {
            _window = param2.createLayout("growing_container_view") as IWindowController_1;
         }
         _window.addChild(param4.window);
         UnknownVarFromPaddedContainerPreset_WiredUIPreset_1 = param4;
         UnknownVarFromPaddedContainerPreset_WiredUIPreset_1.window.x = UnknownVarFromPaddedContainerPreset_Int_1;
         UnknownVarFromPaddedContainerPreset_WiredUIPreset_1.window.y = _top;
         UnknownVarFromPaddedContainerPreset_WiredUIPreset_1.window.addEventListener("WE_RESIZED",onResizeListener);
      }
      
      private function onResizeListener(param1:WindowEvent) : void
      {
         if(_ignoreListeners)
         {
            return;
         }
         resizeToWidth(_cachedWidth);
      }
      
      override public function get window() : IWindowModel
      {
         return _window;
      }
      
      override protected function get childPresets() : Array
      {
         return [UnknownVarFromPaddedContainerPreset_WiredUIPreset_1];
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return _stretchMode;
      }
      
      override public function get staticWidth() : int
      {
         if(_stretchMode)
         {
            return UnknownVarFromPaddedContainerPreset_WiredUIPreset_1.window.width + UnknownVarFromPaddedContainerPreset_Int_1 + UnknownVarFromPaddedContainerPreset_Int_2;
         }
         return -1;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         _cachedWidth = param1;
         _ignoreListeners = true;
         if(_stretchMode)
         {
            param1 = staticWidth;
         }
         super.resizeToWidth(param1);
         _window.width = param1;
         UnknownVarFromPaddedContainerPreset_WiredUIPreset_1.resizeToWidth(param1 - UnknownVarFromPaddedContainerPreset_Int_1 - UnknownVarFromPaddedContainerPreset_Int_2);
         _window.height = UnknownVarFromPaddedContainerPreset_WiredUIPreset_1.window.height + _top + UnknownVarFromPaddedContainerPreset_Int_3;
         _ignoreListeners = false;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         UnknownVarFromPaddedContainerPreset_WiredUIPreset_1.window.removeEventListener("WE_RESIZED",onResizeListener);
         super.dispose();
         _window.dispose();
         _window = null;
         UnknownVarFromPaddedContainerPreset_WiredUIPreset_1 = null;
      }
   }
}

