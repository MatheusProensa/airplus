package com.sulake.habbo.roomevents.wired_setup.common
{
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowEvent;
   import flash.events.Event;
   
   public class SliderWindowControllerNew extends EventDispatcherWrapper
   {
      private var _value:Number = 0;
      
      private var UnknownVarFromSliderWindowControllerNew_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromSliderWindowControllerNew_Boolean_1:Boolean = false;
      
      private var UnknownVarFromSliderWindowControllerNew_Number_1:Number = 0;
      
      private var UnknownVarFromSliderWindowControllerNew_Number_2:Number = 1;
      
      private var UnknownVarFromSliderWindowControllerNew_Number_3:Number = 0;
      
      public function SliderWindowControllerNew(param1:IWindowController_1, param2:Number = 0, param3:Number = 1, param4:Number = 0)
      {
         super();
         UnknownVarFromSliderWindowControllerNew_IWindowController_1_1 = param1;
         UnknownVarFromSliderWindowControllerNew_Number_1 = param2;
         UnknownVarFromSliderWindowControllerNew_Number_2 = param3;
         UnknownVarFromSliderWindowControllerNew_Number_3 = param4;
         _value = 0;
         sliderButton.procedure = sliderProcedure;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         UnknownVarFromSliderWindowControllerNew_IWindowController_1_1.dispose();
         UnknownVarFromSliderWindowControllerNew_IWindowController_1_1 = null;
      }
      
      public function setValue(param1:Number, param2:Boolean = true, param3:Boolean = true) : void
      {
         param1 = Math.max(UnknownVarFromSliderWindowControllerNew_Number_1,param1);
         param1 = Math.min(UnknownVarFromSliderWindowControllerNew_Number_2,param1);
         _value = param1;
         if(param2)
         {
            updateSliderPosition();
         }
         if(param3)
         {
            dispatchEvent(new Event("change"));
         }
      }
      
      public function getValue() : Number
      {
         return _value;
      }
      
      public function set min(param1:Number) : void
      {
         UnknownVarFromSliderWindowControllerNew_Number_1 = param1;
      }
      
      public function set max(param1:Number) : void
      {
         UnknownVarFromSliderWindowControllerNew_Number_2 = param1;
      }
      
      private function updateSliderPosition() : void
      {
         if(UnknownVarFromSliderWindowControllerNew_IWindowController_1_1 == null)
         {
            return;
         }
         var _loc1_:IWindowModel = UnknownVarFromSliderWindowControllerNew_IWindowController_1_1.findChildByName("slider_button");
         if(_loc1_ != null)
         {
            _loc1_.x = getSliderPosition(_value);
         }
         _loc1_.parent.invalidate();
      }
      
      private function getSliderPosition(param1:Number) : int
      {
         return int(referenceWidth * ((param1 - UnknownVarFromSliderWindowControllerNew_Number_1) / (UnknownVarFromSliderWindowControllerNew_Number_2 - UnknownVarFromSliderWindowControllerNew_Number_1)));
      }
      
      private function getValueAtPosition(param1:Number) : Number
      {
         return param1 / referenceWidth * (UnknownVarFromSliderWindowControllerNew_Number_2 - UnknownVarFromSliderWindowControllerNew_Number_1) + UnknownVarFromSliderWindowControllerNew_Number_1;
      }
      
      private function sliderProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc4_:Number = NaN;
         var _loc3_:Number = NaN;
         if(param1.type == "WME_DOWN")
         {
            UnknownVarFromSliderWindowControllerNew_Boolean_1 = true;
         }
         if(UnknownVarFromSliderWindowControllerNew_Boolean_1)
         {
            if(param1.type == "WME_UP" || param1.type == "WME_UP_OUTSIDE")
            {
               UnknownVarFromSliderWindowControllerNew_Boolean_1 = false;
            }
         }
         if(!UnknownVarFromSliderWindowControllerNew_Boolean_1 || param1.type != "WE_RELOCATED")
         {
            return;
         }
         if(UnknownVarFromSliderWindowControllerNew_Number_3 != 0)
         {
            _loc4_ = getValueAtPosition(param2.x);
            _loc3_ = Math.round(_loc4_ / UnknownVarFromSliderWindowControllerNew_Number_3) * UnknownVarFromSliderWindowControllerNew_Number_3;
            setValue(_loc3_,false);
         }
      }
      
      public function moveSliderToRight() : void
      {
         var _loc1_:Number = NaN;
         UnknownVarFromSliderWindowControllerNew_Boolean_1 = false;
         if(UnknownVarFromSliderWindowControllerNew_Number_3 != 0)
         {
            _loc1_ = _value + UnknownVarFromSliderWindowControllerNew_Number_3;
            setValue(_loc1_);
         }
      }
      
      public function moveSliderToLeft() : void
      {
         var _loc1_:Number = NaN;
         UnknownVarFromSliderWindowControllerNew_Boolean_1 = false;
         if(UnknownVarFromSliderWindowControllerNew_Number_3 != 0)
         {
            _loc1_ = _value - UnknownVarFromSliderWindowControllerNew_Number_3;
            setValue(_loc1_);
         }
      }
      
      private function get referenceWidth() : int
      {
         return sliderMovementArea.width - sliderButton.width;
      }
      
      private function get sliderBase() : IStaticBitmapWrapperWindow
      {
         return UnknownVarFromSliderWindowControllerNew_IWindowController_1_1.findChildByName("slider_base") as IStaticBitmapWrapperWindow;
      }
      
      private function get sliderMovementArea() : IWindowController_1
      {
         return UnknownVarFromSliderWindowControllerNew_IWindowController_1_1.findChildByName("slider_movement_area") as IWindowController_1;
      }
      
      private function get sliderButton() : IStaticBitmapWrapperWindow
      {
         return UnknownVarFromSliderWindowControllerNew_IWindowController_1_1.findChildByName("slider_button") as IStaticBitmapWrapperWindow;
      }
   }
}

