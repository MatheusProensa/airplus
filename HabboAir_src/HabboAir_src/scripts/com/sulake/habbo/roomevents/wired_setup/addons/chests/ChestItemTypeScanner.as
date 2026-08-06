package com.sulake.habbo.roomevents.wired_setup.addons.chests
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.addons.*;
   import com.sulake.habbo.roomevents.wired_setup.common.VariableExtraSourceTypes;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.ChooseVariableSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.UsageInfoSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class ChestItemTypeScanner extends DefaultAddonType
   {
      private var UnknownVarFromChestItemTypeScanner_ChooseVariableSection_1:ChooseVariableSection;
      
      private var _scanningMode:RadioGroupPreset;
      
      public function ChestItemTypeScanner()
      {
         super();
      }
      
      private static function variableSelectionFilter(param1:WiredVariable) : Boolean
      {
         return param1.hasValue && param1.canCreateAndDelete && param1.canWriteValue;
      }
      
      override public function get code() : int
      {
         return AddonCodes.CHEST_ITEM_TYPE_SCANNER;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc4_:UsageInfoSection = param1.createUsageInfoSection("${wiredfurni.params.chest_item_type_scanner.info}");
         UnknownVarFromChestItemTypeScanner_ChooseVariableSection_1 = param1.createChooseVariableSection(0,null,variableSelectionFilter);
         _scanningMode = param1.createRadioGroup([new RadioButtonParam(0,"${wiredfurni.params.chest_item_type_scanner.0}"),new RadioButtonParam(1,"${wiredfurni.params.chest_item_type_scanner.1}")]);
         var _loc5_:SectionPreset = param1.createSection("${wiredfurni.params.chest_item_type_scanner}",_scanningMode,SectionParam.COLLAPSED);
         param3.addElements(_loc4_,UnknownVarFromChestItemTypeScanner_ChooseVariableSection_1,_loc5_);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc3_:String = param1.variableIds[0];
         UnknownVarFromChestItemTypeScanner_ChooseVariableSection_1.init(param1.wiredContext.roomVariablesList,_loc3_,VariableExtraSourceTypes.CONTEXT_SOURCE);
         var _loc2_:int = param1.getInt(0);
         _scanningMode.selected = _loc2_;
      }
      
      override public function onEditInitialized() : void
      {
         UnknownVarFromChestItemTypeScanner_ChooseVariableSection_1.onEditInitialized();
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [UnknownVarFromChestItemTypeScanner_ChooseVariableSection_1.finalizeSelection];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [_scanningMode.selected];
      }
      
      override public function furniSelectionTitle(param1:int) : String
      {
         if(param1 == 0)
         {
            return "wiredfurni.params.sources.furni.title.item_types";
         }
         return "wiredfurni.params.sources.furni.title.chests";
      }
      
      override public function get forceHidePickFurniInstructions() : Boolean
      {
         return true;
      }
      
      override public function advancedAlwaysVisible() : Boolean
      {
         return true;
      }
   }
}

