package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class MoveUserToFurni extends DefaultActionType
   {
      private var UnknownVarFromMoveUserToFurni_RadioGroupPreset_1:RadioGroupPreset;
      
      public function MoveUserToFurni()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.MOVE_USER_TO_FURNI;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromMoveUserToFurni_RadioGroupPreset_1.selected];
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromMoveUserToFurni_RadioGroupPreset_1.selected = param1.intParams[0];
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function furniSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.furni.title.mv.1";
      }
      
      override public function userSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.furni.title.mv_user2";
      }
      
      override public function advancedAlwaysVisible() : Boolean
      {
         return true;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromMoveUserToFurni_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,l("user_move.walkmode.0")),new RadioButtonParam(1,l("user_move.walkmode.1")),new RadioButtonParam(2,l("user_move.walkmode.2"))]);
         UnknownVarFromMoveUserToFurni_RadioGroupPreset_1.selected = 0;
         var _loc4_:SectionPreset = param1.createSection(l("user_move.walkmode"),UnknownVarFromMoveUserToFurni_RadioGroupPreset_1);
         param3.addElements(_loc4_);
      }
   }
}

