package com.sulake.habbo.ui.widget.furniture.dimmer
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetDimmerStateUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetDimmerUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetDimmerUpdateEventPresetItem;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetDimmerChangeStateMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetDimmerPreviewMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetDimmerSavePresetMessage;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.IEventDispatcher;
   
   public class DimmerFurniWidget extends RoomWidgetBase
   {
      private static const AVAILABLE_COLORS:Array = new Array(7665141,21495,15161822,15353138,15923281,8581961,0);
      
      private static const _minLights:Array = new Array(76,76);
      
      private var UnknownVarFromDimmerFurniWidget_DimmerView_1:DimmerView;
      
      private var _presets:Array;
      
      private var _selectedPresetIndex:int;
      
      private var UnknownVarFromDimmerFurniWidget_Int_1:int;
      
      private var UnknownVarFromDimmerFurniWidget_Int_2:int;
      
      private var _color:uint = 16777215;
      
      private var UnknownVarFromDimmerFurniWidget_Uint_1:uint = 255;
      
      private var UnknownVarFromDimmerFurniWidget_Int_3:int;
      
      private var _isOn:Boolean;
      
      public function DimmerFurniWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection = null, param4:IHabboLocalizationManager = null)
      {
         super(param1,param2,param3,param4);
      }
      
      public function get isOn() : Boolean
      {
         return _isOn;
      }
      
      public function get presets() : Array
      {
         return _presets;
      }
      
      public function get colors() : Array
      {
         return AVAILABLE_COLORS;
      }
      
      public function get minLights() : Array
      {
         return _minLights;
      }
      
      public function get selectedPresetIndex() : int
      {
         return _selectedPresetIndex;
      }
      
      public function set selectedPresetIndex(param1:int) : void
      {
         _selectedPresetIndex = param1;
      }
      
      override public function dispose() : void
      {
         disposeInterface();
         _presets = null;
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWDUE_PRESETS",onPresets);
         param1.addEventListener("RWDUE_HIDE",onHide);
         param1.addEventListener("RWDSUE_DIMMER_STATE",onDimmerState);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWDUE_PRESETS",onPresets);
         param1.removeEventListener("RWDUE_HIDE",onHide);
         param1.removeEventListener("RWDSUE_DIMMER_STATE",onDimmerState);
      }
      
      private function onPresets(param1:RoomWidgetDimmerUpdateEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:RoomWidgetDimmerUpdateEventPresetItem = null;
         var _loc2_:DimmerFurniWidgetPresetItem = null;
         UnknownVarFromDimmerFurniWidget_Int_3 = param1.itemId;
         _isOn = param1.isOn;
         _selectedPresetIndex = param1.selectedPresetId - 1;
         _presets = [];
         _loc3_ = 0;
         while(_loc3_ < param1.presets.length)
         {
            _loc4_ = param1.presets[_loc3_];
            _loc2_ = new DimmerFurniWidgetPresetItem(_loc4_.id,_loc4_.type,_loc4_.color,_loc4_.light);
            _presets.push(_loc2_);
            _loc3_++;
         }
         showInterface();
      }
      
      private function onHide(param1:RoomWidgetDimmerUpdateEvent) : void
      {
         if(UnknownVarFromDimmerFurniWidget_Int_3 == param1.itemId)
         {
            disposeInterface();
         }
      }
      
      private function disposeInterface() : void
      {
         if(UnknownVarFromDimmerFurniWidget_DimmerView_1 != null)
         {
            UnknownVarFromDimmerFurniWidget_DimmerView_1.dispose();
            UnknownVarFromDimmerFurniWidget_DimmerView_1 = null;
         }
      }
      
      private function onDimmerState(param1:RoomWidgetDimmerStateUpdateEvent) : void
      {
         var _loc2_:RoomWidgetDimmerPreviewMessage = null;
         if(param1 == null)
         {
            return;
         }
         if(param1.state > 0)
         {
            UnknownVarFromDimmerFurniWidget_Int_1 = param1.objectId;
         }
         if(UnknownVarFromDimmerFurniWidget_Int_1 == param1.objectId)
         {
            UnknownVarFromDimmerFurniWidget_Int_2 = param1.effectId;
            _color = param1.color;
            UnknownVarFromDimmerFurniWidget_Uint_1 = param1.brightness;
         }
         if(UnknownVarFromDimmerFurniWidget_Int_3 == param1.objectId)
         {
            _isOn = param1.state > 0;
         }
         if(UnknownVarFromDimmerFurniWidget_DimmerView_1 != null)
         {
            UnknownVarFromDimmerFurniWidget_DimmerView_1.update();
         }
         if(!validateBrightness(UnknownVarFromDimmerFurniWidget_Uint_1,UnknownVarFromDimmerFurniWidget_Int_2))
         {
            return;
         }
         _loc2_ = new RoomWidgetDimmerPreviewMessage(_color,UnknownVarFromDimmerFurniWidget_Uint_1,UnknownVarFromDimmerFurniWidget_Int_2 == 2);
         messageListener.processWidgetMessage(_loc2_);
      }
      
      private function showInterface() : void
      {
         if(UnknownVarFromDimmerFurniWidget_DimmerView_1 == null)
         {
            UnknownVarFromDimmerFurniWidget_DimmerView_1 = new DimmerView(this);
         }
         if(UnknownVarFromDimmerFurniWidget_DimmerView_1 != null)
         {
            UnknownVarFromDimmerFurniWidget_DimmerView_1.showInterface();
         }
      }
      
      public function storeCurrentSetting(param1:Boolean) : void
      {
         var _loc6_:RoomWidgetDimmerSavePresetMessage = null;
         if(!_isOn)
         {
            return;
         }
         if(messageListener == null)
         {
            return;
         }
         var _loc7_:int = _selectedPresetIndex + 1;
         if(_presets == null || _loc7_ < 0 || _loc7_ > _presets.length)
         {
            return;
         }
         var _loc5_:int = UnknownVarFromDimmerFurniWidget_DimmerView_1.selectedType;
         var _loc4_:uint = uint(colors[UnknownVarFromDimmerFurniWidget_DimmerView_1.selectedColorIndex]);
         var _loc3_:int = UnknownVarFromDimmerFurniWidget_DimmerView_1.selectedBrightness;
         var _loc2_:DimmerFurniWidgetPresetItem = _presets[_selectedPresetIndex] as DimmerFurniWidgetPresetItem;
         if(_loc2_ != null && _loc2_.type == _loc5_ && _loc2_.color == _loc4_ && _loc2_.light == _loc3_ && !param1)
         {
            return;
         }
         _loc2_.type = _loc5_;
         _loc2_.color = _loc4_;
         _loc2_.light = _loc3_;
         if(!validateBrightness(_loc3_,_loc5_))
         {
            return;
         }
         _loc6_ = new RoomWidgetDimmerSavePresetMessage(_loc7_,_loc5_,_loc4_,_loc3_,param1,UnknownVarFromDimmerFurniWidget_Int_3);
         messageListener.processWidgetMessage(_loc6_);
      }
      
      public function previewCurrentSetting() : void
      {
         var _loc1_:RoomWidgetDimmerPreviewMessage = null;
         if(!_isOn)
         {
            return;
         }
         if(messageListener == null)
         {
            return;
         }
         if(!validateBrightness(UnknownVarFromDimmerFurniWidget_DimmerView_1.selectedBrightness,UnknownVarFromDimmerFurniWidget_DimmerView_1.selectedType))
         {
            return;
         }
         _loc1_ = new RoomWidgetDimmerPreviewMessage(colors[UnknownVarFromDimmerFurniWidget_DimmerView_1.selectedColorIndex],UnknownVarFromDimmerFurniWidget_DimmerView_1.selectedBrightness,UnknownVarFromDimmerFurniWidget_DimmerView_1.selectedType == 2);
         messageListener.processWidgetMessage(_loc1_);
      }
      
      public function changeRoomDimmerState() : void
      {
         var _loc1_:RoomWidgetDimmerChangeStateMessage = null;
         if(messageListener != null)
         {
            _loc1_ = new RoomWidgetDimmerChangeStateMessage(UnknownVarFromDimmerFurniWidget_Int_3);
            messageListener.processWidgetMessage(_loc1_);
         }
      }
      
      public function removePreview() : void
      {
         var _loc1_:RoomWidgetDimmerPreviewMessage = null;
         if(messageListener == null)
         {
            return;
         }
         if(!validateBrightness(UnknownVarFromDimmerFurniWidget_Uint_1,UnknownVarFromDimmerFurniWidget_Int_2))
         {
            return;
         }
         _loc1_ = new RoomWidgetDimmerPreviewMessage(_color,UnknownVarFromDimmerFurniWidget_Uint_1,UnknownVarFromDimmerFurniWidget_Int_2 == 2);
         messageListener.processWidgetMessage(_loc1_);
      }
      
      private function validateBrightness(param1:uint, param2:int) : Boolean
      {
         return true;
      }
   }
}

