package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class AlignCenterWrapperPreset extends WiredUIPreset
   {
      private var _window:IWindowController_1;
      
      private var UnknownVarFromAlignCenterWrapperPreset_WiredUIPreset_1:WiredUIPreset;
      
      public function AlignCenterWrapperPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:WiredUIPreset)
      {
         super(param1,param2,param3);
         _window = param2.createLayout("container_view") as IWindowController_1;
         UnknownVarFromAlignCenterWrapperPreset_WiredUIPreset_1 = param4;
         _window.addChild(UnknownVarFromAlignCenterWrapperPreset_WiredUIPreset_1.window);
      }
      
      override public function get window() : IWindowModel
      {
         return _window;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         var _loc3_:int = 0;
         super.resizeToWidth(param1);
         _window.width = param1;
         if(UnknownVarFromAlignCenterWrapperPreset_WiredUIPreset_1.hasStaticWidth())
         {
            UnknownVarFromAlignCenterWrapperPreset_WiredUIPreset_1.resizeToWidth(UnknownVarFromAlignCenterWrapperPreset_WiredUIPreset_1.staticWidth);
            _loc3_ = UnknownVarFromAlignCenterWrapperPreset_WiredUIPreset_1.staticWidth;
         }
         else
         {
            UnknownVarFromAlignCenterWrapperPreset_WiredUIPreset_1.resizeToWidth(param1);
            _loc3_ = UnknownVarFromAlignCenterWrapperPreset_WiredUIPreset_1.window.width;
         }
         var _loc2_:int = Math.max(0,param1 / 2 - _loc3_ / 2);
         UnknownVarFromAlignCenterWrapperPreset_WiredUIPreset_1.window.x = _loc2_;
         _window.height = UnknownVarFromAlignCenterWrapperPreset_WiredUIPreset_1.window.height;
      }
      
      override protected function get childPresets() : Array
      {
         return [UnknownVarFromAlignCenterWrapperPreset_WiredUIPreset_1];
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
         UnknownVarFromAlignCenterWrapperPreset_WiredUIPreset_1 = null;
      }
   }
}

