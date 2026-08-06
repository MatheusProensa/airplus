package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class MovePhysics extends DefaultAddonType
   {
      private var UnknownVarFromMovePhysics_CheckboxGroupPreset_1:CheckboxGroupPreset;
      
      public function MovePhysics()
      {
         super();
      }
      
      override public function get code() : int
      {
         return AddonCodes.UnknownVarFromAddonCodes_Int_4;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromMovePhysics_CheckboxGroupPreset_1 = param1.createCheckboxGroup([new CheckboxOptionParam(l("movephysics.keep_altitude"),0),new CheckboxOptionParam(l("movephysics.move_through_furni"),1),new CheckboxOptionParam(l("movephysics.move_through_users"),2),new CheckboxOptionParam(l("movephysics.block_by_furni"),3)]);
         var _loc4_:SectionPreset = param1.createSection(l("select_options"),UnknownVarFromMovePhysics_CheckboxGroupPreset_1);
         param3.addElements(_loc4_);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromMovePhysics_CheckboxGroupPreset_1.get(0).selected = param1.getBoolean(0);
         UnknownVarFromMovePhysics_CheckboxGroupPreset_1.get(1).selected = param1.getBoolean(1);
         UnknownVarFromMovePhysics_CheckboxGroupPreset_1.get(2).selected = param1.getBoolean(2);
         UnknownVarFromMovePhysics_CheckboxGroupPreset_1.get(3).selected = param1.getBoolean(3);
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromMovePhysics_CheckboxGroupPreset_1.get(0).selected ? 1 : 0,UnknownVarFromMovePhysics_CheckboxGroupPreset_1.get(1).selected ? 1 : 0,UnknownVarFromMovePhysics_CheckboxGroupPreset_1.get(2).selected ? 1 : 0,UnknownVarFromMovePhysics_CheckboxGroupPreset_1.get(3).selected ? 1 : 0];
      }
      
      override public function furniSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.furni.title.physics." + param1;
      }
      
      override public function userSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.users.title.physics." + param1;
      }
   }
}

