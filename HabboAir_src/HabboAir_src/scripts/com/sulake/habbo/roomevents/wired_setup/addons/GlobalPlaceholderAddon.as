package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params.SharedGlobalPlaceholder;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params.SharedGlobalPlaceholderList;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations.NamedDropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.PlaceholderNameSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import flash.utils.Dictionary;
   
   public class GlobalPlaceholderAddon extends DefaultAddonType
   {
      private var UnknownVarFromGlobalPlaceholderAddon_PlaceholderNameSection_1:PlaceholderNameSection;
      
      private var UnknownVarFromGlobalPlaceholderAddon_RadioGroupPreset_1:RadioGroupPreset;
      
      private var UnknownVarFromGlobalPlaceholderAddon_TextInputPreset_1:TextInputPreset;
      
      private var _roomDropdown:NamedDropdownPreset;
      
      private var _placeholderDropdown:NamedDropdownPreset;
      
      private var UnknownVarFromGlobalPlaceholderAddon_SharedGlobalPlaceholderList_1:SharedGlobalPlaceholderList;
      
      private var UnknownVarFromGlobalPlaceholderAddon_String_1:String;
      
      public function GlobalPlaceholderAddon()
      {
         super();
      }
      
      override public function get code() : int
      {
         return AddonCodes.GLOBAL_PLACEHOLDER;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         UnknownVarFromGlobalPlaceholderAddon_PlaceholderNameSection_1 = param1.createPlaceholderNameSection(l("texts.placeholder_name"),"$");
         UnknownVarFromGlobalPlaceholderAddon_TextInputPreset_1 = param1.createTextInput(new TextInputParam("",100));
         _roomDropdown = param1.createNamedDropdown(new DropdownParam(l("room_selection.tooltip"),null,initPlaceholdersForRoom),l("room_selection"));
         _placeholderDropdown = param1.createNamedDropdown(new DropdownParam(l("placeholder_selection.tooltip"),null,onPlaceholderSelected),l("placeholder_selection"));
         UnknownVarFromGlobalPlaceholderAddon_RadioGroupPreset_1 = param1.createRadioGroup([new RadioButtonParam(0,l("from_value"),null,UnknownVarFromGlobalPlaceholderAddon_TextInputPreset_1),new RadioButtonParam(1,l("from_another_room"),null,param1.createSimpleListView(true,[_roomDropdown,_placeholderDropdown]))]);
         var _loc4_:SectionPreset = param1.createSection(l("choose_type"),UnknownVarFromGlobalPlaceholderAddon_RadioGroupPreset_1);
         param3.addElements(UnknownVarFromGlobalPlaceholderAddon_PlaceholderNameSection_1,_loc4_);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         var _loc2_:String = null;
         var _loc5_:int = 0;
         UnknownVarFromGlobalPlaceholderAddon_String_1 = null;
         var _loc4_:int = param1.getInt(0);
         var _loc3_:String = param1.getString(0);
         UnknownVarFromGlobalPlaceholderAddon_PlaceholderNameSection_1.placeholderName = _loc3_;
         UnknownVarFromGlobalPlaceholderAddon_SharedGlobalPlaceholderList_1 = param1.wiredContext.referencePlaceholderList;
         UnknownVarFromGlobalPlaceholderAddon_RadioGroupPreset_1.setOptionDisabled(1,UnknownVarFromGlobalPlaceholderAddon_SharedGlobalPlaceholderList_1 == null);
         UnknownVarFromGlobalPlaceholderAddon_RadioGroupPreset_1.setOptionDisabled(0,UnknownVarFromGlobalPlaceholderAddon_SharedGlobalPlaceholderList_1 == null && _loc4_ == 1);
         UnknownVarFromGlobalPlaceholderAddon_RadioGroupPreset_1.selected = _loc4_;
         _roomDropdown.reset();
         _placeholderDropdown.reset();
         if(_loc4_ == 0)
         {
            UnknownVarFromGlobalPlaceholderAddon_TextInputPreset_1.text = param1.getString(1);
            if(UnknownVarFromGlobalPlaceholderAddon_SharedGlobalPlaceholderList_1 != null)
            {
               _roomDropdown.reinit(findRooms(),-1);
            }
         }
         else
         {
            UnknownVarFromGlobalPlaceholderAddon_TextInputPreset_1.text = "";
            _loc2_ = param1.getString(1);
            _loc5_ = param1.getInt(2);
            _roomDropdown.reinit(findRooms(),_loc5_);
            initPlaceholdersForRoom(_roomDropdown.selected,_loc2_);
            UnknownVarFromGlobalPlaceholderAddon_String_1 = _placeholderDropdown.selected?.displayString;
         }
      }
      
      private function initPlaceholdersForRoom(param1:ExpandableDropdownOption, param2:String = null) : void
      {
         if(param1 == null)
         {
            _placeholderDropdown.reset();
            return;
         }
         var _loc4_:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
         var _loc3_:int = -1;
         if(UnknownVarFromGlobalPlaceholderAddon_SharedGlobalPlaceholderList_1 != null)
         {
            for each(var _loc5_ in UnknownVarFromGlobalPlaceholderAddon_SharedGlobalPlaceholderList_1.sharedPlaceholders)
            {
               if(_loc5_.roomId == param1.id)
               {
                  if(param2 != null && _loc5_.placeholderName == param2)
                  {
                     _loc3_ = int(_loc4_.length);
                  }
                  _loc4_.push(new ExpandableDropdownOption(_loc4_.length,_loc5_.placeholderName));
               }
            }
         }
         _placeholderDropdown.reinit(_loc4_,_loc3_);
      }
      
      private function onPlaceholderSelected(param1:ExpandableDropdownOption) : void
      {
         if(UnknownVarFromGlobalPlaceholderAddon_PlaceholderNameSection_1.placeholderName.length == 0 || UnknownVarFromGlobalPlaceholderAddon_String_1 != null && UnknownVarFromGlobalPlaceholderAddon_String_1 == UnknownVarFromGlobalPlaceholderAddon_PlaceholderNameSection_1.placeholderName)
         {
            UnknownVarFromGlobalPlaceholderAddon_PlaceholderNameSection_1.placeholderName = param1?.displayString;
         }
         UnknownVarFromGlobalPlaceholderAddon_String_1 = _placeholderDropdown.selected?.displayString;
      }
      
      private function findRooms() : Vector.<ExpandableDropdownOption>
      {
         var placeholder:SharedGlobalPlaceholder;
         var options:Dictionary = new Dictionary();
         var result:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
         if(UnknownVarFromGlobalPlaceholderAddon_SharedGlobalPlaceholderList_1 != null)
         {
            for each(placeholder in UnknownVarFromGlobalPlaceholderAddon_SharedGlobalPlaceholderList_1.sharedPlaceholders)
            {
               if(!(placeholder.roomId in options))
               {
                  result.push(new ExpandableDropdownOption(placeholder.roomId,placeholder.roomName));
               }
               options[placeholder.roomId] = true;
            }
         }
         result.sort(function(param1:String, param2:String):int
         {
            return param1.localeCompare(param2);
         });
         return result;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [UnknownVarFromGlobalPlaceholderAddon_RadioGroupPreset_1.selected,0,UnknownVarFromGlobalPlaceholderAddon_RadioGroupPreset_1.selected == 0 ? 0 : _roomDropdown.selectedId];
      }
      
      override public function readStringParamFromForm() : String
      {
         var _loc1_:String = UnknownVarFromGlobalPlaceholderAddon_PlaceholderNameSection_1.placeholderName + "\t";
         if(UnknownVarFromGlobalPlaceholderAddon_RadioGroupPreset_1.selected == 0)
         {
            _loc1_ += UnknownVarFromGlobalPlaceholderAddon_TextInputPreset_1.text;
         }
         else if(_placeholderDropdown.selected != null)
         {
            _loc1_ += _placeholderDropdown.selected.displayString;
         }
         return _loc1_;
      }
   }
}

