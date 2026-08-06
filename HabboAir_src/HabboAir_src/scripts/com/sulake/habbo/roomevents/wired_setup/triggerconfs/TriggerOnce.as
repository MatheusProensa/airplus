package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.SliderSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class TriggerOnce extends DefaultTriggerConf
   {
      private var UnknownVarFromTriggerOnce_SliderSection_1:SliderSection;
      
      public function TriggerOnce()
      {
         super();
      }
      
      public static function getSecsFromPulses(param1:int) : String
      {
         var _loc2_:int = Math.floor(param1 / 2);
         if(param1 % 2 == 0)
         {
            return "" + _loc2_;
         }
         return _loc2_ + ".5";
      }
      
      override public function get code() : int
      {
         return TriggerConfCodes.TRIGGER_ONCE;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromTriggerOnce_SliderSection_1 = param1.createSliderSection("wiredfurni.params.settime2","",SliderSection.CONVERTER_PULSES,1,1200,1);
         param3.addElements(UnknownVarFromTriggerOnce_SliderSection_1);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromTriggerOnce_SliderSection_1.value = param1.getInt(0);
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromTriggerOnce_SliderSection_1.value];
      }
   }
}

