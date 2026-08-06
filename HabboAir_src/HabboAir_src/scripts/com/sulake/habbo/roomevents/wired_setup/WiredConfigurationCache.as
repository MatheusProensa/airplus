package com.sulake.habbo.roomevents.wired_setup
{
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.AdvancedSettingsWrapperPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.FooterPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.FramePreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.HeaderPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.InputSourceSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.SliderSection;
   
   public class WiredConfigurationCache
   {
      private var _frame:FramePreset;
      
      private var _headerPreset:HeaderPreset;
      
      private var _selectorOptionsPreset:CheckboxGroupPreset;
      
      private var _furniPicksSectionPreset:SectionPreset;
      
      private var _delayPreset:SliderSection;
      
      private var _initialWidth:int;
      
      private var _advancedSettingsWrapperPreset:AdvancedSettingsWrapperPreset;
      
      private var _conditionQuantifierOptions:RadioGroupPreset;
      
      private var _inputSourcePresets:Vector.<InputSourceSection>;
      
      private var _footerPreset:FooterPreset;
      
      public function WiredConfigurationCache(param1:FramePreset, param2:HeaderPreset, param3:CheckboxGroupPreset, param4:SectionPreset, param5:SliderSection, param6:AdvancedSettingsWrapperPreset, param7:RadioGroupPreset, param8:Vector.<InputSourceSection>, param9:FooterPreset, param10:int)
      {
         super();
         _frame = param1;
         _headerPreset = param2;
         _selectorOptionsPreset = param3;
         _furniPicksSectionPreset = param4;
         _delayPreset = param5;
         _advancedSettingsWrapperPreset = param6;
         _conditionQuantifierOptions = param7;
         _inputSourcePresets = param8;
         _footerPreset = param9;
         _initialWidth = param10;
      }
      
      public function get frame() : FramePreset
      {
         return _frame;
      }
      
      public function get headerPreset() : HeaderPreset
      {
         return _headerPreset;
      }
      
      public function get selectorOptionsPreset() : CheckboxGroupPreset
      {
         return _selectorOptionsPreset;
      }
      
      public function get furniPicksSectionPreset() : SectionPreset
      {
         return _furniPicksSectionPreset;
      }
      
      public function get delayPreset() : SliderSection
      {
         return _delayPreset;
      }
      
      public function get advancedSettingsWrapperPreset() : AdvancedSettingsWrapperPreset
      {
         return _advancedSettingsWrapperPreset;
      }
      
      public function get conditionQuantifierOptions() : RadioGroupPreset
      {
         return _conditionQuantifierOptions;
      }
      
      public function get inputSourcePresets() : Vector.<InputSourceSection>
      {
         return _inputSourcePresets;
      }
      
      public function get footerPreset() : FooterPreset
      {
         return _footerPreset;
      }
      
      public function get initialWidth() : int
      {
         return _initialWidth;
      }
   }
}

