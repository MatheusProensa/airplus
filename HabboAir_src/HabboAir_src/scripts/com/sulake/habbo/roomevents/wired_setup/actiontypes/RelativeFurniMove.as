package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SliderPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import flash.events.Event;
   
   public class RelativeFurniMove extends DefaultActionType
   {
      private static const UnknownConstFromRelativeFurniMove_Int_1:int = 4;
      
      private static const UnknownConstFromRelativeFurniMove_Int_2:int = 5;
      
      private var UnknownVarFromRelativeFurniMove_RadioGroupPreset_1:RadioGroupPreset;
      
      private var UnknownVarFromRelativeFurniMove_RadioGroupPreset_2:RadioGroupPreset;
      
      private var UnknownVarFromRelativeFurniMove_SliderPreset_1:SliderPreset;
      
      private var UnknownVarFromRelativeFurniMove_SliderPreset_2:SliderPreset;
      
      public function RelativeFurniMove()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.RELATIVE_FURNI_MOVE;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromRelativeFurniMove_RadioGroupPreset_1 = param1.createRadioGroup([createAxisOption(4,"move_2"),createAxisOption(5,"move_6")],null,4);
         UnknownVarFromRelativeFurniMove_RadioGroupPreset_1.selected = 4;
         var _loc4_:TextPreset = param1.createText(l("movement.horizontal.distance"),new TextParam(1));
         UnknownVarFromRelativeFurniMove_SliderPreset_1 = param1.createSliderPreset(0,20,1);
         UnknownVarFromRelativeFurniMove_SliderPreset_1.addEventListener("change",onHorizontalSliderChange);
         var _loc6_:SimpleListViewPreset = param1.createSimpleListView(true,[UnknownVarFromRelativeFurniMove_RadioGroupPreset_1,_loc4_,UnknownVarFromRelativeFurniMove_SliderPreset_1]);
         var _loc5_:SectionPreset = param1.createSection(l("movement.horizontal.selection"),_loc6_);
         UnknownVarFromRelativeFurniMove_RadioGroupPreset_2 = param1.createRadioGroup([createAxisOption(4,"move_4"),createAxisOption(5,"move_0")],null,4);
         UnknownVarFromRelativeFurniMove_RadioGroupPreset_2.selected = 4;
         var _loc7_:TextPreset = param1.createText(l("movement.vertical.distance"),new TextParam(1));
         UnknownVarFromRelativeFurniMove_SliderPreset_2 = param1.createSliderPreset(0,20,1);
         UnknownVarFromRelativeFurniMove_SliderPreset_2.addEventListener("change",onVerticalSliderChange);
         var _loc9_:SimpleListViewPreset = param1.createSimpleListView(true,[UnknownVarFromRelativeFurniMove_RadioGroupPreset_2,_loc7_,UnknownVarFromRelativeFurniMove_SliderPreset_2]);
         var _loc8_:SectionPreset = param1.createSection(l("movement.vertical.selection"),_loc9_);
         updateDistanceLocalization("horizontal",0);
         updateDistanceLocalization("vertical",0);
         param3.addElements(_loc5_,_loc8_);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         setAxisValue(param1.intParams[0],UnknownVarFromRelativeFurniMove_RadioGroupPreset_1,UnknownVarFromRelativeFurniMove_SliderPreset_1,"horizontal");
         setAxisValue(param1.intParams[1],UnknownVarFromRelativeFurniMove_RadioGroupPreset_2,UnknownVarFromRelativeFurniMove_SliderPreset_2,"vertical");
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getAxisValue(UnknownVarFromRelativeFurniMove_RadioGroupPreset_1,UnknownVarFromRelativeFurniMove_SliderPreset_1));
         _loc1_.push(getAxisValue(UnknownVarFromRelativeFurniMove_RadioGroupPreset_2,UnknownVarFromRelativeFurniMove_SliderPreset_2));
         return _loc1_;
      }
      
      private function createAxisOption(param1:int, param2:String) : RadioButtonParam
      {
         var _loc3_:RadioButtonParam = new RadioButtonParam(param1,null);
         _loc3_.iconAssetName = param2;
         return _loc3_;
      }
      
      private function getAxisValue(param1:RadioGroupPreset, param2:SliderPreset) : int
      {
         var _loc3_:int = param2.value;
         return param1.selected == 5 ? -_loc3_ : _loc3_;
      }
      
      private function setAxisValue(param1:int, param2:RadioGroupPreset, param3:SliderPreset, param4:String) : void
      {
         var _loc5_:int = Math.abs(param1);
         param3.value = _loc5_;
         param2.selected = param1 < 0 ? 5 : 4;
         updateDistanceLocalization(param4,_loc5_);
      }
      
      private function onHorizontalSliderChange(param1:Event) : void
      {
         updateDistanceLocalization("horizontal",UnknownVarFromRelativeFurniMove_SliderPreset_1.value);
      }
      
      private function onVerticalSliderChange(param1:Event) : void
      {
         updateDistanceLocalization("vertical",UnknownVarFromRelativeFurniMove_SliderPreset_2.value);
      }
      
      private function updateDistanceLocalization(param1:String, param2:int) : void
      {
         roomEvents.localization.registerParameter("wiredfurni.params.movement." + param1 + ".distance","distance","" + param2);
      }
   }
}

