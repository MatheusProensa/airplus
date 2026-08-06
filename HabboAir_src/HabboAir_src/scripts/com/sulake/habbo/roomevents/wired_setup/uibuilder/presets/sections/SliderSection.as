package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections
{
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.slider_converter.IUnknownHabboRoomeventsWired_SetupCommonSlider_Converter1;
   import com.sulake.habbo.roomevents.wired_setup.common.slider_converter.SliderValuePulses;
   import com.sulake.habbo.roomevents.wired_setup.common.slider_converter.UnknownHabboRoomeventsWired_SetupCommonSlider_Converter1;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.NumberInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.NumberInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SliderPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import flash.events.Event;
   
   public class SliderSection extends AbstractSectionPreset
   {
      public static const CONVERTER_ECHO:IUnknownHabboRoomeventsWired_SetupCommonSlider_Converter1 = new UnknownHabboRoomeventsWired_SetupCommonSlider_Converter1();
      
      public static const CONVERTER_PULSES:IUnknownHabboRoomeventsWired_SetupCommonSlider_Converter1 = new SliderValuePulses();
      
      private var UnknownVarFromSliderSection_SliderPreset_1:SliderPreset;
      
      private var UnknownVarFromSliderSection_IUnknownHabboRoomeventsWired_SetupCommonSlider_Converter1_1:IUnknownHabboRoomeventsWired_SetupCommonSlider_Converter1;
      
      private var _localizationKey:String;
      
      private var UnknownVarFromSliderSection_String_1:String;
      
      private var UnknownVarFromSliderSection_NumberInputPreset_1:NumberInputPreset;
      
      private var _ignoreListeners:Boolean;
      
      public function SliderSection(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:String, param6:IUnknownHabboRoomeventsWired_SetupCommonSlider_Converter1, param7:Number = 0, param8:Number = 1, param9:Number = 0, param10:Boolean = true, param11:SectionParam = null)
      {
         super(param1,param2,param3);
         UnknownVarFromSliderSection_IUnknownHabboRoomeventsWired_SetupCommonSlider_Converter1_1 = param6;
         _localizationKey = param4;
         UnknownVarFromSliderSection_String_1 = param5;
         UnknownVarFromSliderSection_SliderPreset_1 = param2.createSliderPreset(param7,param8,param9);
         if(param10 && (!param11 || param11.headerOptionLeft == null))
         {
            UnknownVarFromSliderSection_NumberInputPreset_1 = param2.createNumberInput(new NumberInputParam(0,param7,param8,40,param6.precision,param6.endsWithFive));
            UnknownVarFromSliderSection_NumberInputPreset_1.onValueChange = onTextValueChange;
            if(param11 == null)
            {
               param11 = new SectionParam();
            }
            param11.headerOptionLeft = UnknownVarFromSliderSection_NumberInputPreset_1;
            param11.titleYOffset = UnknownVarFromWiredUIPreset_WiredStyle_1.namedInputOffset;
         }
         initializeSection(param1.localization.getLocalization(param4),UnknownVarFromSliderSection_SliderPreset_1,param11);
         if(!param10)
         {
            updateName();
         }
         UnknownVarFromSliderSection_SliderPreset_1.addEventListener("change",onSliderChange);
      }
      
      private function onTextValueChange(param1:int) : void
      {
         if(_ignoreListeners)
         {
            return;
         }
         _ignoreListeners = true;
         UnknownVarFromSliderSection_SliderPreset_1.value = param1;
         _ignoreListeners = false;
      }
      
      private function onSliderChange(param1:Event) : void
      {
         if(_ignoreListeners)
         {
            return;
         }
         if(UnknownVarFromSliderSection_NumberInputPreset_1 != null)
         {
            _ignoreListeners = true;
            UnknownVarFromSliderSection_NumberInputPreset_1.value = UnknownVarFromSliderSection_SliderPreset_1.value;
            _ignoreListeners = false;
         }
         else
         {
            updateName();
         }
      }
      
      private function updateName() : void
      {
         sectionTitle = localizations.getLocalizationWithParams(_localizationKey,"",UnknownVarFromSliderSection_String_1,UnknownVarFromSliderSection_IUnknownHabboRoomeventsWired_SetupCommonSlider_Converter1_1.toString(value));
      }
      
      public function get value() : int
      {
         return UnknownVarFromSliderSection_SliderPreset_1.value;
      }
      
      public function set value(param1:int) : void
      {
         _ignoreListeners = true;
         UnknownVarFromSliderSection_SliderPreset_1.value = param1;
         if(UnknownVarFromSliderSection_NumberInputPreset_1 != null)
         {
            UnknownVarFromSliderSection_NumberInputPreset_1.value = param1;
         }
         updateName();
         _ignoreListeners = false;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         UnknownVarFromSliderSection_SliderPreset_1 = null;
         UnknownVarFromSliderSection_IUnknownHabboRoomeventsWired_SetupCommonSlider_Converter1_1 = null;
         UnknownVarFromSliderSection_NumberInputPreset_1 = null;
      }
   }
}

