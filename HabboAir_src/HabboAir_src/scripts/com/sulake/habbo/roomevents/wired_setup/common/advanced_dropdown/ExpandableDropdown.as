package com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.events.WindowEvent;
   
   public class ExpandableDropdown implements IComponentInterfaceQueue
   {
      private var _disposed:Boolean;
      
      private var _dropdown:IDropBaseController_1;
      
      private var _onChangeCallback:Function;
      
      private var UnknownVarFromExpandableDropdown_Boolean_1:Boolean = false;
      
      private var UnknownVarFromExpandableDropdown_Boolean_2:Boolean = false;
      
      private var UnknownVarFromExpandableDropdown_Number_1:Number = 0;
      
      private var UnknownVarFromExpandableDropdown_Vector_1:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
      
      private var UnknownVarFromExpandableDropdown_String_1:String;
      
      private var _dropdownOptions:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
      
      public function ExpandableDropdown(param1:IDropBaseController_1, param2:String, param3:Function = null)
      {
         super();
         _dropdown = param1;
         UnknownVarFromExpandableDropdown_String_1 = param2;
         _onChangeCallback = param3;
         _dropdown.addEventListener("WE_SELECTED",onSelectAction);
         _dropdown.addEventListener("WE_COLLAPSE",onDropdownCollapse);
      }
      
      public function init(param1:Vector.<ExpandableDropdownOption>, param2:int) : void
      {
         UnknownVarFromExpandableDropdown_Vector_1 = param1;
         UnknownVarFromExpandableDropdown_Boolean_2 = false;
         UnknownVarFromExpandableDropdown_Boolean_1 = false;
         UnknownVarFromExpandableDropdown_Number_1 = 0;
         populate(param2);
      }
      
      public function get dropdownOptions() : Vector.<ExpandableDropdownOption>
      {
         return _dropdownOptions;
      }
      
      private function populate(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:int = -1;
         _dropdownOptions.splice(0,_dropdownOptions.length);
         var _loc4_:Vector.<String> = new Vector.<String>();
         for each(var _loc5_ in UnknownVarFromExpandableDropdown_Vector_1)
         {
            if(param1 == _loc5_.id)
            {
               _loc3_ = int(_dropdownOptions.length);
               if(_loc5_.isAdvanced && !param2)
               {
                  UnknownVarFromExpandableDropdown_Boolean_1 = true;
                  populate(param1,true);
                  return;
               }
            }
            if(!_loc5_.isAdvanced || param2)
            {
               _dropdownOptions.push(_loc5_);
               _loc4_.push(_loc5_.displayString);
            }
         }
         if(advancedOptionsAvailable && !param2)
         {
            _loc4_.push(UnknownVarFromExpandableDropdown_String_1);
         }
         UnknownVarFromExpandableDropdown_Boolean_2 = true;
         _dropdown.populateWithVector(_loc4_);
         if(_loc3_ != -1)
         {
            _dropdown.selection = _loc3_;
            UnknownVarFromExpandableDropdown_Number_1 = param1;
         }
         else
         {
            UnknownVarFromExpandableDropdown_Number_1 = -1;
         }
      }
      
      private function get advancedOptionsAvailable() : Boolean
      {
         for each(var _loc1_ in UnknownVarFromExpandableDropdown_Vector_1)
         {
            if(_loc1_.isAdvanced)
            {
               return true;
            }
         }
         return false;
      }
      
      private function onSelectAction(param1:WindowEvent) : void
      {
         if(_dropdown.selection >= _dropdownOptions.length)
         {
            UnknownVarFromExpandableDropdown_Boolean_1 = true;
            populate(UnknownVarFromExpandableDropdown_Number_1,true);
            _dropdown.openMenu();
            return;
         }
         UnknownVarFromExpandableDropdown_Number_1 = selectedOptionId;
         if(_onChangeCallback != null)
         {
            _onChangeCallback(selectedOption);
         }
      }
      
      private function onDropdownCollapse(param1:WindowEvent) : void
      {
         if(UnknownVarFromExpandableDropdown_Boolean_2)
         {
            UnknownVarFromExpandableDropdown_Boolean_2 = false;
            return;
         }
         if(UnknownVarFromExpandableDropdown_Boolean_1 && (selectedOption == null || !selectedOption.isAdvanced))
         {
            UnknownVarFromExpandableDropdown_Boolean_1 = false;
            populate(selectedOptionId,false);
         }
      }
      
      public function get selectedOption() : ExpandableDropdownOption
      {
         var _loc1_:Number = _dropdown.selection;
         if(_loc1_ < 0 || _loc1_ >= _dropdownOptions.length)
         {
            return null;
         }
         return _dropdownOptions[_loc1_];
      }
      
      public function get selectedOptionId() : Number
      {
         return selectedOption?.id;
      }
      
      public function set selectedOptionId(param1:Number) : void
      {
         init(UnknownVarFromExpandableDropdown_Vector_1,param1);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _dropdown.dispose();
         _dropdown = null;
         _onChangeCallback = null;
         UnknownVarFromExpandableDropdown_Vector_1 = null;
         UnknownVarFromExpandableDropdown_String_1 = null;
         _dropdownOptions = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

