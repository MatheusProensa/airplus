package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents2;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class CheckboxOptionPreset extends WiredUIPreset
   {
      private var _container:IWindowController_1;
      
      private var UnknownVarFromCheckboxOptionPreset_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromCheckboxOptionPreset_IItemListWindow_2:IItemListWindow;
      
      private var _checkbox:UnknownICoreWindowComponents2;
      
      private var UnknownVarFromCheckboxOptionPreset_TextPreset_1:TextPreset;
      
      private var UnknownVarFromCheckboxOptionPreset_StaticBitmapAssetWrapperPreset_1:StaticBitmapAssetWrapperPreset;
      
      private var _extra1:WiredUIPreset;
      
      private var _extra2:WiredUIPreset;
      
      private var _last:Boolean;
      
      public function CheckboxOptionPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:CheckboxOptionParam, param5:Boolean = false)
      {
         super(param1,param2,param3);
         _container = param2.createLayout("growing_container_view") as IWindowController_1;
         UnknownVarFromCheckboxOptionPreset_IItemListWindow_1 = param2.createLayout("vertical_list_view") as IItemListWindow;
         UnknownVarFromCheckboxOptionPreset_IItemListWindow_2 = param2.createLayout("horizontal_list_view") as IItemListWindow;
         _last = param5;
         _checkbox = param3.createCheckboxView();
         _checkbox.id = param4.id;
         if(param4.text != null && param4.text != "")
         {
            UnknownVarFromCheckboxOptionPreset_TextPreset_1 = param2.createText(param4.text,new TextParam(param4.extra1 != null ? 0 : 1));
         }
         if(param4.iconAssetName != null && param4.iconAssetName != "")
         {
            UnknownVarFromCheckboxOptionPreset_StaticBitmapAssetWrapperPreset_1 = param2.createBitmapWrapperPreset(resolveAssetFullName(param4.iconAssetName));
         }
         if(param3.checkboxYOffset > 0)
         {
            if(UnknownVarFromCheckboxOptionPreset_TextPreset_1 != null)
            {
               UnknownVarFromCheckboxOptionPreset_TextPreset_1.window.y = param3.checkboxYOffset;
            }
            if(UnknownVarFromCheckboxOptionPreset_StaticBitmapAssetWrapperPreset_1 != null)
            {
               UnknownVarFromCheckboxOptionPreset_StaticBitmapAssetWrapperPreset_1.window.y = param3.checkboxYOffset;
            }
         }
         else if(param3.checkboxYOffset < 0)
         {
            _checkbox.y = -param3.checkboxYOffset;
         }
         UnknownVarFromCheckboxOptionPreset_IItemListWindow_2.addListItem(_checkbox);
         if(UnknownVarFromCheckboxOptionPreset_StaticBitmapAssetWrapperPreset_1 != null)
         {
            UnknownVarFromCheckboxOptionPreset_IItemListWindow_2.addListItem(UnknownVarFromCheckboxOptionPreset_StaticBitmapAssetWrapperPreset_1.window);
         }
         if(UnknownVarFromCheckboxOptionPreset_TextPreset_1 != null)
         {
            UnknownVarFromCheckboxOptionPreset_IItemListWindow_2.addListItem(UnknownVarFromCheckboxOptionPreset_TextPreset_1.window);
         }
         UnknownVarFromCheckboxOptionPreset_IItemListWindow_2.spacing = param3.checkboxSpacing;
         if(param4.extra1 != null)
         {
            _extra1 = param4.extra1;
            UnknownVarFromCheckboxOptionPreset_IItemListWindow_2.addListItem(_extra1.window);
         }
         UnknownVarFromCheckboxOptionPreset_IItemListWindow_1.addListItem(UnknownVarFromCheckboxOptionPreset_IItemListWindow_2);
         UnknownVarFromCheckboxOptionPreset_IItemListWindow_1.spacing = param3.optionExtraUnderSpacing;
         if(param4.extra2 != null)
         {
            _extra2 = param4.extra2;
            UnknownVarFromCheckboxOptionPreset_IItemListWindow_1.addListItem(_extra2.window);
            _extra2.window.x = param3.optionExtraUnderLeftMargin;
         }
         if(_extra1 != null || _extra2 != null)
         {
            _checkbox.addEventListener("WE_SELECTED",onSelect);
            _checkbox.addEventListener("WE_UNSELECTED",onUnSelect);
            onUnSelect(null);
         }
         _container.addChild(UnknownVarFromCheckboxOptionPreset_IItemListWindow_1);
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
      
      override public function set disabled(param1:Boolean) : void
      {
         super.disabled = param1;
         if(!param1 && !selected)
         {
            onUnSelect(null);
         }
      }
      
      public function set selected(param1:Boolean) : void
      {
         Util.select(_checkbox,param1);
      }
      
      public function get selected() : Boolean
      {
         return _checkbox.isSelected;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         var _loc3_:int = 0;
         super.resizeToWidth(param1);
         _container.width = param1;
         UnknownVarFromCheckboxOptionPreset_IItemListWindow_1.width = param1;
         UnknownVarFromCheckboxOptionPreset_IItemListWindow_2.width = param1;
         if(UnknownVarFromCheckboxOptionPreset_TextPreset_1 != null && !UnknownVarFromCheckboxOptionPreset_TextPreset_1.canStretch && _extra1 != null)
         {
            throw new Error("Illegal UI combination: could not determine width of text");
         }
         if(UnknownVarFromCheckboxOptionPreset_TextPreset_1 != null && _extra1 == null)
         {
            UnknownVarFromCheckboxOptionPreset_TextPreset_1.resizeToWidth(param1 - UnknownVarFromCheckboxOptionPreset_TextPreset_1.window.x);
         }
         else if(UnknownVarFromCheckboxOptionPreset_TextPreset_1 != null)
         {
            UnknownVarFromCheckboxOptionPreset_TextPreset_1.resizeToWidth(UnknownVarFromCheckboxOptionPreset_TextPreset_1.width);
         }
         if(_extra1 != null)
         {
            _extra1.resizeToWidth(param1 - _extra1.window.x);
         }
         if(_extra2 != null)
         {
            _extra2.resizeToWidth(param1 - _extra2.window.x);
         }
         var _loc2_:int = _checkbox.height + _checkbox.y;
         if(UnknownVarFromCheckboxOptionPreset_TextPreset_1 != null)
         {
            _loc2_ = Math.max(_loc2_,UnknownVarFromCheckboxOptionPreset_TextPreset_1.window.height + UnknownVarFromCheckboxOptionPreset_TextPreset_1.window.y);
         }
         if(UnknownVarFromCheckboxOptionPreset_StaticBitmapAssetWrapperPreset_1 != null)
         {
            _loc2_ = Math.max(_loc2_,UnknownVarFromCheckboxOptionPreset_StaticBitmapAssetWrapperPreset_1.window.height + UnknownVarFromCheckboxOptionPreset_StaticBitmapAssetWrapperPreset_1.window.y);
         }
         if(_extra1 != null && _extra1.window.height > _loc2_)
         {
            _loc3_ = (_extra1.window.height - _loc2_) / 2;
            _checkbox.y = _loc3_;
            if(UnknownVarFromCheckboxOptionPreset_TextPreset_1 != null)
            {
               UnknownVarFromCheckboxOptionPreset_TextPreset_1.window.y = _loc3_ + UnknownVarFromWiredUIPreset_WiredStyle_1.checkboxYOffset;
            }
            if(UnknownVarFromCheckboxOptionPreset_StaticBitmapAssetWrapperPreset_1 != null)
            {
               UnknownVarFromCheckboxOptionPreset_StaticBitmapAssetWrapperPreset_1.window.y = _loc3_ + UnknownVarFromWiredUIPreset_WiredStyle_1.checkboxYOffset;
            }
            _loc2_ = _extra1.window.height;
         }
         UnknownVarFromCheckboxOptionPreset_IItemListWindow_2.height = _loc2_;
         if(!_last)
         {
            _container.height = Math.max(UnknownVarFromCheckboxOptionPreset_IItemListWindow_1.height + UnknownVarFromWiredUIPreset_WiredStyle_1.minimumOptionSpacing,UnknownVarFromWiredUIPreset_WiredStyle_1.minimumOptionHeight);
         }
         else
         {
            _container.height = UnknownVarFromCheckboxOptionPreset_IItemListWindow_1.height;
         }
      }
      
      override public function get window() : IWindowModel
      {
         return _container;
      }
      
      public function get checkbox() : UnknownICoreWindowComponents2
      {
         return _checkbox;
      }
      
      override protected function get childPresets() : Array
      {
         var _loc1_:Array = [];
         if(UnknownVarFromCheckboxOptionPreset_TextPreset_1 != null)
         {
            _loc1_.push(UnknownVarFromCheckboxOptionPreset_TextPreset_1);
         }
         if(UnknownVarFromCheckboxOptionPreset_StaticBitmapAssetWrapperPreset_1 != null)
         {
            _loc1_.push(UnknownVarFromCheckboxOptionPreset_StaticBitmapAssetWrapperPreset_1);
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
         UnknownVarFromCheckboxOptionPreset_IItemListWindow_1 = null;
         UnknownVarFromCheckboxOptionPreset_IItemListWindow_2 = null;
         UnknownVarFromCheckboxOptionPreset_TextPreset_1 = null;
         UnknownVarFromCheckboxOptionPreset_StaticBitmapAssetWrapperPreset_1 = null;
         _checkbox = null;
         _extra1 = null;
         _extra2 = null;
      }
   }
}

