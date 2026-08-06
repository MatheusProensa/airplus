package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.UnknownIHabboRoomeventsWired_SetupUibuilder1;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class WiredUIPreset implements UnknownIHabboRoomeventsWired_SetupUibuilder1
   {
      private var _disposing:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      protected var _roomEvents:HabboUserDefinedRoomEvents;
      
      protected var UnknownVarFromWiredUIPreset_PresetManager_1:PresetManager;
      
      protected var UnknownVarFromWiredUIPreset_WiredStyle_1:WiredStyle;
      
      private var UnknownVarFromWiredUIPreset_SpacerPreset_1:SpacerPreset;
      
      private var _blendingBackgroundColor:int = 0;
      
      private var _cacheWidth:int = -1;
      
      private var _disabled:Boolean;
      
      private var UnknownVarFromWiredUIPreset_WiredUIPreset_1:WiredUIPreset;
      
      public function WiredUIPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle)
      {
         super();
         _roomEvents = param1;
         UnknownVarFromWiredUIPreset_PresetManager_1 = param2;
         UnknownVarFromWiredUIPreset_WiredStyle_1 = param3;
      }
      
      protected static function toArray(param1:*) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_ in param1)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      public function get window() : IWindowModel
      {
         return null;
      }
      
      public function resizeToWidth(param1:int) : void
      {
         _cacheWidth = param1;
      }
      
      public function resize() : void
      {
         if(_cacheWidth != -1)
         {
            resizeToWidth(_cacheWidth);
         }
      }
      
      public function hasStaticWidth() : Boolean
      {
         return false;
      }
      
      public function get staticWidth() : int
      {
         return -1;
      }
      
      public function alignRight() : WiredUIPreset
      {
         return new AlignRightWrapperPreset(_roomEvents,UnknownVarFromWiredUIPreset_PresetManager_1,UnknownVarFromWiredUIPreset_WiredStyle_1,this);
      }
      
      public function alignCenter() : WiredUIPreset
      {
         return new AlignCenterWrapperPreset(_roomEvents,UnknownVarFromWiredUIPreset_PresetManager_1,UnknownVarFromWiredUIPreset_WiredStyle_1,this);
      }
      
      public function staticHeight(param1:int) : WiredUIPreset
      {
         return new StaticHeightPreset(_roomEvents,UnknownVarFromWiredUIPreset_PresetManager_1,UnknownVarFromWiredUIPreset_WiredStyle_1,this,param1);
      }
      
      public function floatVertically() : WiredUIPreset
      {
         return new FloatVerticallyPreset(_roomEvents,UnknownVarFromWiredUIPreset_PresetManager_1,UnknownVarFromWiredUIPreset_WiredStyle_1,this);
      }
      
      public function wrapWindow(param1:IWindowModel, param2:Boolean = false) : WiredUIPreset
      {
         return new WindowWrapperPreset(_roomEvents,UnknownVarFromWiredUIPreset_PresetManager_1,UnknownVarFromWiredUIPreset_WiredStyle_1,param1,param2);
      }
      
      public function noDisable() : WiredUIPreset
      {
         window.tags.push("DO_NOT_DISABLE");
         return this;
      }
      
      public function halfBlend() : WiredUIPreset
      {
         window.blend = 0.5;
         window.tags.push("HALF_BLEND");
         return this;
      }
      
      public function set disabled(param1:Boolean) : void
      {
         if(_disabled == param1)
         {
            return;
         }
         _disabled = param1;
         updateDisabledState();
      }
      
      public function updateDisabledState() : void
      {
         Util.disableSection(window,_disabled);
         if(!_disabled)
         {
            for each(var _loc1_ in childPresets)
            {
               _loc1_.updateDisabledState();
            }
         }
      }
      
      protected function get childPresets() : Array
      {
         return [];
      }
      
      public function get disabled() : Boolean
      {
         return _disabled;
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(window.visible != param1)
         {
            window.visible = param1;
            if(UnknownVarFromWiredUIPreset_WiredUIPreset_1 != null)
            {
               UnknownVarFromWiredUIPreset_WiredUIPreset_1.onInvisibilityChanged(this,param1);
            }
         }
      }
      
      public function get visible() : Boolean
      {
         return window.visible;
      }
      
      internal function set invisibilityListener(param1:WiredUIPreset) : void
      {
         UnknownVarFromWiredUIPreset_WiredUIPreset_1 = param1;
      }
      
      protected function onInvisibilityChanged(param1:WiredUIPreset, param2:Boolean) : void
      {
      }
      
      protected function loc(param1:String) : String
      {
         return _roomEvents.localization.getLocalization(param1,param1);
      }
      
      protected function l(param1:String) : String
      {
         return _roomEvents.localization.getLocalization("wiredfurni.params." + param1,param1);
      }
      
      protected function get localizations() : IHabboLocalizationManager
      {
         return _roomEvents.localization;
      }
      
      protected function get disposing() : Boolean
      {
         return _disposing;
      }
      
      public function dispose() : void
      {
         _disposing = true;
         if(_disposed)
         {
            return;
         }
         UnknownVarFromWiredUIPreset_SpacerPreset_1 = null;
         _roomEvents = null;
         UnknownVarFromWiredUIPreset_WiredStyle_1 = null;
         UnknownVarFromWiredUIPreset_PresetManager_1 = null;
         UnknownVarFromWiredUIPreset_WiredUIPreset_1 = null;
         for each(var _loc1_ in childPresets)
         {
            _loc1_.dispose();
         }
         _disposed = true;
      }
      
      public function set blendSpacer(param1:SpacerPreset) : void
      {
         UnknownVarFromWiredUIPreset_SpacerPreset_1 = param1;
         updateBackgroundColorBlending();
      }
      
      protected function set blendingBackgroundColor(param1:int) : void
      {
         _blendingBackgroundColor = param1;
         updateBackgroundColorBlending();
      }
      
      private function updateBackgroundColorBlending() : void
      {
         var _loc1_:* = false;
         if(UnknownVarFromWiredUIPreset_SpacerPreset_1 != null)
         {
            _loc1_ = _blendingBackgroundColor != 0;
            UnknownVarFromWiredUIPreset_SpacerPreset_1.backgroundEnabled = _loc1_;
            if(_loc1_)
            {
               UnknownVarFromWiredUIPreset_SpacerPreset_1.backgroundColor = _blendingBackgroundColor;
            }
         }
      }
      
      protected function resolveAssetFullName(param1:String) : String
      {
         var _loc2_:String = "wired_styles_" + UnknownVarFromWiredUIPreset_WiredStyle_1.name + "_" + param1;
         if(_roomEvents.windowManager.assets.getAssetByName(_loc2_) != null)
         {
            return _loc2_;
         }
         return "wired_" + param1;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

