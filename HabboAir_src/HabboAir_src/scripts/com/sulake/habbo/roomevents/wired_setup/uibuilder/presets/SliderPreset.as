package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowControllerNew;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class SliderPreset extends WiredUIPreset
   {
      private var _container:IWindowController_1;
      
      private var UnknownVarFromSliderPreset_SimpleListViewPreset_1:SimpleListViewPreset;
      
      private var UnknownVarFromSliderPreset_SliderWindowControllerNew_1:SliderWindowControllerNew;
      
      public function SliderPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Number = 0, param5:Number = 1, param6:Number = 0)
      {
         super(param1,param2,param3);
         _container = param2.createLayout("container_view") as IWindowController_1;
         var _loc7_:IWindowController_1 = param3.createSlider();
         UnknownVarFromSliderPreset_SliderWindowControllerNew_1 = new SliderWindowControllerNew(_loc7_,param4,param5,param6);
         UnknownVarFromSliderPreset_SimpleListViewPreset_1 = param2.createSimpleListView(false,[param2.createIconButtonPreset("left",UnknownVarFromSliderPreset_SliderWindowControllerNew_1.moveSliderToLeft),wrapWindow(_loc7_),param2.createIconButtonPreset("right",UnknownVarFromSliderPreset_SliderWindowControllerNew_1.moveSliderToRight)],true);
         UnknownVarFromSliderPreset_SimpleListViewPreset_1.spacing = param3.LRContainerSpacing;
         _container.addChild(UnknownVarFromSliderPreset_SimpleListViewPreset_1.window);
         UnknownVarFromSliderPreset_SimpleListViewPreset_1.window.x = param3.LRContainerMargin;
         UnknownVarFromSliderPreset_SimpleListViewPreset_1.window.y = param3.LRContainerTopBottomPadding;
      }
      
      public function set value(param1:int) : void
      {
         UnknownVarFromSliderPreset_SliderWindowControllerNew_1.setValue(param1);
      }
      
      public function get value() : int
      {
         return UnknownVarFromSliderPreset_SliderWindowControllerNew_1.getValue();
      }
      
      public function addEventListener(param1:String, param2:Function) : void
      {
         UnknownVarFromSliderPreset_SliderWindowControllerNew_1.addEventListener(param1,param2);
      }
      
      override public function get window() : IWindowModel
      {
         return _container;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _container.width = param1;
         UnknownVarFromSliderPreset_SimpleListViewPreset_1.resizeToWidth(param1 - UnknownVarFromWiredUIPreset_WiredStyle_1.LRContainerMargin * 2);
         _container.height = UnknownVarFromSliderPreset_SimpleListViewPreset_1.window.height + 2 * UnknownVarFromWiredUIPreset_WiredStyle_1.LRContainerTopBottomPadding;
      }
      
      override protected function get childPresets() : Array
      {
         return [UnknownVarFromSliderPreset_SimpleListViewPreset_1];
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
         UnknownVarFromSliderPreset_SimpleListViewPreset_1 = null;
         UnknownVarFromSliderPreset_SliderWindowControllerNew_1.dispose();
         UnknownVarFromSliderPreset_SliderWindowControllerNew_1 = null;
      }
   }
}

