package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class RadioButtonPreset extends WiredUIPreset
   {
      public static var OPTION_PREFIX:String = "option_";
      
      private var _container:IWindowController_1;
      
      private var UnknownVarFromRadioButtonPreset_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromRadioButtonPreset_IItemListWindow_2:IItemListWindow;
      
      private var UnknownVarFromRadioButtonPreset_TextPreset_1:TextPreset;
      
      private var UnknownVarFromRadioButtonPreset_StaticBitmapAssetWrapperPreset_1:StaticBitmapAssetWrapperPreset;
      
      private var _radioButton:IRadioButtonWindow;
      
      private var _layoutRowIndex:int = -1;
      
      private var _layoutColumnIndex:int = -1;
      
      private var _spanRemainingWidth:Boolean = false;
      
      private var _extra1:WiredUIPreset;
      
      private var _extra2:WiredUIPreset;
      
      private var _last:Boolean;
      
      public function RadioButtonPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:RadioButtonParam, param5:Boolean = false)
      {
         super(param1,param2,param3);
         _container = param2.createLayout("container_view") as IWindowController_1;
         UnknownVarFromRadioButtonPreset_IItemListWindow_1 = param2.createLayout("vertical_list_view") as IItemListWindow;
         UnknownVarFromRadioButtonPreset_IItemListWindow_2 = param2.createLayout("horizontal_list_view") as IItemListWindow;
         _last = param5;
         _radioButton = param3.createRadioButtonView();
         if(param4.text != null && param4.text != "")
         {
            UnknownVarFromRadioButtonPreset_TextPreset_1 = param2.createText(param4.text,new TextParam(param4.extra1 != null ? 0 : 1));
         }
         if(param4.iconAssetName != null && param4.iconAssetName != "")
         {
            UnknownVarFromRadioButtonPreset_StaticBitmapAssetWrapperPreset_1 = param2.createBitmapWrapperPreset(resolveAssetFullName(param4.iconAssetName));
         }
         if(param3.radioButtonYOffset > 0)
         {
            if(UnknownVarFromRadioButtonPreset_TextPreset_1 != null)
            {
               UnknownVarFromRadioButtonPreset_TextPreset_1.window.y = param3.radioButtonYOffset;
            }
            if(UnknownVarFromRadioButtonPreset_StaticBitmapAssetWrapperPreset_1 != null)
            {
               UnknownVarFromRadioButtonPreset_StaticBitmapAssetWrapperPreset_1.window.y = param3.radioButtonYOffset;
            }
         }
         else if(param3.radioButtonYOffset < 0)
         {
            _radioButton.y = -param3.radioButtonYOffset;
         }
         _radioButton.name = OPTION_PREFIX + param4.id;
         _radioButton.id = param4.id;
         UnknownVarFromRadioButtonPreset_IItemListWindow_2.addListItem(_radioButton);
         if(UnknownVarFromRadioButtonPreset_StaticBitmapAssetWrapperPreset_1 != null)
         {
            UnknownVarFromRadioButtonPreset_IItemListWindow_2.addListItem(UnknownVarFromRadioButtonPreset_StaticBitmapAssetWrapperPreset_1.window);
         }
         if(UnknownVarFromRadioButtonPreset_TextPreset_1 != null)
         {
            UnknownVarFromRadioButtonPreset_IItemListWindow_2.addListItem(UnknownVarFromRadioButtonPreset_TextPreset_1.window);
         }
         UnknownVarFromRadioButtonPreset_IItemListWindow_2.spacing = param3.radioButtonSpacing;
         if(param4.extra1 != null)
         {
            _extra1 = param4.extra1;
            UnknownVarFromRadioButtonPreset_IItemListWindow_2.addListItem(_extra1.window);
         }
         UnknownVarFromRadioButtonPreset_IItemListWindow_1.addListItem(UnknownVarFromRadioButtonPreset_IItemListWindow_2);
         UnknownVarFromRadioButtonPreset_IItemListWindow_1.spacing = param3.optionExtraUnderSpacing;
         if(param4.extra2 != null)
         {
            _extra2 = param4.extra2;
            UnknownVarFromRadioButtonPreset_IItemListWindow_1.addListItem(_extra2.window);
            _extra2.window.x = param3.optionExtraUnderLeftMargin;
         }
         if(_extra1 != null || _extra2 != null)
         {
            _radioButton.addEventListener("WE_SELECTED",onSelect);
            _radioButton.addEventListener("WE_UNSELECTED",onUnSelect);
            onUnSelect(null);
         }
         _container.addChild(UnknownVarFromRadioButtonPreset_IItemListWindow_1);
      }
      
      public function set text(param1:String) : void
      {
         if(UnknownVarFromRadioButtonPreset_TextPreset_1 != null)
         {
            UnknownVarFromRadioButtonPreset_TextPreset_1.text = param1;
         }
      }
      
      private function onSelect(param1:WindowEvent) : void
      {
         if(_extra1 != null)
         {
            _extra1.disabled = false;
         }
         if(_extra2 != null)
         {
            _extra2.disabled = false;
         }
      }
      
      private function onUnSelect(param1:WindowEvent) : void
      {
         if(_extra1 != null)
         {
            _extra1.disabled = true;
         }
         if(_extra2 != null)
         {
            _extra2.disabled = true;
         }
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         var _loc3_:int = 0;
         super.resizeToWidth(param1);
         UnknownVarFromRadioButtonPreset_IItemListWindow_2.width = param1;
         _container.width = param1;
         UnknownVarFromRadioButtonPreset_IItemListWindow_1.width = param1;
         if(UnknownVarFromRadioButtonPreset_TextPreset_1 != null && !UnknownVarFromRadioButtonPreset_TextPreset_1.canStretch && _extra1 != null)
         {
            throw new Error("Illegal UI combination: could not determine width of text");
         }
         if(UnknownVarFromRadioButtonPreset_TextPreset_1 != null && _extra1 == null)
         {
            UnknownVarFromRadioButtonPreset_TextPreset_1.resizeToWidth(param1 - UnknownVarFromRadioButtonPreset_TextPreset_1.window.x);
         }
         else if(UnknownVarFromRadioButtonPreset_TextPreset_1 != null)
         {
            UnknownVarFromRadioButtonPreset_TextPreset_1.resizeToWidth(UnknownVarFromRadioButtonPreset_TextPreset_1.width);
         }
         if(_extra1 != null)
         {
            _extra1.resizeToWidth(param1 - _extra1.window.x);
         }
         if(_extra2 != null)
         {
            _extra2.resizeToWidth(param1 - _extra2.window.x);
         }
         var _loc2_:int = _radioButton.height + _radioButton.y;
         if(UnknownVarFromRadioButtonPreset_TextPreset_1 != null)
         {
            _loc2_ = Math.max(_loc2_,UnknownVarFromRadioButtonPreset_TextPreset_1.window.height + UnknownVarFromRadioButtonPreset_TextPreset_1.window.y);
         }
         if(UnknownVarFromRadioButtonPreset_StaticBitmapAssetWrapperPreset_1 != null)
         {
            _loc2_ = Math.max(_loc2_,UnknownVarFromRadioButtonPreset_StaticBitmapAssetWrapperPreset_1.window.height + UnknownVarFromRadioButtonPreset_StaticBitmapAssetWrapperPreset_1.window.y);
         }
         if(_extra1 != null && _extra1.window.height > _loc2_)
         {
            _loc3_ = (_extra1.window.height - _loc2_) / 2;
            _radioButton.y = _loc3_;
            if(UnknownVarFromRadioButtonPreset_TextPreset_1 != null)
            {
               UnknownVarFromRadioButtonPreset_TextPreset_1.window.y = _loc3_ + UnknownVarFromWiredUIPreset_WiredStyle_1.radioButtonYOffset;
            }
            if(UnknownVarFromRadioButtonPreset_StaticBitmapAssetWrapperPreset_1 != null)
            {
               UnknownVarFromRadioButtonPreset_StaticBitmapAssetWrapperPreset_1.window.y = _loc3_ + UnknownVarFromWiredUIPreset_WiredStyle_1.radioButtonYOffset;
            }
            _loc2_ = _extra1.window.height;
         }
         UnknownVarFromRadioButtonPreset_IItemListWindow_2.height = _loc2_;
         if(!_last)
         {
            _container.height = Math.max(UnknownVarFromRadioButtonPreset_IItemListWindow_1.height + UnknownVarFromWiredUIPreset_WiredStyle_1.minimumOptionSpacing,UnknownVarFromWiredUIPreset_WiredStyle_1.minimumOptionHeight);
         }
         else
         {
            _container.height = UnknownVarFromRadioButtonPreset_IItemListWindow_1.height;
         }
      }
      
      public function get radioButton() : IRadioButtonWindow
      {
         return _radioButton;
      }
      
      public function set layoutRowIndex(param1:int) : void
      {
         _layoutRowIndex = param1;
      }
      
      public function get layoutRowIndex() : int
      {
         return _layoutRowIndex;
      }
      
      public function set layoutColumnIndex(param1:int) : void
      {
         _layoutColumnIndex = param1;
      }
      
      public function get layoutColumnIndex() : int
      {
         return _layoutColumnIndex;
      }
      
      public function set spanRemainingWidth(param1:Boolean) : void
      {
         _spanRemainingWidth = param1;
      }
      
      public function get spanRemainingWidth() : Boolean
      {
         return _spanRemainingWidth;
      }
      
      override public function get window() : IWindowModel
      {
         return _container;
      }
      
      override protected function get childPresets() : Array
      {
         var _loc1_:Array = [];
         if(UnknownVarFromRadioButtonPreset_TextPreset_1 != null)
         {
            _loc1_.push(UnknownVarFromRadioButtonPreset_TextPreset_1);
         }
         if(UnknownVarFromRadioButtonPreset_StaticBitmapAssetWrapperPreset_1 != null)
         {
            _loc1_.push(UnknownVarFromRadioButtonPreset_StaticBitmapAssetWrapperPreset_1);
         }
         if(_extra1 != null)
         {
            _loc1_.push(_extra1);
         }
         if(_extra2 != null)
         {
            _loc1_.push(_extra2);
         }
         return _loc1_;
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
         UnknownVarFromRadioButtonPreset_IItemListWindow_1 = null;
         UnknownVarFromRadioButtonPreset_IItemListWindow_2 = null;
         UnknownVarFromRadioButtonPreset_TextPreset_1 = null;
         UnknownVarFromRadioButtonPreset_StaticBitmapAssetWrapperPreset_1 = null;
         _radioButton = null;
         _extra1 = null;
         _extra2 = null;
      }
   }
}

