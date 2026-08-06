package com.sulake.habbo.messenger.habbicons
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.habbicons.assets.HabbiconAssetManager;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class MessengerHabbiconPickerTileView implements IComponentInterfaceQueue
   {
      private static const SLOT_FILLED_COLOR:uint = 4294967295;
      
      private static const SLOT_EMPTY_COLOR:uint = 4292730333;
      
      private static const SLOT_FILLED_HOVER_COLOR:uint = 4293848814;
      
      private var _window:IWindowController_1;
      
      private var _entry:MessengerHabbiconPickerEntry;
      
      private var UnknownVarFromMessengerHabbiconPickerTileView_Function_1:Function;
      
      private var UnknownVarFromMessengerHabbiconPickerTileView_Function_2:Function;
      
      private var UnknownVarFromMessengerHabbiconPickerTileView_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromMessengerHabbiconPickerTileView_Boolean_1:Boolean;
      
      private var _disposed:Boolean;
      
      public function MessengerHabbiconPickerTileView(param1:IWindowController_1, param2:MessengerHabbiconPickerEntry, param3:Function, param4:IHabboWindowManagerComponent, param5:Function, param6:Function)
      {
         super();
         _window = param1.clone() as IWindowController_1;
         _entry = param2;
         UnknownVarFromMessengerHabbiconPickerTileView_Function_1 = param3;
         UnknownVarFromMessengerHabbiconPickerTileView_Function_2 = param6;
         addWheelListener(_window);
         addWheelListener(background);
         addWheelListener(bitmap);
         var _loc7_:* = param2 != null;
         background.color = _loc7_ ? 4294967295 : 4292730333;
         background.blend = _loc7_ ? 0.85 : 0.4;
         _window.mouseThreshold = _loc7_ ? 0 : 10;
         IRegionWindow(_window).toolTipCaption = _loc7_ ? param2.name : "";
         if(param2 == null)
         {
            bitmap.visible = false;
            return;
         }
         if(_loc7_)
         {
            _window.addEventListener("WME_CLICK",onClicked);
            _window.addEventListener("WME_OVER",onHovered);
            _window.addEventListener("WME_OUT",onOut);
         }
         refreshBitmap();
         addUnseenCounter(param4,param5);
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function clearUnseenCounterForHabbicon(param1:int) : void
      {
         if(_entry != null && _entry.habbiconId == param1)
         {
            removeUnseenCounter();
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(UnknownVarFromMessengerHabbiconPickerTileView_Boolean_1)
         {
            HabbiconAssetManager.removeEventListener("habbicon_assets_loaded",onAssetsLoaded);
            UnknownVarFromMessengerHabbiconPickerTileView_Boolean_1 = false;
         }
         if(_window != null)
         {
            if(_window.parent != null)
            {
               IWindowController_1(_window.parent).removeChild(_window);
            }
            removeWheelListener(_window);
            removeWheelListener(background);
            removeWheelListener(bitmap);
            _window.removeEventListener("WME_CLICK",onClicked);
            _window.removeEventListener("WME_OVER",onHovered);
            _window.removeEventListener("WME_OUT",onOut);
            removeUnseenCounter();
            clearBitmap();
            _window.dispose();
            _window = null;
         }
         _entry = null;
         UnknownVarFromMessengerHabbiconPickerTileView_Function_1 = null;
         UnknownVarFromMessengerHabbiconPickerTileView_Function_2 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function refreshBitmap() : void
      {
         var _loc1_:BitmapData = null;
         clearBitmap();
         _loc1_ = HabbiconAssetManager.getPreviewBitmap(_entry.habbiconId,false);
         if(_loc1_ == null)
         {
            bitmap.bitmap = new BitmapData(40,40,true,0);
            bitmap.visible = true;
            bitmap.invalidate();
            if(!UnknownVarFromMessengerHabbiconPickerTileView_Boolean_1)
            {
               HabbiconAssetManager.addEventListener("habbicon_assets_loaded",onAssetsLoaded);
               UnknownVarFromMessengerHabbiconPickerTileView_Boolean_1 = true;
            }
            return;
         }
         bitmap.bitmap = _loc1_.clone();
         bitmap.visible = true;
         bitmap.invalidate();
      }
      
      private function addUnseenCounter(param1:IHabboWindowManagerComponent, param2:Function) : void
      {
         var _loc3_:ITextWindow = null;
         if(param1 == null || param2 == null || !param2(_entry.habbiconId))
         {
            return;
         }
         UnknownVarFromMessengerHabbiconPickerTileView_IWindowController_1_1 = param1.createUnseenItemCounter();
         _loc3_ = UnknownVarFromMessengerHabbiconPickerTileView_IWindowController_1_1.findChildByName("count") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.caption = "1";
         }
         UnknownVarFromMessengerHabbiconPickerTileView_IWindowController_1_1.x = _window.width - UnknownVarFromMessengerHabbiconPickerTileView_IWindowController_1_1.width - 1;
         UnknownVarFromMessengerHabbiconPickerTileView_IWindowController_1_1.y = 1;
         _window.addChild(UnknownVarFromMessengerHabbiconPickerTileView_IWindowController_1_1);
      }
      
      private function removeUnseenCounter() : void
      {
         if(UnknownVarFromMessengerHabbiconPickerTileView_IWindowController_1_1 == null)
         {
            return;
         }
         if(UnknownVarFromMessengerHabbiconPickerTileView_IWindowController_1_1.parent != null)
         {
            IWindowController_1(UnknownVarFromMessengerHabbiconPickerTileView_IWindowController_1_1.parent).removeChild(UnknownVarFromMessengerHabbiconPickerTileView_IWindowController_1_1);
         }
         UnknownVarFromMessengerHabbiconPickerTileView_IWindowController_1_1.dispose();
         UnknownVarFromMessengerHabbiconPickerTileView_IWindowController_1_1 = null;
      }
      
      private function onAssetsLoaded(param1:Event) : void
      {
         HabbiconAssetManager.removeEventListener("habbicon_assets_loaded",onAssetsLoaded);
         UnknownVarFromMessengerHabbiconPickerTileView_Boolean_1 = false;
         if(!_disposed)
         {
            refreshBitmap();
         }
      }
      
      private function onClicked(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromMessengerHabbiconPickerTileView_Function_1 != null)
         {
            UnknownVarFromMessengerHabbiconPickerTileView_Function_1(_entry.habbiconId,param1.shiftKey);
         }
      }
      
      private function onHovered(param1:WindowMouseEvent) : void
      {
         background.color = 4293848814;
      }
      
      private function onOut(param1:WindowMouseEvent) : void
      {
         background.color = 4294967295;
      }
      
      private function addWheelListener(param1:IWindowModel) : void
      {
         if(param1 == null || UnknownVarFromMessengerHabbiconPickerTileView_Function_2 == null)
         {
            return;
         }
         param1.addEventListener("WME_WHEEL",UnknownVarFromMessengerHabbiconPickerTileView_Function_2);
         param1.addEventListener("WME_WHEEL_HORIZONTAL",UnknownVarFromMessengerHabbiconPickerTileView_Function_2);
      }
      
      private function removeWheelListener(param1:IWindowModel) : void
      {
         if(param1 == null || UnknownVarFromMessengerHabbiconPickerTileView_Function_2 == null)
         {
            return;
         }
         param1.removeEventListener("WME_WHEEL",UnknownVarFromMessengerHabbiconPickerTileView_Function_2);
         param1.removeEventListener("WME_WHEEL_HORIZONTAL",UnknownVarFromMessengerHabbiconPickerTileView_Function_2);
      }
      
      private function clearBitmap() : void
      {
         if(bitmap != null && bitmap.bitmap != null)
         {
            bitmap.bitmap.dispose();
            bitmap.bitmap = null;
         }
      }
      
      private function get bitmap() : IBitmapWrapperController
      {
         return _window.findChildByName("habbicon_icon") as IBitmapWrapperController;
      }
      
      private function get background() : UnknownICoreWindowComponents6
      {
         return _window.findChildByName("habbicon_item_bg") as UnknownICoreWindowComponents6;
      }
   }
}

