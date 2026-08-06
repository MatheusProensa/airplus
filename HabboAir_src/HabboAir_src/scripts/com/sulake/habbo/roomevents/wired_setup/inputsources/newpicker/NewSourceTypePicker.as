package com.sulake.habbo.roomevents.wired_setup.inputsources.newpicker
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents5;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.ISourceTypePicker;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.IWiredInputSourcePicker;
   
   public class NewSourceTypePicker implements ISourceTypePicker
   {
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var _container:IItemListWindow;
      
      private var UnknownVarFromNewSourceTypePicker_IWiredInputSourcePicker_1:IWiredInputSourcePicker;
      
      private var UnknownVarFromNewSourceTypePicker_Map_1:Map = new Map();
      
      private var _splitters:Vector.<IWindowController_1>;
      
      private var UnknownVarFromNewSourceTypePicker_NewSourceTypeOption_1:NewSourceTypeOption;
      
      private var UnknownVarFromNewSourceTypePicker_UnknownICoreWindowComponents5_1:UnknownICoreWindowComponents5;
      
      private var UnknownVarFromNewSourceTypePicker_UnknownICoreWindowComponents5_2:UnknownICoreWindowComponents5;
      
      private var UnknownVarFromNewSourceTypePicker_UnknownICoreWindowComponents5_3:UnknownICoreWindowComponents5;
      
      private var UnknownVarFromNewSourceTypePicker_IWindowController_1_1:IWindowController_1;
      
      private var _splitterBaseColor:uint;
      
      private var UnknownVarFromNewSourceTypePicker_Boolean_1:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function NewSourceTypePicker(param1:HabboUserDefinedRoomEvents, param2:IItemListWindow, param3:IWiredInputSourcePicker)
      {
         super();
         _roomEvents = param1;
         _container = param2;
         UnknownVarFromNewSourceTypePicker_IWiredInputSourcePicker_1 = param3;
         UnknownVarFromNewSourceTypePicker_UnknownICoreWindowComponents5_1 = param2.getListItemAt(0) as UnknownICoreWindowComponents5;
         UnknownVarFromNewSourceTypePicker_IWindowController_1_1 = param2.getListItemAt(1) as IWindowController_1;
         _splitterBaseColor = UnknownVarFromNewSourceTypePicker_IWindowController_1_1.getChildAt(0).color & 0xFFFFFF;
         UnknownVarFromNewSourceTypePicker_UnknownICoreWindowComponents5_2 = param2.getListItemAt(2) as UnknownICoreWindowComponents5;
         UnknownVarFromNewSourceTypePicker_UnknownICoreWindowComponents5_3 = param2.getListItemAt(4) as UnknownICoreWindowComponents5;
         param2.removeListItems();
      }
      
      private function clear() : void
      {
         _container.removeListItems();
         for each(var _loc2_ in UnknownVarFromNewSourceTypePicker_Map_1.getValues())
         {
            _loc2_.dispose();
         }
         for each(var _loc1_ in _splitters)
         {
            _loc1_.dispose();
         }
      }
      
      public function initialize(param1:Array, param2:int) : void
      {
         var _loc7_:NewSourceTypeOption = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:UnknownICoreWindowComponents5 = null;
         var _loc6_:IWindowController_1 = null;
         UnknownVarFromNewSourceTypePicker_Boolean_1 = true;
         if(UnknownVarFromNewSourceTypePicker_NewSourceTypeOption_1 != null)
         {
            UnknownVarFromNewSourceTypePicker_NewSourceTypeOption_1.deactivate();
            UnknownVarFromNewSourceTypePicker_NewSourceTypeOption_1 = null;
         }
         clear();
         UnknownVarFromNewSourceTypePicker_Map_1 = new Map();
         _splitters = new Vector.<IWindowController_1>();
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = int(param1[_loc3_]);
            if(_loc3_ == 0)
            {
               _loc5_ = UnknownVarFromNewSourceTypePicker_UnknownICoreWindowComponents5_1.clone() as UnknownICoreWindowComponents5;
            }
            else if(_loc3_ == param1.length - 1)
            {
               _loc5_ = UnknownVarFromNewSourceTypePicker_UnknownICoreWindowComponents5_3.clone() as UnknownICoreWindowComponents5;
            }
            else
            {
               _loc5_ = UnknownVarFromNewSourceTypePicker_UnknownICoreWindowComponents5_2.clone() as UnknownICoreWindowComponents5;
            }
            _loc7_ = new NewSourceTypeOption(this,_loc5_,_loc4_);
            UnknownVarFromNewSourceTypePicker_Map_1.add(_loc4_,_loc7_);
            _container.addListItem(_loc7_.container);
            if(_loc4_ == param2)
            {
               UnknownVarFromNewSourceTypePicker_NewSourceTypeOption_1 = _loc7_;
            }
            if(_loc3_ != param1.length - 1)
            {
               _loc6_ = UnknownVarFromNewSourceTypePicker_IWindowController_1_1.clone() as IWindowController_1;
               _container.addListItem(_loc6_);
               _splitters.push(_loc6_);
            }
            _loc3_ += 1;
         }
         if(UnknownVarFromNewSourceTypePicker_NewSourceTypeOption_1 != null)
         {
            UnknownVarFromNewSourceTypePicker_NewSourceTypeOption_1.activate();
         }
         else if(param1.length > 0)
         {
            onClick(UnknownVarFromNewSourceTypePicker_Map_1.getValue(param1[0]));
         }
         UnknownVarFromNewSourceTypePicker_Boolean_1 = false;
         updateColorings();
      }
      
      public function select(param1:int) : void
      {
         for each(var _loc2_ in UnknownVarFromNewSourceTypePicker_Map_1.getValues())
         {
            if(param1 == _loc2_.option)
            {
               onClick(_loc2_);
            }
         }
      }
      
      internal function onClick(param1:NewSourceTypeOption) : void
      {
         if(param1 == UnknownVarFromNewSourceTypePicker_NewSourceTypeOption_1)
         {
            return;
         }
         if(UnknownVarFromNewSourceTypePicker_NewSourceTypeOption_1 != null)
         {
            UnknownVarFromNewSourceTypePicker_NewSourceTypeOption_1.deactivate();
            UnknownVarFromNewSourceTypePicker_NewSourceTypeOption_1 = null;
         }
         if(param1 != null)
         {
            UnknownVarFromNewSourceTypePicker_NewSourceTypeOption_1 = param1;
            UnknownVarFromNewSourceTypePicker_NewSourceTypeOption_1.activate();
            UnknownVarFromNewSourceTypePicker_IWiredInputSourcePicker_1.sourceType = UnknownVarFromNewSourceTypePicker_NewSourceTypeOption_1.option;
         }
      }
      
      private function multiplyColors(param1:uint, param2:uint) : uint
      {
         var _loc3_:uint = (param1 >> 16 & 0xFF) * (param2 >> 16 & 0xFF) / 255;
         var _loc5_:uint = (param1 >> 8 & 0xFF) * (param2 >> 8 & 0xFF) / 255;
         var _loc4_:uint = (param1 & 0xFF) * (param2 & 0xFF) / 255;
         return _loc3_ << 16 | _loc5_ << 8 | _loc4_;
      }
      
      internal function updateColorings() : void
      {
         var _loc3_:int = 0;
         var _loc5_:IWindowController_1 = null;
         var _loc2_:NewSourceTypeOption = null;
         var _loc4_:NewSourceTypeOption = null;
         var _loc1_:* = 0;
         if(UnknownVarFromNewSourceTypePicker_Boolean_1)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < _splitters.length)
         {
            _loc5_ = _splitters[_loc3_];
            _loc2_ = UnknownVarFromNewSourceTypePicker_Map_1.getValueByIndex(_loc3_);
            _loc4_ = UnknownVarFromNewSourceTypePicker_Map_1.getValueByIndex(_loc3_ + 1);
            _loc1_ = 16777215;
            if(_loc2_.active || !_loc4_.active && _loc2_.hovered)
            {
               _loc1_ = _loc2_.color;
            }
            else if(_loc4_.active || _loc4_.hovered)
            {
               _loc1_ = _loc4_.color;
            }
            _loc1_ = multiplyColors(_splitterBaseColor,_loc1_);
            _loc1_ = uint(_loc5_.getChildAt(0).color & -16777216 | _loc1_ & 0xFFFFFF);
            _loc5_.getChildAt(0).color = _loc1_;
            _loc3_ += 1;
         }
      }
      
      public function get roomEvents() : HabboUserDefinedRoomEvents
      {
         return _roomEvents;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         clear();
         _container.dispose();
         _container = null;
         UnknownVarFromNewSourceTypePicker_UnknownICoreWindowComponents5_1.dispose();
         UnknownVarFromNewSourceTypePicker_UnknownICoreWindowComponents5_1 = null;
         UnknownVarFromNewSourceTypePicker_UnknownICoreWindowComponents5_2.dispose();
         UnknownVarFromNewSourceTypePicker_UnknownICoreWindowComponents5_2 = null;
         UnknownVarFromNewSourceTypePicker_UnknownICoreWindowComponents5_3.dispose();
         UnknownVarFromNewSourceTypePicker_UnknownICoreWindowComponents5_3 = null;
         UnknownVarFromNewSourceTypePicker_IWindowController_1_1.dispose();
         UnknownVarFromNewSourceTypePicker_IWindowController_1_1 = null;
         UnknownVarFromNewSourceTypePicker_Map_1.dispose();
         UnknownVarFromNewSourceTypePicker_Map_1 = null;
         _splitters = null;
         UnknownVarFromNewSourceTypePicker_NewSourceTypeOption_1 = null;
      }
   }
}

