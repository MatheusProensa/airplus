package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class MoveToDirection extends DefaultActionType
   {
      private var UnknownVarFromMoveToDirection_RadioGroupPreset_1:RadioGroupPreset;
      
      private var UnknownVarFromMoveToDirection_RadioGroupPreset_2:RadioGroupPreset;
      
      private var _blockOnCollide:CheckboxGroupPreset;
      
      public function MoveToDirection()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.MOVE_TO_DIRECTION;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         UnknownVarFromMoveToDirection_RadioGroupPreset_1.selected = param1.intParams[0];
         UnknownVarFromMoveToDirection_RadioGroupPreset_2.selected = param1.intParams[1];
         _blockOnCollide.get(0).selected = param1.intParams[2] != 0;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromMoveToDirection_RadioGroupPreset_1.selected,UnknownVarFromMoveToDirection_RadioGroupPreset_2.selected,_blockOnCollide.get(0).selected ? 1 : 0];
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc5_:int = 0;
         var _loc11_:RadioButtonParam = null;
         var _loc8_:int = 0;
         var _loc12_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < 8)
         {
            _loc11_ = new RadioButtonParam(_loc5_,null);
            _loc11_.iconAssetName = "move_" + _loc5_;
            _loc12_.push(_loc11_);
            _loc5_++;
         }
         UnknownVarFromMoveToDirection_RadioGroupPreset_1 = param1.createRadioGroup(_loc12_,null,4);
         UnknownVarFromMoveToDirection_RadioGroupPreset_1.selected = 0;
         var _loc6_:SectionPreset = param1.createSection(l("startdir"),UnknownVarFromMoveToDirection_RadioGroupPreset_1);
         var _loc7_:Array = [];
         _loc8_ = 0;
         while(_loc8_ <= 6)
         {
            _loc7_.push(new RadioButtonParam(_loc8_,l("turn." + _loc8_)));
            _loc8_++;
         }
         UnknownVarFromMoveToDirection_RadioGroupPreset_2 = param1.createRadioGroup(_loc7_);
         UnknownVarFromMoveToDirection_RadioGroupPreset_2.selected = 0;
         var _loc9_:SectionPreset = param1.createSection(l("turn"),UnknownVarFromMoveToDirection_RadioGroupPreset_2);
         var _loc4_:CheckboxOptionParam = new CheckboxOptionParam(l("user_collide.0"),0);
         _blockOnCollide = param1.createCheckboxGroup([_loc4_]);
         var _loc10_:SectionPreset = param1.createSection(l("user_collide"),_blockOnCollide);
         param3.addElements(_loc6_,_loc9_,_loc10_);
      }
   }
}

