package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.applications
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.utils.ChronoFieldRangeFilter;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.NumberInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.NumberInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class ChronoRangeFilterPreset extends WiredUIPreset
   {
      public static const MODE_SKIP:int = 0;
      
      public static const MODE_EXACT:int = 1;
      
      public static const MODE_RANGE:int = 2;
      
      private var _radioGroup:RadioGroupPreset;
      
      private var UnknownVarFromChronoRangeFilterPreset_NumberInputPreset_1:NumberInputPreset;
      
      private var UnknownVarFromChronoRangeFilterPreset_NumberInputPreset_2:NumberInputPreset;
      
      private var UnknownVarFromChronoRangeFilterPreset_NumberInputPreset_3:NumberInputPreset;
      
      private var UnknownVarFromChronoRangeFilterPreset_Int_1:int;
      
      public function ChronoRangeFilterPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:String, param6:String, param7:int, param8:int, param9:int, param10:int)
      {
         super(param1,param2,param3);
         UnknownVarFromChronoRangeFilterPreset_Int_1 = param7;
         UnknownVarFromChronoRangeFilterPreset_NumberInputPreset_1 = param2.createNumberInput(new NumberInputParam(param7,param8,param9,param10));
         UnknownVarFromChronoRangeFilterPreset_NumberInputPreset_2 = param2.createNumberInput(new NumberInputParam(param7,param8,param9,param10));
         UnknownVarFromChronoRangeFilterPreset_NumberInputPreset_3 = param2.createNumberInput(new NumberInputParam(param7,param8,param9,param10));
         var _loc11_:TextPreset = param2.createText("-",new TextParam(0));
         var _loc12_:SimpleListViewPreset = param2.createSimpleListView(false,[UnknownVarFromChronoRangeFilterPreset_NumberInputPreset_2,_loc11_,UnknownVarFromChronoRangeFilterPreset_NumberInputPreset_3],true);
         var _loc13_:Array = [new RadioButtonParam(0,param4),new RadioButtonParam(1,param5,UnknownVarFromChronoRangeFilterPreset_NumberInputPreset_1),new RadioButtonParam(2,param6,_loc12_)];
         _radioGroup = param2.createRadioGroup(_loc13_);
         _radioGroup.selected = 0;
      }
      
      public function applyFilter(param1:ChronoFieldRangeFilter) : void
      {
         if(!param1.useFilter)
         {
            _radioGroup.selected = 0;
            UnknownVarFromChronoRangeFilterPreset_NumberInputPreset_1.value = UnknownVarFromChronoRangeFilterPreset_Int_1;
            UnknownVarFromChronoRangeFilterPreset_NumberInputPreset_2.value = UnknownVarFromChronoRangeFilterPreset_Int_1;
            UnknownVarFromChronoRangeFilterPreset_NumberInputPreset_3.value = UnknownVarFromChronoRangeFilterPreset_Int_1;
            return;
         }
         if(param1.min == param1.max)
         {
            _radioGroup.selected = 1;
            UnknownVarFromChronoRangeFilterPreset_NumberInputPreset_1.value = param1.min;
            UnknownVarFromChronoRangeFilterPreset_NumberInputPreset_2.value = UnknownVarFromChronoRangeFilterPreset_Int_1;
            UnknownVarFromChronoRangeFilterPreset_NumberInputPreset_3.value = UnknownVarFromChronoRangeFilterPreset_Int_1;
            return;
         }
         _radioGroup.selected = 2;
         UnknownVarFromChronoRangeFilterPreset_NumberInputPreset_2.value = param1.min;
         UnknownVarFromChronoRangeFilterPreset_NumberInputPreset_3.value = param1.max;
         UnknownVarFromChronoRangeFilterPreset_NumberInputPreset_1.value = UnknownVarFromChronoRangeFilterPreset_Int_1;
      }
      
      public function getFilter(param1:String) : ChronoFieldRangeFilter
      {
         if(_radioGroup.selected == 0)
         {
            return new ChronoFieldRangeFilter(param1,false,UnknownVarFromChronoRangeFilterPreset_Int_1,UnknownVarFromChronoRangeFilterPreset_Int_1,UnknownVarFromChronoRangeFilterPreset_Int_1);
         }
         if(_radioGroup.selected == 1)
         {
            return new ChronoFieldRangeFilter(param1,true,UnknownVarFromChronoRangeFilterPreset_NumberInputPreset_1.value,UnknownVarFromChronoRangeFilterPreset_NumberInputPreset_1.value,UnknownVarFromChronoRangeFilterPreset_Int_1);
         }
         return new ChronoFieldRangeFilter(param1,true,UnknownVarFromChronoRangeFilterPreset_NumberInputPreset_2.value,UnknownVarFromChronoRangeFilterPreset_NumberInputPreset_3.value,UnknownVarFromChronoRangeFilterPreset_Int_1);
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _radioGroup.resizeToWidth(param1);
      }
      
      override public function get window() : IWindowModel
      {
         return _radioGroup.window;
      }
      
      override protected function get childPresets() : Array
      {
         return [_radioGroup];
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _radioGroup = null;
         UnknownVarFromChronoRangeFilterPreset_NumberInputPreset_1 = null;
         UnknownVarFromChronoRangeFilterPreset_NumberInputPreset_2 = null;
         UnknownVarFromChronoRangeFilterPreset_NumberInputPreset_3 = null;
      }
   }
}

