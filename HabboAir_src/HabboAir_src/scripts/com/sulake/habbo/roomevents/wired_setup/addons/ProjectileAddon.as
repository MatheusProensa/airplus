package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.VariableExtraSourceTypes;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.NumberInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.applications.SubVariableParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.StaticBitmapAssetWrapperPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.applications.SubVariableCreatorPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations.NamedDropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations.NamedNumberInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.SliderSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.UsageInfoSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.ValueOrVariableSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class ProjectileAddon extends DefaultAddonType
   {
      private var UnknownVarFromProjectileAddon_CheckboxGroupPreset_1:CheckboxGroupPreset;
      
      private var _directionalSystemDropdown:NamedDropdownPreset;
      
      private var UnknownVarFromProjectileAddon_StaticBitmapAssetWrapperPreset_1:StaticBitmapAssetWrapperPreset;
      
      private var _shooterDirectionOverride:CheckboxGroupPreset;
      
      private var _bunnyHopCheckbox:CheckboxGroupPreset;
      
      private var UnknownVarFromProjectileAddon_RadioGroupPreset_1:RadioGroupPreset;
      
      private var UnknownVarFromProjectileAddon_NamedNumberInputPreset_1:NamedNumberInputPreset;
      
      private var UnknownVarFromProjectileAddon_RadioGroupPreset_2:RadioGroupPreset;
      
      private var UnknownVarFromProjectileAddon_ValueOrVariableSection_1:ValueOrVariableSection;
      
      private var _enableCustomAnimationTime:CheckboxGroupPreset;
      
      private var _animationTime:ValueOrVariableSection;
      
      private var UnknownVarFromProjectileAddon_CheckboxGroupPreset_2:CheckboxGroupPreset;
      
      private var UnknownVarFromProjectileAddon_NamedNumberInputPreset_2:NamedNumberInputPreset;
      
      private var UnknownVarFromProjectileAddon_SliderSection_1:SliderSection;
      
      private var _internalVariables:SubVariableCreatorPreset;
      
      public function ProjectileAddon()
      {
         super();
      }
      
      override public function get code() : int
      {
         return AddonCodes.PROJECTILE;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      private function onDirectionalSystemChange(param1:ExpandableDropdownOption) : void
      {
         onDirectionalIdSet(param1.id);
      }
      
      private function onDirectionalIdSet(param1:int) : void
      {
         UnknownVarFromProjectileAddon_StaticBitmapAssetWrapperPreset_1.assetUri = "wired_misc_directional_system_" + param1 + "_png";
         roomEventsCtrl.updateSourceContainer(WiredInputSourcePicker.USER_SOURCE,1);
      }
      
      private function newDirectionStateChanged(param1:int, param2:Boolean) : void
      {
         UnknownVarFromProjectileAddon_SliderSection_1.disabled = !param2;
         roomEventsCtrl.updateSourceContainer(WiredInputSourcePicker.USER_SOURCE,1);
      }
      
      private function customAnimationTimeStateChanged(param1:int, param2:Boolean) : void
      {
         roomEventsCtrl.updateSourceContainer(WiredInputSourcePicker.MERGED_SOURCE,0);
      }
      
      private function animationDistanceModeChanged(param1:int) : void
      {
         UnknownVarFromProjectileAddon_ValueOrVariableSection_1.disabled = param1 == 0;
         roomEventsCtrl.updateSourceContainer(WiredInputSourcePicker.MERGED_SOURCE,1);
      }
      
      private function onShooterDirectionCheckboxChanged(param1:int, param2:Boolean) : void
      {
         roomEventsCtrl.updateSourceContainer(WiredInputSourcePicker.USER_SOURCE,1);
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc17_:UsageInfoSection = param1.createUsageInfoSection("${wiredfurni.params.projectile.usage_info}");
         _directionalSystemDropdown = param1.createNamedDropdown(new DropdownParam("${wiredfurni.params.projectile.directional_system}",Vector.<ExpandableDropdownOption>([new ExpandableDropdownOption(0,"${wiredfurni.params.projectile.directional_system.0}"),new ExpandableDropdownOption(1,"${wiredfurni.params.projectile.directional_system.1}"),new ExpandableDropdownOption(2,"${wiredfurni.params.projectile.directional_system.2}"),new ExpandableDropdownOption(3,"${wiredfurni.params.projectile.directional_system.3}")]),onDirectionalSystemChange),"${wiredfurni.params.projectile.directional_system}");
         UnknownVarFromProjectileAddon_StaticBitmapAssetWrapperPreset_1 = param1.createBitmapWrapperPreset("wired_misc_directional_system_1_png");
         _bunnyHopCheckbox = param1.createCheckboxGroup([new CheckboxOptionParam("${wiredfurni.params.projectile.bunny_hop}")]);
         _shooterDirectionOverride = param1.createCheckboxGroup([new CheckboxOptionParam("${wiredfurni.params.projectile.change_shooter_direction}",0,null,_bunnyHopCheckbox)],onShooterDirectionCheckboxChanged);
         var _loc14_:SimpleListViewPreset = param1.createSimpleListView(true,[_directionalSystemDropdown,UnknownVarFromProjectileAddon_StaticBitmapAssetWrapperPreset_1.alignCenter(),_shooterDirectionOverride]);
         _loc14_.spacing = 10;
         var _loc12_:CheckboxOptionParam = new CheckboxOptionParam("${wiredfurni.params.projectile.new_direction_enabled}");
         _loc12_.extra2 = _loc14_;
         UnknownVarFromProjectileAddon_CheckboxGroupPreset_1 = param1.createCheckboxGroup([_loc12_],newDirectionStateChanged);
         var _loc8_:SectionPreset = param1.createSection("${wiredfurni.params.projectile.direction}",UnknownVarFromProjectileAddon_CheckboxGroupPreset_1,SectionParam.UnknownVarFromSectionParam_SectionParam_1);
         UnknownVarFromProjectileAddon_NamedNumberInputPreset_1 = param1.createNamedNumberInput(new NumberInputParam(0,-1000,1000),"${wiredfurni.params.projectile.animation_trajectory.trajectory.1.extra}");
         var _loc9_:TextParam = new TextParam(1);
         _loc9_.textColor = param2.softTextColor;
         var _loc15_:TextPreset = param1.createText("${wiredfurni.params.projectile.animation_trajectory.trajectory.0.info}",_loc9_);
         UnknownVarFromProjectileAddon_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,"${wiredfurni.params.projectile.animation_trajectory.trajectory.0}",null,_loc15_),new RadioButtonParam(1,"${wiredfurni.params.projectile.animation_trajectory.trajectory.1}",null,UnknownVarFromProjectileAddon_NamedNumberInputPreset_1)]);
         var _loc10_:SectionPreset = param1.createSection("${wiredfurni.params.projectile.animation_trajectory.trajectory}",UnknownVarFromProjectileAddon_RadioGroupPreset_1);
         UnknownVarFromProjectileAddon_RadioGroupPreset_2 = param1.createRadioGroup([new RadioButtonParam(0,"${wiredfurni.params.projectile.animation_trajectory.distance.0}"),new RadioButtonParam(1,"${wiredfurni.params.projectile.animation_trajectory.distance.1}"),new RadioButtonParam(2,"${wiredfurni.params.projectile.animation_trajectory.distance.2}")],animationDistanceModeChanged);
         var _loc20_:SectionPreset = param1.createSection("${wiredfurni.params.projectile.animation_trajectory.distance}",UnknownVarFromProjectileAddon_RadioGroupPreset_2);
         UnknownVarFromProjectileAddon_ValueOrVariableSection_1 = param1.createValueOrVariableSection(1,mergedSourceOptions(1),"${wiredfurni.params.projectile.animation_trajectory.distance_selection}",-64,64);
         var _loc4_:SimpleListViewPreset = param1.createSimpleListView(true,[_loc10_,_loc20_,UnknownVarFromProjectileAddon_ValueOrVariableSection_1]);
         var _loc11_:SectionPreset = param1.createSection("${wiredfurni.params.projectile.animation_trajectory}",_loc4_,SectionParam.COLLAPSED);
         _animationTime = param1.createValueOrVariableSection(0,mergedSourceOptions(0),"${wiredfurni.params.projectile.time_per_tile}",1,100000);
         UnknownVarFromProjectileAddon_CheckboxGroupPreset_2 = param1.createCheckboxGroup([new CheckboxOptionParam("${wiredfurni.params.projectile.distance_x}",0),new CheckboxOptionParam("${wiredfurni.params.projectile.distance_y}",1),new CheckboxOptionParam("${wiredfurni.params.projectile.distance_z}",2)]);
         var _loc7_:SectionPreset = param1.createSection("${wiredfurni.params.projectile.distance_options}",UnknownVarFromProjectileAddon_CheckboxGroupPreset_2);
         UnknownVarFromProjectileAddon_NamedNumberInputPreset_2 = param1.createNamedNumberInput(new NumberInputParam(0,0,100000),"${wiredfurni.params.projectile.increase_speed}");
         var _loc6_:SectionPreset = param1.createSection("${wiredfurni.params.projectile.increase_speed.title}",UnknownVarFromProjectileAddon_NamedNumberInputPreset_2);
         var _loc16_:SimpleListViewPreset = param1.createSimpleListView(true,[_animationTime,_loc7_,_loc6_]);
         var _loc5_:CheckboxOptionParam = new CheckboxOptionParam("${wiredfurni.params.projectile.override_animation_time}");
         _loc5_.extra2 = _loc16_;
         _enableCustomAnimationTime = param1.createCheckboxGroup([_loc5_],customAnimationTimeStateChanged);
         var _loc13_:SectionPreset = param1.createSection("${wiredfurni.params.projectile.animation_time}",_enableCustomAnimationTime,SectionParam.COLLAPSED);
         UnknownVarFromProjectileAddon_SliderSection_1 = param1.createSliderSection("wiredfurni.params.projectile.rotation_offset","offset",SliderSection.CONVERTER_ECHO,0,7,1,false,SectionParam.COLLAPSED);
         var _loc19_:Array = [new SubVariableParam(0,"animation.tiles_travelled",true),new SubVariableParam(1,"animation.user_collisions",true),new SubVariableParam(2,"animation.furni_collisions",true),new SubVariableParam(3,"animation.position.x"),new SubVariableParam(4,"animation.position.y"),new SubVariableParam(5,"animation.position.altitude"),new SubVariableParam(6,"animation.is_travelling",true)];
         _internalVariables = param1.createSubVariableCreator("wiredfurni.params.projectile.variable.",_loc19_);
         var _loc18_:SectionPreset = param1.createSection("${wiredfurni.params.projectile.projectile.variables}",_internalVariables,SectionParam.COLLAPSED);
         param3.addElements(_loc17_,_loc8_,_loc11_,_loc13_,UnknownVarFromProjectileAddon_SliderSection_1,_loc18_,param1.createWrapperPreset(param2.createSplitterView()));
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc13_:String = param1.variableIds[0];
         var _loc18_:String = param1.variableIds[1];
         var _loc2_:Boolean = param1.getBoolean(0);
         var _loc5_:int = param1.getInt(1);
         var _loc15_:Boolean = param1.getBoolean(2);
         var _loc16_:int = param1.getInt(3);
         var _loc19_:int = param1.getInt(4);
         var _loc12_:int = param1.getInt(5);
         var _loc21_:Boolean = param1.getBoolean(6);
         var _loc20_:Boolean = param1.getBoolean(7);
         var _loc17_:Boolean = param1.getBoolean(8);
         var _loc8_:int = param1.getInt(9);
         var _loc6_:int = param1.getInt(10);
         var _loc4_:int = param1.getInt(11);
         var _loc3_:Boolean = param1.getBoolean(12);
         var _loc9_:Boolean = param1.getBoolean(13);
         var _loc10_:int = param1.getInt(14);
         var _loc11_:int = param1.getInt(15);
         var _loc14_:int = param1.getInt(16);
         var _loc7_:int = param1.getInt(17);
         var _loc22_:int = param1.getInt(18);
         UnknownVarFromProjectileAddon_CheckboxGroupPreset_1.get(0).selected = _loc2_;
         _directionalSystemDropdown.selectedId = _loc5_;
         _enableCustomAnimationTime.get(0).selected = _loc15_;
         _animationTime.init(param1.wiredContext.roomVariablesList,_loc13_,_loc12_,_loc16_,_loc19_);
         UnknownVarFromProjectileAddon_CheckboxGroupPreset_2.get(0).selected = _loc21_;
         UnknownVarFromProjectileAddon_CheckboxGroupPreset_2.get(1).selected = _loc20_;
         UnknownVarFromProjectileAddon_CheckboxGroupPreset_2.get(2).selected = _loc17_;
         UnknownVarFromProjectileAddon_NamedNumberInputPreset_2.value = _loc8_;
         UnknownVarFromProjectileAddon_SliderSection_1.value = _loc6_;
         _internalVariables.mask = _loc4_;
         _shooterDirectionOverride.get(0).selected = _loc3_;
         _bunnyHopCheckbox.get(0).selected = _loc9_;
         UnknownVarFromProjectileAddon_RadioGroupPreset_2.selected = _loc10_;
         UnknownVarFromProjectileAddon_ValueOrVariableSection_1.init(param1.wiredContext.roomVariablesList,_loc18_,_loc7_,_loc11_,_loc14_);
         UnknownVarFromProjectileAddon_RadioGroupPreset_1.selected = _loc22_ == 0 ? 0 : 1;
         UnknownVarFromProjectileAddon_NamedNumberInputPreset_1.value = _loc22_;
         newDirectionStateChanged(0,_loc2_);
         onDirectionalIdSet(_loc5_);
         animationDistanceModeChanged(_loc10_);
      }
      
      override public function onEditInitialized() : void
      {
         _animationTime.onEditInitialized();
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(UnknownVarFromProjectileAddon_CheckboxGroupPreset_1.get(0).selected ? 1 : 0);
         _loc1_.push(_directionalSystemDropdown.selectedId);
         _loc1_.push(_enableCustomAnimationTime.get(0).selected ? 1 : 0);
         _loc1_.push(_animationTime.option);
         _loc1_.push(_animationTime.numberValue);
         _loc1_.push(_animationTime.target);
         _loc1_.push(UnknownVarFromProjectileAddon_CheckboxGroupPreset_2.get(0).selected ? 1 : 0);
         _loc1_.push(UnknownVarFromProjectileAddon_CheckboxGroupPreset_2.get(1).selected ? 1 : 0);
         _loc1_.push(UnknownVarFromProjectileAddon_CheckboxGroupPreset_2.get(2).selected ? 1 : 0);
         _loc1_.push(UnknownVarFromProjectileAddon_NamedNumberInputPreset_2.value);
         _loc1_.push(UnknownVarFromProjectileAddon_SliderSection_1.value);
         _loc1_.push(_internalVariables.mask);
         _loc1_.push(_shooterDirectionOverride.get(0).selected ? 1 : 0);
         _loc1_.push(_bunnyHopCheckbox.get(0).selected ? 1 : 0);
         _loc1_.push(UnknownVarFromProjectileAddon_RadioGroupPreset_2.selected);
         _loc1_.push(UnknownVarFromProjectileAddon_ValueOrVariableSection_1.option);
         _loc1_.push(UnknownVarFromProjectileAddon_ValueOrVariableSection_1.numberValue);
         _loc1_.push(UnknownVarFromProjectileAddon_ValueOrVariableSection_1.target);
         _loc1_.push(UnknownVarFromProjectileAddon_RadioGroupPreset_1.selected == 1 ? UnknownVarFromProjectileAddon_NamedNumberInputPreset_1.value : 0);
         return _loc1_;
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [_animationTime.finalizeSelection,UnknownVarFromProjectileAddon_ValueOrVariableSection_1.finalizeSelection];
      }
      
      override public function get widthModifier() : Number
      {
         return 1.3;
      }
      
      override public function get allowScrolling() : Boolean
      {
         return false;
      }
      
      override public function furniSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.furni.title.projectile";
      }
      
      override public function userSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.users.title.shooter";
      }
      
      override public function mergedSelectionTitle(param1:int) : String
      {
         if(param1 == 0)
         {
            return "wiredfurni.params.sources.merged.title.variable_time_per_tile";
         }
         return "wiredfurni.params.sources.merged.title.variable_animation_distance";
      }
      
      override public function isInputSourceDisabled(param1:int, param2:int) : Boolean
      {
         if(param2 == WiredInputSourcePicker.MERGED_SOURCE)
         {
            if(param1 == 0)
            {
               return !_enableCustomAnimationTime.get(0).selected || _animationTime.isSourcePickingDisabled();
            }
            return UnknownVarFromProjectileAddon_RadioGroupPreset_2.selected == 0 || UnknownVarFromProjectileAddon_ValueOrVariableSection_1.isSourcePickingDisabled();
         }
         if(param2 == WiredInputSourcePicker.USER_SOURCE)
         {
            return !_shooterDirectionOverride.get(0).selected || !UnknownVarFromProjectileAddon_CheckboxGroupPreset_1.get(0).selected;
         }
         return false;
      }
      
      override public function mergedSelections() : Array
      {
         return [[1,0],[2,2]];
      }
      
      override public function setMergedType(param1:int, param2:int) : void
      {
         if(param1 == 0)
         {
            _animationTime.target = param2;
            return;
         }
         UnknownVarFromProjectileAddon_ValueOrVariableSection_1.target = param2;
      }
      
      override public function getMergedType(param1:int) : int
      {
         if(param1 == 0)
         {
            return _animationTime.target;
         }
         return UnknownVarFromProjectileAddon_ValueOrVariableSection_1.target;
      }
      
      override public function getCustomSourcesForMergedType(param1:int) : Array
      {
         return [VariableExtraSourceTypes.GLOBAL_SOURCE,VariableExtraSourceTypes.CONTEXT_SOURCE];
      }
      
      override public function hasCustomTypePicker(param1:int) : Boolean
      {
         return true;
      }
      
      override public function get forceHidePickFurniInstructions() : Boolean
      {
         return true;
      }
   }
}

