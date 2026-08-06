package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.components.ILabelWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class UpdatingTimeStampWidget implements IUpdatingTimeStampWidget
   {
      public static const TYPE:String = "updating_timestamp";
      
      private static const UPDATE_TIMER:Timer = new Timer(60000);
      
      UPDATE_TIMER.start();
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromUpdatingTimeStampWidget_IWidgetWindowController_1:IWidgetWindowController;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var UnknownVarFromUpdatingTimeStampWidget_ILabelWindow_1:ILabelWindow;
      
      private var _timeStamp:Number;
      
      public function UpdatingTimeStampWidget(param1:IWidgetWindowController, param2:HabboWindowManagerComponent)
      {
         super();
         UnknownVarFromUpdatingTimeStampWidget_IWidgetWindowController_1 = param1;
         _windowManager = param2;
         UnknownVarFromUpdatingTimeStampWidget_ILabelWindow_1 = _windowManager.create("",12,100,16,new Rectangle()) as ILabelWindow;
         UnknownVarFromUpdatingTimeStampWidget_ILabelWindow_1.textColor = 5592405;
         UnknownVarFromUpdatingTimeStampWidget_IWidgetWindowController_1.rootWindow = UnknownVarFromUpdatingTimeStampWidget_ILabelWindow_1;
         UPDATE_TIMER.addEventListener("timer",onTimerTick);
         reset();
      }
      
      public function reset() : void
      {
         _timeStamp = new Date().getTime();
         onTimerTick();
      }
      
      public function get properties() : Array
      {
         return [];
      }
      
      public function set properties(param1:Array) : void
      {
      }
      
      public function set align(param1:String) : void
      {
         UnknownVarFromUpdatingTimeStampWidget_ILabelWindow_1.defaultTextFormat.align = param1;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            UPDATE_TIMER.removeEventListener("timer",onTimerTick);
            if(UnknownVarFromUpdatingTimeStampWidget_ILabelWindow_1 != null)
            {
               UnknownVarFromUpdatingTimeStampWidget_ILabelWindow_1.dispose();
               UnknownVarFromUpdatingTimeStampWidget_ILabelWindow_1 = null;
            }
            if(UnknownVarFromUpdatingTimeStampWidget_IWidgetWindowController_1 != null)
            {
               UnknownVarFromUpdatingTimeStampWidget_IWidgetWindowController_1.rootWindow = null;
               UnknownVarFromUpdatingTimeStampWidget_IWidgetWindowController_1 = null;
            }
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      public function get timeStamp() : Number
      {
         return _timeStamp;
      }
      
      public function set timeStamp(param1:Number) : void
      {
         _timeStamp = param1;
         onTimerTick();
      }
      
      private function onTimerTick(param1:TimerEvent = null) : void
      {
         if(_disposed || !UnknownVarFromUpdatingTimeStampWidget_ILabelWindow_1 || !_windowManager || !_windowManager.localization)
         {
            return;
         }
         UnknownVarFromUpdatingTimeStampWidget_ILabelWindow_1.caption = FriendlyTime.getFriendlyTime(_windowManager.localization,(new Date().getTime() - Math.abs(_timeStamp)) / 1000,".ago",1);
      }
   }
}

