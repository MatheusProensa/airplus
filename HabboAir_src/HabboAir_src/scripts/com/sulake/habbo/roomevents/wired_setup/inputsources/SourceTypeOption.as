package com.sulake.habbo.roomevents.wired_setup.inputsources
{
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.VariableExtraSourceTypes;
   
   public class SourceTypeOption
   {
      private var _picker:SourceTypePicker;
      
      private var _container:IRegionWindow;
      
      private var _option:int;
      
      private var _active:Boolean = false;
      
      private var UnknownVarFromSourceTypeOption_Boolean_1:Boolean = false;
      
      private var UnknownVarFromSourceTypeOption_Boolean_2:Boolean = false;
      
      public function SourceTypeOption(param1:SourceTypePicker, param2:IRegionWindow, param3:int)
      {
         super();
         _picker = param1;
         _container = param2;
         _option = param3;
         _container.addEventListener("WME_CLICK",onClick);
         _container.addEventListener("WME_OVER",onOver);
         _container.addEventListener("WME_OUT",onOut);
         var _loc4_:HabboUserDefinedRoomEvents = param1.roomEvents;
         var _loc5_:String = WiredInputSourcePicker.getTypeNameForSource(param3);
         _container.toolTipCaption = _loc4_.localization.getLocalization("wiredfurni.params.sourcetype." + _loc5_);
         bitmapContainer.bitmap = _loc4_.getButtonImage("icon_source_" + _loc5_);
         updateColoring();
      }
      
      public function activate() : void
      {
         _active = true;
         updateColoring();
      }
      
      public function deactivate() : void
      {
         _active = false;
         updateColoring();
      }
      
      private function onOut(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromSourceTypeOption_Boolean_2 || !_container.isEnabled())
         {
            return;
         }
         UnknownVarFromSourceTypeOption_Boolean_1 = false;
         updateColoring();
      }
      
      private function onOver(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromSourceTypeOption_Boolean_2 || !_container.isEnabled())
         {
            return;
         }
         UnknownVarFromSourceTypeOption_Boolean_1 = true;
         updateColoring();
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         _picker.onClick(this);
      }
      
      internal function backgroundColor() : uint
      {
         var _loc3_:* = 0;
         var _loc1_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc2_:Number = NaN;
         if(!_active && !UnknownVarFromSourceTypeOption_Boolean_1)
         {
            return 2236962;
         }
         if(_option == WiredInputSourcePicker.USER_SOURCE)
         {
            _loc3_ = 2526761;
         }
         else if(_option == WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1)
         {
            _loc3_ = 12228630;
         }
         else if(_option == VariableExtraSourceTypes.CONTEXT_SOURCE)
         {
            _loc3_ = 11558430;
         }
         else
         {
            _loc3_ = 1934221;
         }
         var _loc4_:Number = UnknownVarFromSourceTypeOption_Boolean_2 ? 0.5 : (UnknownVarFromSourceTypeOption_Boolean_1 ? 0.86 : 1);
         if(_loc4_ != 1)
         {
            _loc1_ = _loc3_ >> 16 & 0xFF;
            _loc5_ = _loc3_ >> 8 & 0xFF;
            _loc2_ = _loc3_ & 0xFF;
            _loc1_ *= _loc4_;
            _loc5_ *= _loc4_;
            _loc2_ *= _loc4_;
            _loc3_ = (_loc1_ << 16) + (_loc5_ << 8) + _loc2_;
         }
         return _loc3_;
      }
      
      private function updateColoring() : void
      {
         elements.color = 4278190080 | backgroundColor();
         _picker.colorHasUpdated(this);
      }
      
      public function get option() : int
      {
         return _option;
      }
      
      public function get container() : IRegionWindow
      {
         return _container;
      }
      
      public function set disabled(param1:Boolean) : void
      {
         if(param1)
         {
            _container.disable();
         }
         else
         {
            _container.enable();
         }
         var _loc2_:Number = param1 ? 0.5 : 1;
         elements.blend = _loc2_;
         bitmapContainer.blend = _loc2_;
         UnknownVarFromSourceTypeOption_Boolean_2 = param1;
         updateColoring();
      }
      
      public function dispose() : void
      {
         if(_container != null)
         {
            _container.dispose();
            _container = null;
         }
      }
      
      private function get bitmapContainer() : IBitmapWrapperController
      {
         return IBitmapWrapperController(_container.findChildByName("type_icon_bitmap"));
      }
      
      private function get elements() : IItemListWindow
      {
         return IItemListWindow(_container.findChildByName("source_elements"));
      }
   }
}

