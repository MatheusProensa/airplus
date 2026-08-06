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
   
   public class MoveFurni extends DefaultActionType
   {
      private var UnknownVarFromMoveFurni_RadioGroupPreset_1:RadioGroupPreset;
      
      private var UnknownVarFromMoveFurni_RadioGroupPreset_2:RadioGroupPreset;
      
      public function MoveFurni()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.MOVE_FURNI;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromMoveFurni_RadioGroupPreset_1.selected = param1.intParams[0];
         UnknownVarFromMoveFurni_RadioGroupPreset_2.selected = param1.intParams[1];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromMoveFurni_RadioGroupPreset_1.selected,UnknownVarFromMoveFurni_RadioGroupPreset_2.selected];
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc17_:RadioButtonParam = new RadioButtonParam(0,l("movefurni.0"),null,null,true);
         var _loc6_:RadioButtonParam = new RadioButtonParam(4,null);
         _loc6_.iconAssetName = "move_0";
         var _loc10_:RadioButtonParam = new RadioButtonParam(8,null);
         _loc10_.iconAssetName = "move_1";
         var _loc11_:RadioButtonParam = new RadioButtonParam(5,null);
         _loc11_.iconAssetName = "move_2";
         var _loc13_:RadioButtonParam = new RadioButtonParam(9,null);
         _loc13_.iconAssetName = "move_3";
         var _loc15_:RadioButtonParam = new RadioButtonParam(6,null);
         _loc15_.iconAssetName = "move_4";
         var _loc7_:RadioButtonParam = new RadioButtonParam(10,null);
         _loc7_.iconAssetName = "move_5";
         var _loc8_:RadioButtonParam = new RadioButtonParam(7,null);
         _loc8_.iconAssetName = "move_6";
         var _loc9_:RadioButtonParam = new RadioButtonParam(11,null);
         _loc9_.iconAssetName = "move_7";
         var _loc4_:RadioButtonParam = new RadioButtonParam(2,null);
         _loc4_.iconAssetName = "move_diag";
         var _loc18_:RadioButtonParam = new RadioButtonParam(3,null);
         _loc18_.iconAssetName = "move_vrt";
         var _loc5_:RadioButtonParam = new RadioButtonParam(1,null);
         _loc5_.iconAssetName = "move_rnd";
         UnknownVarFromMoveFurni_RadioGroupPreset_1 = param1.createRadioGroup([_loc17_,_loc6_,_loc10_,_loc11_,_loc13_,_loc15_,_loc7_,_loc8_,_loc9_,_loc4_,_loc18_,_loc5_],null,4);
         UnknownVarFromMoveFurni_RadioGroupPreset_1.selected = 0;
         var _loc14_:SectionPreset = param1.createSection(l("movefurni"),UnknownVarFromMoveFurni_RadioGroupPreset_1);
         var _loc12_:RadioButtonParam = new RadioButtonParam(0,l("rotatefurni.0"));
         var _loc16_:RadioButtonParam = new RadioButtonParam(1,l("rotatefurni.1"));
         _loc16_.iconAssetName = "rotate_cw";
         var _loc20_:RadioButtonParam = new RadioButtonParam(2,l("rotatefurni.2"));
         _loc20_.iconAssetName = "rotate_ccw";
         var _loc19_:RadioButtonParam = new RadioButtonParam(3,l("rotatefurni.3"));
         UnknownVarFromMoveFurni_RadioGroupPreset_2 = param1.createRadioGroup([_loc12_,_loc16_,_loc20_,_loc19_]);
         UnknownVarFromMoveFurni_RadioGroupPreset_2.selected = 0;
         var _loc21_:SectionPreset = param1.createSection(l("rotatefurni"),UnknownVarFromMoveFurni_RadioGroupPreset_2);
         param3.addElements(_loc14_,_loc21_);
      }
   }
}

