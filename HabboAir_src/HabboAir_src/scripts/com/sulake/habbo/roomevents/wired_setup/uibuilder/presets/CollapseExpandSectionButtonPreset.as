package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class CollapseExpandSectionButtonPreset extends WiredUIPreset
   {
      private var _window:IRegionWindow;
      
      private var _callback:Function;
      
      public function CollapseExpandSectionButtonPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Function, param5:Boolean)
      {
         super(param1,param2,param3);
         _callback = param4;
         _window = param3.createExpandCollapseSectionRegion();
         upArrow.visible = param5;
         downArrow.visible = !param5;
         _window.addEventListener("WME_CLICK",onButtonClicked);
      }
      
      override public function get window() : IWindowModel
      {
         return _window;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return true;
      }
      
      override public function get staticWidth() : int
      {
         return _window.width;
      }
      
      public function get isExpanded() : Boolean
      {
         return upArrow.visible;
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:* = !isExpanded;
         upArrow.visible = _loc2_;
         downArrow.visible = !_loc2_;
         if(_callback != null)
         {
            _callback(_loc2_);
         }
      }
      
      private function get upArrow() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("up_arrow") as IStaticBitmapWrapperWindow;
      }
      
      private function get downArrow() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("down_arrow") as IStaticBitmapWrapperWindow;
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
         _callback = null;
      }
   }
}

