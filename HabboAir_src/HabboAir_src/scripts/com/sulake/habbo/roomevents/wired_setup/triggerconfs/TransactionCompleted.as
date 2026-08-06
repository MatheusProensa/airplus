package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.UsageInfoSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class TransactionCompleted extends DefaultTriggerConf
   {
      public function TransactionCompleted()
      {
         super();
      }
      
      override public function get code() : int
      {
         return TriggerConfCodes.TRANSACTION_COMPLETED;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc4_:UsageInfoSection = param1.createUsageInfoSection("${wiredfurni.params.transaction_complete.usage_info}");
         param3.addElements(_loc4_);
      }
   }
}

