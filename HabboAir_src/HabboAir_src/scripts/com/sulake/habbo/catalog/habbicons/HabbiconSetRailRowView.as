package com.sulake.habbo.catalog.habbicons
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.habbicons.assets.HabbiconAssetManager;
   import flash.display.BitmapData;
   
   public class HabbiconSetRailRowView implements IComponentInterfaceQueue
   {
      private static const BACKGROUND_IDLE:uint = 16313302;
      
      private static const BACKGROUND_HOVER:uint = 16773830;
      
      private static const BACKGROUND_ACTIVE:uint = 15781766;
      
      private static const BORDER_IDLE:uint = 15920341;
      
      private static const BORDER_ACTIVE:uint = 16777215;
      
      private var _window:IWindowController_1;
      
      private var _set:HabbiconSetModel;
      
      private var _progressView:HabbiconProgressBarView;
      
      private var UnknownVarFromHabbiconSetRailRowView_Function_1:Function;
      
      private var _active:Boolean;
      
      private var UnknownVarFromHabbiconSetRailRowView_Boolean_1:Boolean;
      
      private var _disposed:Boolean;
      
      public function HabbiconSetRailRowView(param1:IWindowController_1, param2:Function)
      {
         super();
         _window = param1.clone() as IWindowController_1;
         UnknownVarFromHabbiconSetRailRowView_Function_1 = param2;
         _progressView = new HabbiconProgressBarView(setRowProgressBar);
         _window.addEventListener("WME_CLICK",onClicked);
         _window.addEventListener("WME_OVER",onOver);
         _window.addEventListener("WME_OUT",onOut);
      }
      
      public function initialize(param1:HabbiconSetModel) : void
      {
         _set = param1;
         _window.visible = true;
         setRowTitle.text = param1.title;
         updateIcon();
         refreshProgress(false);
         _active = false;
         UnknownVarFromHabbiconSetRailRowView_Boolean_1 = false;
         updateLook();
      }
      
      public function setActive(param1:Boolean) : void
      {
         _active = param1;
         updateLook();
      }
      
      public function refreshProgress(param1:Boolean) : void
      {
         _progressView.setRatio(_set.progressRatio,param1);
         setRowProgressText.text = _set.completed + " / " + _set.total;
      }
      
      public function update(param1:uint) : void
      {
         _progressView.update(param1);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(_window.parent != null)
         {
            (_window.parent as IWindowController_1).removeChild(_window);
         }
         _window.removeEventListener("WME_CLICK",onClicked);
         _window.removeEventListener("WME_OVER",onOver);
         _window.removeEventListener("WME_OUT",onOut);
         clearIcon();
         if(_progressView != null)
         {
            _progressView.dispose();
            _progressView = null;
         }
         _window.dispose();
         _window = null;
         _set = null;
         UnknownVarFromHabbiconSetRailRowView_Function_1 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function get set() : HabbiconSetModel
      {
         return _set;
      }
      
      private function updateIcon() : void
      {
         var _loc3_:HabbiconEntryModel = null;
         var _loc1_:BitmapData = null;
         var _loc2_:IBitmapWrapperController = setIcon;
         if(_loc2_ == null)
         {
            return;
         }
         clearIcon();
         if(_set.habbicons != null && _set.habbicons.length > 0)
         {
            _loc3_ = _set.habbicons[0];
            _loc1_ = HabbiconAssetManager.getPreviewBitmap(_loc3_.habbiconId,false);
         }
         if(_loc1_ != null)
         {
            _loc2_.disposesBitmap = true;
            _loc2_.bitmap = _loc1_.clone();
            _loc2_.visible = true;
            _loc2_.invalidate();
         }
         else
         {
            _loc2_.visible = false;
         }
      }
      
      private function clearIcon() : void
      {
         var _loc1_:IBitmapWrapperController = setIcon;
         if(_loc1_ != null && _loc1_.bitmap != null)
         {
            _loc1_.bitmap.dispose();
            _loc1_.bitmap = null;
            _loc1_.invalidate();
         }
      }
      
      private function updateLook() : void
      {
         var _loc1_:uint = _active ? 15781766 : (uint(UnknownVarFromHabbiconSetRailRowView_Boolean_1 ? 16773830 : 16313302));
         var _loc2_:uint = _active || UnknownVarFromHabbiconSetRailRowView_Boolean_1 ? 16777215 : 15920341;
         setRowBackground.color = 4278190080 | _loc1_;
         _window.color = 4278190080 | _loc2_;
      }
      
      private function onClicked(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromHabbiconSetRailRowView_Function_1 != null && _set != null)
         {
            UnknownVarFromHabbiconSetRailRowView_Function_1(_set);
         }
      }
      
      private function onOver(param1:WindowMouseEvent) : void
      {
         UnknownVarFromHabbiconSetRailRowView_Boolean_1 = true;
         updateLook();
      }
      
      private function onOut(param1:WindowMouseEvent) : void
      {
         UnknownVarFromHabbiconSetRailRowView_Boolean_1 = false;
         updateLook();
      }
      
      private function get setRowTitle() : ITextWindow
      {
         return _window.findChildByName("set_row_title") as ITextWindow;
      }
      
      private function get setRowProgressBar() : IWindowController_1
      {
         return _window.findChildByName("set_row_progress_bar") as IWindowController_1;
      }
      
      private function get setRowProgressText() : ITextWindow
      {
         return _window.findChildByName("set_row_progress_text") as ITextWindow;
      }
      
      private function get setRowBackground() : IWindowModel
      {
         return _window.findChildByName("set_row_background");
      }
      
      private function get setIcon() : IBitmapWrapperController
      {
         return _window.findChildByName("set_icon") as IBitmapWrapperController;
      }
   }
}

