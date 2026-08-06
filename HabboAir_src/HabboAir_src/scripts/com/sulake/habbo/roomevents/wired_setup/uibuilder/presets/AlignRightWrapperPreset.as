package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class AlignRightWrapperPreset extends WiredUIPreset
   {
      private var _window:IWindowController_1;
      
      private var UnknownVarFromAlignRightWrapperPreset_WiredUIPreset_1:WiredUIPreset;
      
      public function AlignRightWrapperPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:WiredUIPreset)
      {
         super(param1,param2,param3);
         _window = param2.createLayout("growing_container_view") as IWindowController_1;
         UnknownVarFromAlignRightWrapperPreset_WiredUIPreset_1 = param4;
         _window.addChild(UnknownVarFromAlignRightWrapperPreset_WiredUIPreset_1.window);
      }
      
      override public function get window() : IWindowModel
      {
         return _window;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.resizeToWidth(param1);
         if(UnknownVarFromAlignRightWrapperPreset_WiredUIPreset_1.hasStaticWidth())
         {
            _loc2_ = UnknownVarFromAlignRightWrapperPreset_WiredUIPreset_1.staticWidth;
            _loc3_ = Math.max(0,param1 - _loc2_);
            UnknownVarFromAlignRightWrapperPreset_WiredUIPreset_1.window.x = _loc3_;
            UnknownVarFromAlignRightWrapperPreset_WiredUIPreset_1.resizeToWidth(UnknownVarFromAlignRightWrapperPreset_WiredUIPreset_1.staticWidth);
            return;
         }
         throw new Error("Attempting to align UI preset to the right is only possible if a static width is given");
      }
      
      override protected function get childPresets() : Array
      {
         return [UnknownVarFromAlignRightWrapperPreset_WiredUIPreset_1];
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
         UnknownVarFromAlignRightWrapperPreset_WiredUIPreset_1 = null;
      }
   }
}

