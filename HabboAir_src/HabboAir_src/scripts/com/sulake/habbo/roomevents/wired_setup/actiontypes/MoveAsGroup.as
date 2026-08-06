package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.NumberInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations.NamedNumberInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.UsageInfoSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class MoveAsGroup extends DefaultActionType
   {
      private static const OFFSET_MIN:int = -64;
      
      private static const UnknownConstFromMoveAsGroup_Int_1:int = 64;
      
      private var UnknownVarFromMoveAsGroup_Boolean_1:Boolean = true;
      
      private var UnknownVarFromMoveAsGroup_NamedNumberInputPreset_1:NamedNumberInputPreset;
      
      private var UnknownVarFromMoveAsGroup_NamedNumberInputPreset_2:NamedNumberInputPreset;
      
      public function MoveAsGroup()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.MOVE_AS_GROUP;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc4_:UsageInfoSection = param1.createUsageInfoSection("${wiredfurni.params.move_as_group.usage_info}");
         UnknownVarFromMoveAsGroup_NamedNumberInputPreset_1 = param1.createNamedNumberInput(new NumberInputParam(0,-64,64),"${wiredfurni.params.place_furni.offsets.x}");
         UnknownVarFromMoveAsGroup_NamedNumberInputPreset_2 = param1.createNamedNumberInput(new NumberInputParam(0,-64,64),"${wiredfurni.params.place_furni.offsets.y}");
         var _loc5_:SimpleListViewPreset = param1.createSimpleListView(true,[UnknownVarFromMoveAsGroup_NamedNumberInputPreset_1,UnknownVarFromMoveAsGroup_NamedNumberInputPreset_2]);
         var _loc6_:SectionPreset = param1.createSection("${wiredfurni.params.place_furni.offsets}",_loc5_);
         param3.addElements(_loc4_,_loc6_);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromMoveAsGroup_Boolean_1 = param1.getBoolean(0);
         UnknownVarFromMoveAsGroup_NamedNumberInputPreset_1.value = param1.getInt(1);
         UnknownVarFromMoveAsGroup_NamedNumberInputPreset_2.value = param1.getInt(2);
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromMoveAsGroup_Boolean_1 ? 1 : 0,UnknownVarFromMoveAsGroup_NamedNumberInputPreset_1.value,UnknownVarFromMoveAsGroup_NamedNumberInputPreset_2.value];
      }
      
      override public function mergedSelections() : Array
      {
         return [[1,0]];
      }
      
      override public function setMergedType(param1:int, param2:int) : void
      {
         UnknownVarFromMoveAsGroup_Boolean_1 = param2 == WiredInputSourcePicker.USER_SOURCE;
      }
      
      override public function getMergedType(param1:int) : int
      {
         return UnknownVarFromMoveAsGroup_Boolean_1 ? WiredInputSourcePicker.USER_SOURCE : WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1;
      }
      
      override public function furniSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.furni.title.mv.0";
      }
      
      override public function mergedSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.merged.title.target_location";
      }
      
      override public function advancedAlwaysVisible() : Boolean
      {
         return true;
      }
      
      override public function get forceHidePickFurniInstructions() : Boolean
      {
         return true;
      }
   }
}

