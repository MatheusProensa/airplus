package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections
{
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class UsageInfoSection extends AbstractSectionPreset
   {
      private var UnknownVarFromUsageInfoSection_TextPreset_1:TextPreset;
      
      public function UsageInfoSection(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:Boolean = false, param6:String = null)
      {
         super(param1,param2,param3);
         var _loc7_:TextParam = new TextParam(1);
         _loc7_.textColor = param3.softTextColor;
         UnknownVarFromUsageInfoSection_TextPreset_1 = param2.createText(param4,_loc7_);
         if(param6 == null)
         {
            param6 = l("general_box_info");
         }
         initializeSection(param6,UnknownVarFromUsageInfoSection_TextPreset_1,param5 ? SectionParam.COLLAPSED : SectionParam.UnknownVarFromSectionParam_SectionParam_1);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         UnknownVarFromUsageInfoSection_TextPreset_1 = null;
      }
   }
}

