package com.sulake.habbo.roomevents.wired_setup.variables
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.params.SharedVariableList;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.SharedVariable;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredcontext.variables.WiredVariable;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.DropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.VariableNameSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import flash.utils.Dictionary;
   
   public class ReferenceVariable extends NewDefaultVariableType
   {
      private var _variableName:VariableNameSection;
      
      private var _roomDropdown:DropdownPreset;
      
      private var _variableDropdown:DropdownPreset;
      
      private var UnknownVarFromReferenceVariable_CheckboxGroupPreset_1:CheckboxGroupPreset;
      
      private var UnknownVarFromReferenceVariable_WiredVariable_1:WiredVariable;
      
      private var _rooms:Vector.<Object>;
      
      private var UnknownVarFromReferenceVariable_Dictionary_1:Dictionary;
      
      private var UnknownVarFromReferenceVariable_Vector_1:Vector.<String>;
      
      private var UnknownVarFromReferenceVariable_Vector_2:Vector.<WiredVariable>;
      
      private var UnknownVarFromReferenceVariable_Int_1:int = -1;
      
      private var UnknownVarFromReferenceVariable_Boolean_1:Boolean = false;
      
      public function ReferenceVariable()
      {
         super();
      }
      
      override public function get code() : int
      {
         return VariableCodes.REFERENCE_VARIABLE;
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         if(UnknownVarFromReferenceVariable_Vector_1 == null)
         {
            return [WiredVariable.UnknownVarFromWiredVariable_String_1];
         }
         var _loc1_:int = _variableDropdown.selectedId;
         if(_loc1_ < 0 || _loc1_ >= UnknownVarFromReferenceVariable_Vector_1.length)
         {
            return [WiredVariable.UnknownVarFromWiredVariable_String_1];
         }
         return [UnknownVarFromReferenceVariable_Vector_1[_loc1_]];
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(UnknownVarFromReferenceVariable_CheckboxGroupPreset_1.get(0).selected ? 1 : 0);
         return _loc1_;
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         super.onEditStart(param1);
         var _loc4_:String = param1.variableIds != null && param1.variableIds.length > 0 ? param1.variableIds[0] : WiredVariable.UnknownVarFromWiredVariable_String_1;
         var _loc3_:* = param1.intParams[0] != 0;
         UnknownVarFromReferenceVariable_CheckboxGroupPreset_1.get(0).selected = _loc3_;
         UnknownVarFromReferenceVariable_Boolean_1 = false;
         var _loc2_:SharedVariableList = param1.wiredContext.referenceVariablesList;
         initRooms(_loc4_,_loc2_);
         refreshVariables(_loc4_);
         UnknownVarFromReferenceVariable_WiredVariable_1 = findVariableById(_loc4_);
         initialVariableName = param1.stringParam;
         UnknownVarFromReferenceVariable_Boolean_1 = true;
         setEditable(_loc2_ != null);
      }
      
      override public function readStringParamFromForm() : String
      {
         return _variableName.variableName;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         _variableName = param1.createVariableNameSection();
         _roomDropdown = param1.createDropdown(new DropdownParam(l("variables.room_selection.tooltip"),null,onRoomSelected));
         var _loc5_:SectionPreset = param1.createSection(l("variables.room_selection"),_roomDropdown);
         _variableDropdown = param1.createDropdown(new DropdownParam(l("variables.variable_selection.tooltip"),null,onVariableSelected));
         var _loc6_:SectionPreset = param1.createSection(l("variables.variable_ref_selection"),_variableDropdown);
         UnknownVarFromReferenceVariable_CheckboxGroupPreset_1 = param1.createCheckboxGroup([new CheckboxOptionParam(l("variables.settings.read_only"))]);
         var _loc4_:SectionPreset = param1.createSection(l("variables.settings"),UnknownVarFromReferenceVariable_CheckboxGroupPreset_1);
         param3.addElements(_variableName,_loc5_,_loc6_,_loc4_);
      }
      
      private function setEditable(param1:Boolean) : void
      {
         _variableName.disabled = !param1;
         _roomDropdown.disabled = !param1;
         _variableDropdown.disabled = !param1;
         UnknownVarFromReferenceVariable_CheckboxGroupPreset_1.disabled = !param1;
      }
      
      private function initRooms(param1:String, param2:SharedVariableList) : void
      {
         var room:Object;
         var sharedVariable:SharedVariable;
         var roomOptions:Vector.<ExpandableDropdownOption>;
         var i:int;
         var variableId:String = param1;
         var context:SharedVariableList = param2;
         UnknownVarFromReferenceVariable_Dictionary_1 = new Dictionary();
         _rooms = new Vector.<Object>();
         var selectedRoom:Object = null;
         var roomMap:Dictionary = new Dictionary();
         UnknownVarFromReferenceVariable_Int_1 = -1;
         if(context != null)
         {
            for each(sharedVariable in context.sharedVariables)
            {
               if(!(sharedVariable.roomId in roomMap))
               {
                  room = {
                     "id":sharedVariable.roomId,
                     "name":sharedVariable.roomName
                  };
                  roomMap[sharedVariable.roomId] = room;
                  _rooms.push(room);
               }
               else
               {
                  room = roomMap[sharedVariable.roomId];
               }
               if(!(sharedVariable.roomId in UnknownVarFromReferenceVariable_Dictionary_1))
               {
                  UnknownVarFromReferenceVariable_Dictionary_1[sharedVariable.roomId] = new Vector.<WiredVariable>();
               }
               UnknownVarFromReferenceVariable_Dictionary_1[sharedVariable.roomId].push(sharedVariable.wiredVariable);
               if(sharedVariable.wiredVariable.variableId == variableId)
               {
                  selectedRoom = room;
               }
            }
            _rooms.sort(function(param1:Object, param2:Object):int
            {
               return param1.name.localeCompare(param2.name);
            });
         }
         if(selectedRoom != null)
         {
            UnknownVarFromReferenceVariable_Int_1 = selectedRoom.id;
         }
         roomOptions = new Vector.<ExpandableDropdownOption>();
         i = 0;
         while(i < _rooms.length)
         {
            room = _rooms[i];
            roomOptions.push(new ExpandableDropdownOption(room.id,room.name));
            i += 1;
         }
         _roomDropdown.reinit(roomOptions,UnknownVarFromReferenceVariable_Int_1);
      }
      
      private function refreshVariables(param1:String) : void
      {
         var _loc2_:* = undefined;
         var _loc5_:int = 0;
         UnknownVarFromReferenceVariable_Vector_1 = new Vector.<String>();
         UnknownVarFromReferenceVariable_Vector_2 = new Vector.<WiredVariable>();
         var _loc3_:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
         var _loc6_:* = -1;
         if(UnknownVarFromReferenceVariable_Int_1 in UnknownVarFromReferenceVariable_Dictionary_1)
         {
            _loc2_ = UnknownVarFromReferenceVariable_Dictionary_1[UnknownVarFromReferenceVariable_Int_1];
            _loc5_ = 0;
            for each(var _loc4_ in _loc2_)
            {
               _loc3_.push(new ExpandableDropdownOption(_loc5_,_loc4_.variableName));
               UnknownVarFromReferenceVariable_Vector_1.push(_loc4_.variableId);
               UnknownVarFromReferenceVariable_Vector_2.push(_loc4_);
               if(_loc4_.variableId == param1)
               {
                  _loc6_ = _loc5_;
               }
               _loc5_++;
            }
         }
         _variableDropdown.reinit(_loc3_,_loc6_);
      }
      
      private function onRoomSelected(param1:ExpandableDropdownOption) : void
      {
         if(!UnknownVarFromReferenceVariable_Boolean_1 || param1 == null)
         {
            return;
         }
         if(UnknownVarFromReferenceVariable_Int_1 == param1.id)
         {
            return;
         }
         UnknownVarFromReferenceVariable_Int_1 = param1.id;
         refreshVariables(WiredVariable.UnknownVarFromWiredVariable_String_1);
         onVariableSelected(null);
      }
      
      private function onVariableSelected(param1:ExpandableDropdownOption) : void
      {
         if(!UnknownVarFromReferenceVariable_Boolean_1)
         {
            return;
         }
         var _loc3_:int = param1?.id;
         var _loc2_:WiredVariable = _loc3_ >= 0 && _loc3_ < UnknownVarFromReferenceVariable_Vector_2.length ? UnknownVarFromReferenceVariable_Vector_2[_loc3_] : null;
         if(_variableName.variableName.length == 0 || UnknownVarFromReferenceVariable_WiredVariable_1 != null && UnknownVarFromReferenceVariable_WiredVariable_1.variableName == _variableName.variableName)
         {
            _variableName.variableName = _loc2_?.variableName;
         }
         UnknownVarFromReferenceVariable_WiredVariable_1 = _loc2_;
      }
      
      private function findVariableById(param1:String) : WiredVariable
      {
         if(UnknownVarFromReferenceVariable_Dictionary_1 == null)
         {
            return null;
         }
         for each(var _loc3_ in UnknownVarFromReferenceVariable_Dictionary_1)
         {
            for each(var _loc2_ in _loc3_)
            {
               if(_loc2_.variableId == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      override protected function get variableNameSection() : VariableNameSection
      {
         return _variableName;
      }
   }
}

