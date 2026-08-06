package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.DropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class FreezeUser extends DefaultActionType
   {
      private var _effectDropdown:DropdownPreset;
      
      private var _cancelCheckbox:CheckboxGroupPreset;
      
      public function FreezeUser()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.FREEZE_USER;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc5_:int = 0;
         var _loc4_:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
         _loc5_ = 0;
         while(_loc5_ <= 4)
         {
            _loc4_.push(new ExpandableDropdownOption(_loc5_,l("freeze.effect." + _loc5_)));
            _loc5_++;
         }
         _effectDropdown = param1.createDropdown(new DropdownParam("${wiredfurni.params.freeze.effect_selection}",_loc4_));
         _cancelCheckbox = param1.createCheckboxGroup([new CheckboxOptionParam(l("freeze.cancel_on_teleport"),0)]);
         var _loc7_:SimpleListViewPreset = param1.createSimpleListView(true,[_effectDropdown,_cancelCheckbox]);
         var _loc6_:SectionPreset = param1.createSection("${wiredfurni.params.freeze.effect_selection}",_loc7_);
         param3.addElements(_loc6_);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         _effectDropdown.selectedId = param1.intParams[0];
         _cancelCheckbox.get(0).selected = param1.getBoolean(1);
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [_effectDropdown.selectedId,_cancelCheckbox.get(0).selected ? 1 : 0];
      }
   }
}

