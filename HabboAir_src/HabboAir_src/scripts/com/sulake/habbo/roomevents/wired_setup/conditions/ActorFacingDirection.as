package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class ActorFacingDirection extends DefaultConditionType
   {
      private var _directions:CheckboxGroupPreset;
      
      public function ActorFacingDirection()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ConditionCodes.USER_DIRECTION;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc5_:int = 0;
         var _loc7_:CheckboxOptionParam = null;
         var _loc4_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < 8)
         {
            _loc7_ = new CheckboxOptionParam(null);
            _loc7_.iconAssetName = "move_" + _loc5_;
            _loc4_.push(_loc7_);
            _loc5_++;
         }
         _directions = param1.createCheckboxGroup(_loc4_,null,4);
         var _loc6_:SectionPreset = param1.createSection(l("direction_selection"),_directions);
         param3.addElements(_loc6_);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = int(param1.intParams[0]);
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _directions.get(_loc2_).selected = (_loc3_ & 1 << _loc2_) > 0;
            _loc2_++;
         }
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:int = 0;
         var _loc2_:* = 0;
         _loc1_ = 0;
         while(_loc1_ < _directions.numCheckboxes)
         {
            if(_directions.get(_loc1_).selected)
            {
               _loc2_ |= 1 << _loc1_;
            }
            _loc1_++;
         }
         return [_loc2_];
      }
   }
}

