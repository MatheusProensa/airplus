package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.InteractiveController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents5;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class AssetButtonPreset extends WiredUIPreset
   {
      private var _container:UnknownICoreWindowComponents5;
      
      private var UnknownVarFromAssetButtonPreset_Function_1:Function;
      
      private var _selected:Boolean = false;
      
      private var UnknownVarFromAssetButtonPreset_Boolean_1:Boolean = false;
      
      private var _pressed:Boolean = false;
      
      public function AssetButtonPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:String, param6:Function)
      {
         super(param1,param2,param3);
         UnknownVarFromAssetButtonPreset_Function_1 = param6;
         _container = param3.createAssetButton();
         staticBitmap.assetUri = resolveAssetFullName(param4);
         _container.toolTipCaption = param5;
         _container.addEventListener("WME_CLICK",onButtonClicked);
         _container.addEventListener("WME_OVER",onOver);
         _container.addEventListener("WME_OUT",onOut);
         _container.addEventListener("WME_OUT",maybeCancelEvent);
         _container.addEventListener("WME_UP",maybeCancelEvent);
         _container.addEventListener("WME_DOWN",onDown);
      }
      
      private function buttonClicked(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromAssetButtonPreset_Function_1 != null)
         {
            UnknownVarFromAssetButtonPreset_Function_1();
         }
      }
      
      public function set assetName(param1:String) : void
      {
         staticBitmap.assetUri = resolveAssetFullName(param1);
      }
      
      override public function get window() : IWindowModel
      {
         return _container;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
      }
      
      private function onOut(param1:WindowMouseEvent) : void
      {
         if(!_container.isEnabled())
         {
            return;
         }
         UnknownVarFromAssetButtonPreset_Boolean_1 = false;
         updateVisuals();
      }
      
      private function onOver(param1:WindowMouseEvent) : void
      {
         if(!_container.isEnabled())
         {
            return;
         }
         UnknownVarFromAssetButtonPreset_Boolean_1 = true;
         updateVisuals();
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromAssetButtonPreset_Function_1 != null)
         {
            UnknownVarFromAssetButtonPreset_Function_1();
         }
      }
      
      private function maybeCancelEvent(param1:WindowMouseEvent) : void
      {
         if(param1.type == "WME_OUT" && _selected)
         {
            param1.preventWindowOperation();
         }
         if(param1.type == "WME_UP")
         {
            _pressed = false;
            if(_selected)
            {
               buttonClicked(null);
               param1.preventWindowOperation();
            }
         }
      }
      
      private function onDown(param1:WindowMouseEvent) : void
      {
         _pressed = false;
      }
      
      private function updateVisuals() : void
      {
         var _loc1_:InteractiveController = InteractiveController(_container);
         if(UnknownVarFromWiredUIPreset_WiredStyle_1.isVolter)
         {
            _loc1_.setStateFlag(16,_pressed);
            _loc1_.setStateFlag(4,UnknownVarFromAssetButtonPreset_Boolean_1 || _selected);
         }
         else
         {
            _loc1_.setStateFlag(16,_selected);
            _loc1_.setStateFlag(4,UnknownVarFromAssetButtonPreset_Boolean_1);
         }
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         updateVisuals();
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return true;
      }
      
      override public function get staticWidth() : int
      {
         return _container.width;
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
         UnknownVarFromAssetButtonPreset_Function_1 = null;
      }
      
      private function get staticBitmap() : IStaticBitmapWrapperWindow
      {
         return _container.findChildByName("asset") as IStaticBitmapWrapperWindow;
      }
   }
}

