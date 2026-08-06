package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class CheckboxGroupPreset extends WiredUIPreset
   {
      private var _container:IItemListWindow;
      
      private var UnknownVarFromCheckboxGroupPreset_Map_1:Map;
      
      private var UnknownVarFromCheckboxGroupPreset_Function_1:Function;
      
      private var UnknownVarFromCheckboxGroupPreset_Vector_1:Vector.<IItemListWindow>;
      
      private var UnknownVarFromCheckboxGroupPreset_Int_1:int;
      
      public function CheckboxGroupPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Array, param5:Function, param6:int = 1)
      {
         var _loc9_:* = false;
         var _loc8_:CheckboxOptionPreset = null;
         super(param1,param2,param3);
         _container = param2.createLayout("vertical_list_view") as IItemListWindow;
         UnknownVarFromCheckboxGroupPreset_Int_1 = param6;
         UnknownVarFromCheckboxGroupPreset_Function_1 = param5;
         var _loc10_:int = 0;
         var _loc7_:IItemListWindow = null;
         if(UnknownVarFromCheckboxGroupPreset_Int_1 > 0)
         {
            UnknownVarFromCheckboxGroupPreset_Vector_1 = new Vector.<IItemListWindow>();
         }
         UnknownVarFromCheckboxGroupPreset_Map_1 = new Map();
         for each(var _loc11_ in param4)
         {
            if(_loc11_.id == -1)
            {
               _loc11_.id = _loc10_;
            }
            _loc9_ = param4[param4.length - 1] == _loc11_;
            _loc8_ = param2.createCheckboxOption(_loc11_,_loc9_);
            UnknownVarFromCheckboxGroupPreset_Map_1.add(_loc11_.id,_loc8_);
            if(param6 > 1)
            {
               if(_loc10_ % param6 == 0)
               {
                  _loc7_ = param2.createLayout("horizontal_list_view") as IItemListWindow;
                  _loc7_.spacing = param3.genericHorizontalSpacing;
                  UnknownVarFromCheckboxGroupPreset_Vector_1.push(_loc7_);
                  _container.addListItem(_loc7_);
               }
               _loc7_.addListItem(_loc8_.window);
            }
            else
            {
               _container.addListItem(_loc8_.window);
            }
            if(param5 != null)
            {
               _loc8_.checkbox.addEventListener("WE_SELECTED",onSelectionChange);
               _loc8_.checkbox.addEventListener("WE_UNSELECTED",onSelectionChange);
            }
            _loc10_++;
         }
      }
      
      private function onSelectionChange(param1:WindowEvent) : void
      {
         var _loc2_:int = 0;
         if(UnknownVarFromCheckboxGroupPreset_Function_1 != null)
         {
            _loc2_ = param1.window.id;
            UnknownVarFromCheckboxGroupPreset_Function_1(_loc2_,get(_loc2_).selected);
         }
      }
      
      public function get(param1:int) : CheckboxOptionPreset
      {
         return UnknownVarFromCheckboxGroupPreset_Map_1.getValue(param1);
      }
      
      public function get numCheckboxes() : int
      {
         return UnknownVarFromCheckboxGroupPreset_Map_1.length;
      }
      
      public function get mask() : int
      {
         var _loc1_:* = 0;
         for each(var _loc2_ in UnknownVarFromCheckboxGroupPreset_Map_1.getValues())
         {
            if(_loc2_.selected)
            {
               _loc1_ |= 1 << _loc2_.checkbox.id;
            }
         }
         return _loc1_;
      }
      
      public function set mask(param1:int) : void
      {
         var _loc2_:* = false;
         for each(var _loc3_ in UnknownVarFromCheckboxGroupPreset_Map_1.getValues())
         {
            _loc2_ = (param1 & 1 << _loc3_.checkbox.id) != 0;
            Util.select(_loc3_.checkbox,_loc2_);
         }
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         var _loc5_:IItemListWindow = null;
         super.resizeToWidth(param1);
         _container.width = param1;
         var _loc2_:int = (param1 - (UnknownVarFromCheckboxGroupPreset_Int_1 - 1) * UnknownVarFromWiredUIPreset_WiredStyle_1.genericHorizontalSpacing) / UnknownVarFromCheckboxGroupPreset_Int_1;
         var _loc3_:int = 0;
         for each(var _loc4_ in UnknownVarFromCheckboxGroupPreset_Map_1.getValues())
         {
            _loc4_.resizeToWidth(_loc2_);
            if(UnknownVarFromCheckboxGroupPreset_Int_1 > 1)
            {
               _loc5_ = UnknownVarFromCheckboxGroupPreset_Vector_1[int(_loc3_ / UnknownVarFromCheckboxGroupPreset_Int_1)];
               if(_loc4_.window.height > _loc5_.height)
               {
                  _loc5_.height = _loc4_.window.height;
               }
            }
            _loc3_++;
         }
      }
      
      override public function get window() : IWindowModel
      {
         return _container;
      }
      
      override protected function get childPresets() : Array
      {
         return UnknownVarFromCheckboxGroupPreset_Map_1.getValues();
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _container.dispose();
         _container = null;
         UnknownVarFromCheckboxGroupPreset_Map_1 = null;
         UnknownVarFromCheckboxGroupPreset_Function_1 = null;
         UnknownVarFromCheckboxGroupPreset_Vector_1 = null;
      }
   }
}

