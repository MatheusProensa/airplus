package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class BitmapViewPreset extends WiredUIPreset
   {
      private var _window:IBitmapWrapperController;
      
      private var _width:int;
      
      private var UnknownVarFromBitmapViewPreset_Int_1:int;
      
      public function BitmapViewPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle)
      {
         super(param1,param2,param3);
         _window = param2.createLayout("bitmap_wrapper_view") as IBitmapWrapperController;
      }
      
      public function get bitmapWindow() : IBitmapWrapperController
      {
         return _window;
      }
      
      override public function get window() : IWindowModel
      {
         return _window;
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return true;
      }
      
      override public function get staticWidth() : int
      {
         return _width;
      }
      
      public function setBitmapSize(param1:int, param2:int) : void
      {
         _width = param1;
         UnknownVarFromBitmapViewPreset_Int_1 = param2;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _window.width = _width;
         _window.height = UnknownVarFromBitmapViewPreset_Int_1;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _window.dispose();
         _window = null;
      }
   }
}

