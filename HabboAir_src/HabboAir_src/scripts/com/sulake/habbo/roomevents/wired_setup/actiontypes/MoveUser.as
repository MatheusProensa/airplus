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
   
   public class MoveUser extends DefaultActionType
   {
      private var UnknownVarFromMoveUser_RadioGroupPreset_1:RadioGroupPreset;
      
      private var UnknownVarFromMoveUser_RadioGroupPreset_2:RadioGroupPreset;
      
      public function MoveUser()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.MOVE_USER;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromMoveUser_RadioGroupPreset_1.selected = param1.intParams[0];
         UnknownVarFromMoveUser_RadioGroupPreset_2.selected = param1.intParams[1];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromMoveUser_RadioGroupPreset_1.selected,UnknownVarFromMoveUser_RadioGroupPreset_2.selected];
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc6_:int = 0;
         var _loc4_:RadioButtonParam = null;
         var _loc7_:int = 0;
         var _loc11_:RadioButtonParam = null;
         var _loc13_:RadioButtonParam = new RadioButtonParam(-1,l("movefurni.0"),null,null,true);
         var _loc9_:Array = [_loc13_];
         _loc6_ = 0;
         while(_loc6_ < 8)
         {
            _loc4_ = new RadioButtonParam(_loc6_,null);
            _loc4_.iconAssetName = "move_" + _loc6_;
            _loc9_.push(_loc4_);
            _loc6_++;
         }
         UnknownVarFromMoveUser_RadioGroupPreset_1 = param1.createRadioGroup(_loc9_,null,4);
         UnknownVarFromMoveUser_RadioGroupPreset_1.selected = -1;
         var _loc10_:SectionPreset = param1.createSection(l("moveuser"),UnknownVarFromMoveUser_RadioGroupPreset_1);
         var _loc5_:RadioButtonParam = new RadioButtonParam(-1,l("rotatefurni.0"),null,null,true);
         var _loc8_:Array = [_loc5_];
         _loc7_ = 0;
         while(_loc7_ < 8)
         {
            _loc11_ = new RadioButtonParam(_loc7_,null);
            _loc11_.iconAssetName = "move_" + _loc7_;
            _loc8_.push(_loc11_);
            _loc7_++;
         }
         var _loc12_:RadioButtonParam = new RadioButtonParam(9,null);
         _loc12_.iconAssetName = "rotate_cw";
         _loc8_.push(_loc12_);
         var _loc14_:RadioButtonParam = new RadioButtonParam(10,null);
         _loc14_.iconAssetName = "rotate_ccw";
         _loc8_.push(_loc14_);
         UnknownVarFromMoveUser_RadioGroupPreset_2 = param1.createRadioGroup(_loc8_,null,4);
         UnknownVarFromMoveUser_RadioGroupPreset_2.selected = -1;
         var _loc15_:SectionPreset = param1.createSection(l("rotateuser"),UnknownVarFromMoveUser_RadioGroupPreset_2);
         param3.addElements(_loc10_,_loc15_);
      }
   }
}

