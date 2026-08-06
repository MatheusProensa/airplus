package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextualButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.UsageInfoSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class TransactionFailed extends DefaultTriggerConf
   {
      public function TransactionFailed()
      {
         super();
      }
      
      override public function get code() : int
      {
         return TriggerConfCodes.TRANSACTION_FAILED;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc4_:UsageInfoSection = param1.createUsageInfoSection("${wiredfurni.params.transaction_failed.usage_info}");
         var _loc5_:TextualButtonPreset = param1.createTextualButtonPreset(loc("wiredfurni.view_in_menu"),viewInMenuCallback);
         param3.addElements(_loc4_,_loc5_.alignCenter());
      }
      
      private function viewInMenuCallback() : void
      {
         roomEvents.context.createLinkEvent("wiredmenu/open/variable_overview/@event.transaction_failed.reason");
      }
   }
}

