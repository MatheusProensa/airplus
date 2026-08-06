package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ItemListController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class RadioGroupPreset extends WiredUIPreset
   {
      private var _container:ISelectorWindow;
      
      private var UnknownVarFromRadioGroupPreset_Vector_1:Vector.<RadioButtonPreset>;
      
      private var UnknownVarFromRadioGroupPreset_Function_1:Function;
      
      private var UnknownVarFromRadioGroupPreset_Vector_2:Vector.<IItemListWindow>;
      
      private var UnknownVarFromRadioGroupPreset_Int_1:int;
      
      public function RadioGroupPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Array, param5:Function, param6:int = 1)
      {
         var _loc7_:* = false;
         var _loc9_:RadioButtonPreset = null;
         super(param1,param2,param3);
         _container = param2.createLayout("radio_group_view") as ISelectorWindow;
         UnknownVarFromRadioGroupPreset_Int_1 = param6;
         var _loc8_:int = 0;
         var _loc10_:IItemListWindow = null;
         if(UnknownVarFromRadioGroupPreset_Int_1 > 0)
         {
            UnknownVarFromRadioGroupPreset_Vector_2 = new Vector.<IItemListWindow>();
         }
         UnknownVarFromRadioGroupPreset_Vector_1 = new Vector.<RadioButtonPreset>();
         var _loc11_:int = -1;
         var _loc12_:int = 0;
         for each(var _loc13_ in param4)
         {
            _loc7_ = param4[param4.length - 1] == _loc13_;
            _loc9_ = param2.createRadioButton(_loc13_,_loc7_);
            UnknownVarFromRadioGroupPreset_Vector_1.push(_loc9_);
            if(param6 > 1)
            {
               if(_loc12_ == 0)
               {
                  _loc10_ = param2.createLayout("horizontal_list_view") as IItemListWindow;
                  _loc10_.spacing = param3.genericHorizontalSpacing;
                  UnknownVarFromRadioGroupPreset_Vector_2.push(_loc10_);
                  itemList.addListItem(_loc10_);
                  _loc11_++;
               }
               _loc10_.addListItem(_loc9_.window);
               _loc9_.layoutRowIndex = _loc11_;
               _loc9_.layoutColumnIndex = _loc12_;
               _loc9_.spanRemainingWidth = _loc13_.newLine;
               if(_loc13_.newLine || _loc12_ == param6 - 1)
               {
                  _loc12_ = 0;
               }
               else
               {
                  _loc12_++;
               }
            }
            else
            {
               itemList.addListItem(_loc9_.window);
            }
            if(param5 != null)
            {
               _loc9_.radioButton.addEventListener("WE_SELECTED",onSelectionChange);
            }
         }
         selected = 0;
         UnknownVarFromRadioGroupPreset_Function_1 = param5;
      }
      
      private function onSelectionChange(param1:WindowEvent) : void
      {
         if(UnknownVarFromRadioGroupPreset_Function_1 != null)
         {
            UnknownVarFromRadioGroupPreset_Function_1(selected);
         }
      }
      
      public function get selected() : int
      {
         return _container.getSelected().id;
      }
      
      public function set selected(param1:int) : void
      {
         var _loc2_:IRadioButtonWindow = _container.findChildByName(RadioButtonPreset.OPTION_PREFIX + param1) as IRadioButtonWindow;
         _container.setSelected(_loc2_);
      }
      
      public function setOptionDisabled(param1:int, param2:Boolean) : void
      {
         UnknownVarFromRadioGroupPreset_Vector_1[param1].disabled = param2;
      }
      
      public function get(param1:int) : RadioButtonPreset
      {
         return UnknownVarFromRadioGroupPreset_Vector_1[param1];
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         var _loc2_:* = 0;
         var _loc5_:int = 0;
         var _loc8_:IItemListWindow = null;
         super.resizeToWidth(param1);
         _container.width = param1;
         itemList.width = param1;
         var _loc3_:int = (param1 - (UnknownVarFromRadioGroupPreset_Int_1 - 1) * UnknownVarFromWiredUIPreset_WiredStyle_1.genericHorizontalSpacing) / UnknownVarFromRadioGroupPreset_Int_1;
         if(UnknownVarFromRadioGroupPreset_Int_1 > 1)
         {
            for each(var _loc7_ in UnknownVarFromRadioGroupPreset_Vector_2)
            {
               _loc7_.height = 0;
               _loc7_.width = param1;
            }
         }
         var _loc4_:int = 0;
         for each(var _loc6_ in UnknownVarFromRadioGroupPreset_Vector_1)
         {
            _loc2_ = _loc3_;
            if(UnknownVarFromRadioGroupPreset_Int_1 > 1 && _loc6_.spanRemainingWidth)
            {
               _loc5_ = _loc6_.layoutColumnIndex * _loc3_ + _loc6_.layoutColumnIndex * UnknownVarFromWiredUIPreset_WiredStyle_1.genericHorizontalSpacing;
               _loc2_ = Math.max(_loc3_,param1 - _loc5_);
            }
            _loc6_.resizeToWidth(_loc2_);
            if(UnknownVarFromRadioGroupPreset_Int_1 > 1)
            {
               _loc8_ = UnknownVarFromRadioGroupPreset_Vector_2[_loc6_.layoutRowIndex];
               if(_loc6_.window.height > _loc8_.height)
               {
                  _loc8_.height = _loc6_.window.height;
               }
            }
            _loc4_++;
         }
      }
      
      private function get itemList() : ItemListController
      {
         return _container.findChildByName("radio_button_list") as ItemListController;
      }
      
      override public function get window() : IWindowModel
      {
         return _container;
      }
      
      override protected function get childPresets() : Array
      {
         return toArray(UnknownVarFromRadioGroupPreset_Vector_1);
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
         UnknownVarFromRadioGroupPreset_Vector_1 = null;
         UnknownVarFromRadioGroupPreset_Function_1 = null;
         UnknownVarFromRadioGroupPreset_Vector_2 = null;
      }
   }
}

