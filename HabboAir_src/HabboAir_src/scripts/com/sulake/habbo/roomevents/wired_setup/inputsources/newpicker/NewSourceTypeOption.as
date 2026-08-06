package com.sulake.habbo.roomevents.wired_setup.inputsources.newpicker
{
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.InteractiveController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents5;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.common.VariableExtraSourceTypes;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   
   public class NewSourceTypeOption
   {
      private var _picker:NewSourceTypePicker;
      
      private var _container:UnknownICoreWindowComponents5;
      
      private var _option:int;
      
      private var _active:Boolean = false;
      
      private var _hovered:Boolean = false;
      
      public function NewSourceTypeOption(param1:NewSourceTypePicker, param2:UnknownICoreWindowComponents5, param3:int)
      {
         super();
         _picker = param1;
         _container = param2;
         _option = param3;
         _container.addEventListener("WME_CLICK",onClick);
         _container.addEventListener("WME_OVER",onOver);
         _container.addEventListener("WME_OUT",onOut);
         _container.addEventListener("WME_OUT",maybeCancelEvent);
         _container.addEventListener("WME_UP",maybeCancelEvent);
         var _loc4_:HabboUserDefinedRoomEvents = param1.roomEvents;
         var _loc5_:String = WiredInputSourcePicker.getTypeNameForSource(param3);
         _container.toolTipCaption = _loc4_.localization.getLocalization("wiredfurni.params.sourcetype." + _loc5_);
         typeImage.assetUri = "wired_styles_illumina_icon_source_" + _loc5_;
         typeImage.y = (_container.height + 1) / 2 - (typeImage.height + 1) / 2;
         updateVisuals();
      }
      
      public function activate() : void
      {
         _active = true;
         updateVisuals();
      }
      
      public function deactivate() : void
      {
         _active = false;
         updateVisuals();
      }
      
      private function updateVisuals() : void
      {
         var _loc2_:* = 0;
         var _loc1_:InteractiveController = InteractiveController(_container);
         _loc1_.setStateFlag(16,_active);
         _loc1_.setStateFlag(4,_hovered);
         if(!_active && !_hovered)
         {
            _container.color = 16777215;
            _picker.updateColorings();
            return;
         }
         if(_option == WiredInputSourcePicker.USER_SOURCE)
         {
            _loc2_ = 2526761;
         }
         else if(_option == WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1)
         {
            _loc2_ = 12228630;
         }
         else if(_option == VariableExtraSourceTypes.CONTEXT_SOURCE)
         {
            _loc2_ = 11558430;
         }
         else
         {
            _loc2_ = 1934221;
         }
         var _loc3_:Number = 1.26;
         if(_hovered && !_active)
         {
            _loc3_ = 1.55;
         }
         _loc2_ = Util.lightenColor(_loc2_,_loc3_);
         _container.color = _loc2_;
         _picker.updateColorings();
      }
      
      public function get color() : uint
      {
         return _container.color;
      }
      
      private function onOut(param1:WindowMouseEvent) : void
      {
         if(!_container.isEnabled())
         {
            return;
         }
         _hovered = false;
         updateVisuals();
      }
      
      private function maybeCancelEvent(param1:WindowMouseEvent) : void
      {
         if(param1.type == "WME_OUT" && _active)
         {
            param1.preventWindowOperation();
         }
         if(param1.type == "WME_UP")
         {
            onClick(null);
            param1.preventWindowOperation();
         }
      }
      
      private function onOver(param1:WindowMouseEvent) : void
      {
         if(!_container.isEnabled())
         {
            return;
         }
         _hovered = true;
         updateVisuals();
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         _picker.onClick(this);
      }
      
      public function get option() : int
      {
         return _option;
      }
      
      public function get container() : UnknownICoreWindowComponents5
      {
         return _container;
      }
      
      public function get active() : Boolean
      {
         return _active;
      }
      
      public function get hovered() : Boolean
      {
         return _hovered;
      }
      
      public function dispose() : void
      {
         if(_container != null)
         {
            _container.dispose();
            _container = null;
         }
      }
      
      private function get typeImage() : IStaticBitmapWrapperWindow
      {
         return IStaticBitmapWrapperWindow(_container.findChildByName("type_image"));
      }
   }
}

