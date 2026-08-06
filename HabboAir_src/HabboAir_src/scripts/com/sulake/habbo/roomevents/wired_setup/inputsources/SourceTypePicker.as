package com.sulake.habbo.roomevents.wired_setup.inputsources
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents7;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   
   public class SourceTypePicker implements ISourceTypePicker
   {
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var _container:IItemListWindow;
      
      private var UnknownVarFromSourceTypePicker_IWiredInputSourcePicker_1:IWiredInputSourcePicker;
      
      private var UnknownVarFromSourceTypePicker_Map_1:Map = new Map();
      
      private var UnknownVarFromSourceTypePicker_SourceTypeOption_1:SourceTypeOption;
      
      private var UnknownVarFromSourceTypePicker_IRegionWindow_1:IRegionWindow;
      
      private var UnknownVarFromSourceTypePicker_SourceTypeOption_2:SourceTypeOption = null;
      
      private var UnknownVarFromSourceTypePicker_SourceTypeOption_3:SourceTypeOption = null;
      
      private var _disposed:Boolean = false;
      
      public function SourceTypePicker(param1:HabboUserDefinedRoomEvents, param2:IItemListWindow, param3:IWiredInputSourcePicker)
      {
         super();
         _roomEvents = param1;
         _container = param2;
         UnknownVarFromSourceTypePicker_IWiredInputSourcePicker_1 = param3;
         UnknownVarFromSourceTypePicker_IRegionWindow_1 = sourceOptionsList.getListItemAt(0) as IRegionWindow;
         sourceOptionsList.removeListItems();
      }
      
      public function initialize(param1:Array, param2:int) : void
      {
         var _loc5_:SourceTypeOption = null;
         if(UnknownVarFromSourceTypePicker_SourceTypeOption_1 != null)
         {
            UnknownVarFromSourceTypePicker_SourceTypeOption_1.deactivate();
            UnknownVarFromSourceTypePicker_SourceTypeOption_1 = null;
         }
         UnknownVarFromSourceTypePicker_SourceTypeOption_2 = null;
         UnknownVarFromSourceTypePicker_SourceTypeOption_3 = null;
         marginLeft.color = 4280427042;
         marginRight.color = 4280427042;
         var _loc3_:IItemListWindow = sourceOptionsList;
         _loc3_.removeListItems();
         for each(var _loc4_ in param1)
         {
            if(!UnknownVarFromSourceTypePicker_Map_1.hasKey(_loc4_))
            {
               _loc5_ = new SourceTypeOption(this,UnknownVarFromSourceTypePicker_IRegionWindow_1.clone() as IRegionWindow,_loc4_);
               UnknownVarFromSourceTypePicker_Map_1.add(_loc4_,_loc5_);
            }
            else
            {
               _loc5_ = UnknownVarFromSourceTypePicker_Map_1.getValue(_loc4_);
            }
            if(UnknownVarFromSourceTypePicker_SourceTypeOption_2 == null)
            {
               UnknownVarFromSourceTypePicker_SourceTypeOption_2 = _loc5_;
            }
            UnknownVarFromSourceTypePicker_SourceTypeOption_3 = _loc5_;
            _loc3_.addListItem(_loc5_.container);
            if(_loc4_ == param2)
            {
               UnknownVarFromSourceTypePicker_SourceTypeOption_1 = _loc5_;
            }
         }
         if(UnknownVarFromSourceTypePicker_SourceTypeOption_1 != null)
         {
            UnknownVarFromSourceTypePicker_SourceTypeOption_1.activate();
         }
         else if(param1.length > 0)
         {
            onClick(UnknownVarFromSourceTypePicker_Map_1.getValue(param1[0]));
         }
      }
      
      public function select(param1:int) : void
      {
         for each(var _loc2_ in UnknownVarFromSourceTypePicker_Map_1.getValues())
         {
            if(param1 == _loc2_.option)
            {
               onClick(_loc2_);
            }
         }
      }
      
      internal function colorHasUpdated(param1:SourceTypeOption) : void
      {
         if(param1 == UnknownVarFromSourceTypePicker_SourceTypeOption_2)
         {
            marginLeft.color = 4278190080 | param1.backgroundColor();
         }
         if(param1 == UnknownVarFromSourceTypePicker_SourceTypeOption_3)
         {
            marginRight.color = 4278190080 | param1.backgroundColor();
         }
      }
      
      public function set disabled(param1:Boolean) : void
      {
         var _loc2_:Number = param1 ? 0.5 : 1;
         marginLeft.blend = _loc2_;
         marginRight.blend = _loc2_;
         for each(var _loc3_ in UnknownVarFromSourceTypePicker_Map_1)
         {
            _loc3_.disabled = param1;
         }
      }
      
      public function set visible(param1:Boolean) : void
      {
         _container.visible = param1;
      }
      
      internal function onClick(param1:SourceTypeOption) : void
      {
         if(param1 == UnknownVarFromSourceTypePicker_SourceTypeOption_1)
         {
            return;
         }
         if(UnknownVarFromSourceTypePicker_SourceTypeOption_1 != null)
         {
            UnknownVarFromSourceTypePicker_SourceTypeOption_1.deactivate();
            UnknownVarFromSourceTypePicker_SourceTypeOption_1 = null;
         }
         if(param1 != null)
         {
            UnknownVarFromSourceTypePicker_SourceTypeOption_1 = param1;
            UnknownVarFromSourceTypePicker_SourceTypeOption_1.activate();
            UnknownVarFromSourceTypePicker_IWiredInputSourcePicker_1.sourceType = UnknownVarFromSourceTypePicker_SourceTypeOption_1.option;
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
         UnknownVarFromSourceTypePicker_IRegionWindow_1.dispose();
         UnknownVarFromSourceTypePicker_IRegionWindow_1 = null;
         for each(var _loc1_ in UnknownVarFromSourceTypePicker_Map_1.getValues())
         {
            _loc1_.dispose();
         }
         UnknownVarFromSourceTypePicker_Map_1.dispose();
         UnknownVarFromSourceTypePicker_Map_1 = null;
      }
      
      private function get marginLeft() : UnknownICoreWindowComponents7
      {
         return UnknownICoreWindowComponents7(_container.findChildByName("margin_item_color_left"));
      }
      
      private function get marginRight() : UnknownICoreWindowComponents7
      {
         return UnknownICoreWindowComponents7(_container.findChildByName("margin_item_color_right"));
      }
      
      private function get sourceOptionsList() : IItemListWindow
      {
         return IItemListWindow(_container.findChildByName("source_options_list"));
      }
   }
}

