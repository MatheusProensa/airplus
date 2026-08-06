package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections
{
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class UsageWarningSection extends AbstractSectionPreset
   {
      private var UnknownVarFromUsageWarningSection_TextPreset_1:TextPreset;
      
      public function UsageWarningSection(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String)
      {
         super(param1,param2,param3);
         var _loc5_:TextParam = new TextParam(1);
         _loc5_.textColor = param3.redTextColor;
         UnknownVarFromUsageWarningSection_TextPreset_1 = param2.createText(param4,_loc5_);
         initializeSection(l("general_box_warning"),UnknownVarFromUsageWarningSection_TextPreset_1,SectionParam.UnknownVarFromSectionParam_SectionParam_1);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         UnknownVarFromUsageWarningSection_TextPreset_1 = null;
      }
   }
}

