package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections
{
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class BorderSection extends AbstractSectionPreset
   {
      public function BorderSection(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:WiredUIPreset, param6:SectionParam = null)
      {
         super(param1,param2,param3);
         initializeSection(param4,param2.createPaddedContainerPreset(param5,param3.paddedSectionLeft,param3.paddedSectionTop,param3.paddedSectionLeft,param3.paddedSectionTop,param3.createBorder()));
      }
   }
}

