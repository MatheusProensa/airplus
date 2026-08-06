package com.sulake.habbo.roomevents.wired_trading
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.FooterPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.FramePreset;
   
   public class AbstractUbuntuWiredUI implements IComponentInterfaceQueue
   {
      private var _framePreset:FramePreset;
      
      private var _footerPreset:FooterPreset;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var _presetManager:PresetManager;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromAbstractUbuntuWiredUI_Boolean_1:Boolean = false;
      
      public function AbstractUbuntuWiredUI(param1:HabboUserDefinedRoomEvents, param2:PresetManager)
      {
         super();
         _roomEvents = param1;
         _presetManager = param2;
         _footerPreset = createFooterPreset();
      }
      
      protected function createFooterPreset() : FooterPreset
      {
         return presetManager.createFooterPreset(onSaveClicked,onCloseClicked);
      }
      
      public function get footerPreset() : FooterPreset
      {
         return _footerPreset;
      }
      
      public function onSaveClicked() : void
      {
      }
      
      public function onCloseClicked() : void
      {
         hide();
      }
      
      public function isShowing() : Boolean
      {
         return _framePreset != null && _framePreset.window.parent != null && _framePreset.window.visible;
      }
      
      public function get xOffsetFromCenter() : int
      {
         return 0;
      }
      
      protected function showFrame() : void
      {
         var _loc1_:IDesktopController = null;
         if(!isShowing())
         {
            _loc1_ = _roomEvents.windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(_framePreset.window);
            }
            if(!isRememberLocation || !UnknownVarFromAbstractUbuntuWiredUI_Boolean_1)
            {
               _framePreset.window.center();
               _framePreset.window.x += xOffsetFromCenter;
               UnknownVarFromAbstractUbuntuWiredUI_Boolean_1 = true;
            }
         }
         _framePreset.window.activate();
         _roomEvents.windowManager.LilithCustomsInstance.HandleWindowFrameColor(_framePreset.window);
      }
      
      public function get window() : IWindowModel
      {
         return _framePreset.window;
      }
      
      public function forgetLocation() : void
      {
         UnknownVarFromAbstractUbuntuWiredUI_Boolean_1 = false;
      }
      
      protected function get isRememberLocation() : Boolean
      {
         return false;
      }
      
      protected function get isBoundToParentRect() : Boolean
      {
         return false;
      }
      
      public function hide() : void
      {
         hideFrame();
      }
      
      protected function hideFrame() : void
      {
         var _loc1_:IDesktopController = null;
         if(isShowing())
         {
            _loc1_ = _roomEvents.windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_framePreset.window);
            }
         }
      }
      
      protected function set framePreset(param1:FramePreset) : void
      {
         _framePreset = param1;
         if(isBoundToParentRect)
         {
            param1.window.setParamFlag(32,true);
         }
      }
      
      protected function get framePreset() : FramePreset
      {
         return _framePreset;
      }
      
      protected function get roomEvents() : HabboUserDefinedRoomEvents
      {
         return _roomEvents;
      }
      
      protected function get localization() : IHabboLocalizationManager
      {
         return _roomEvents.localization;
      }
      
      protected function get presetManager() : PresetManager
      {
         return _presetManager;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _framePreset.dispose();
         _framePreset = null;
         _footerPreset = null;
         _roomEvents = null;
         _presetManager = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

