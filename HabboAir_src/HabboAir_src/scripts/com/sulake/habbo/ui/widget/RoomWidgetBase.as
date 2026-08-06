package com.sulake.habbo.ui.widget
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.ui.IRoomDesktop;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.events.IEventDispatcher;
   
   public class RoomWidgetBase implements IRoomWidget
   {
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromRoomWidgetBase_EventDispatcherWrapper_1:EventDispatcherWrapper;
      
      private var _messageListener:IRoomWidgetMessageListener;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      protected var _assets:IAssetLibraryCollection;
      
      protected var _localizations:IHabboLocalizationManager;
      
      protected var _widgetHandler:IRoomWidgetHandler;
      
      private var _reusable:Boolean;
      
      private var _widgetType:String;
      
      public function RoomWidgetBase(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection = null, param4:IHabboLocalizationManager = null)
      {
         super();
         _widgetHandler = param1;
         _windowManager = param2;
         _assets = param3;
         _localizations = param4;
      }
      
      public function get state() : int
      {
         return 0;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function initialize(param1:int = 0) : void
      {
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         _messageListener = null;
         _windowManager = null;
         if(UnknownVarFromRoomWidgetBase_EventDispatcherWrapper_1 != null && !UnknownVarFromRoomWidgetBase_EventDispatcherWrapper_1.disposed)
         {
            unregisterUpdateEvents(UnknownVarFromRoomWidgetBase_EventDispatcherWrapper_1);
         }
         if(_widgetHandler)
         {
            _widgetHandler.dispose();
            _widgetHandler = null;
         }
         UnknownVarFromRoomWidgetBase_EventDispatcherWrapper_1 = null;
         _assets = null;
         _localizations = null;
         _reusable = false;
         _disposed = true;
      }
      
      public function set messageListener(param1:IRoomWidgetMessageListener) : void
      {
         _messageListener = param1;
      }
      
      public function get messageListener() : IRoomWidgetMessageListener
      {
         return _messageListener;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get assets() : IAssetLibraryCollection
      {
         return _assets;
      }
      
      public function get localizations() : IHabboLocalizationManager
      {
         return _localizations;
      }
      
      public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 is EventDispatcherWrapper)
         {
            UnknownVarFromRoomWidgetBase_EventDispatcherWrapper_1 = param1 as EventDispatcherWrapper;
         }
      }
      
      public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
      }
      
      public function get mainWindow() : IWindowModel
      {
         return null;
      }
      
      public function get widgetHandler() : IRoomWidgetHandler
      {
         return _widgetHandler;
      }
      
      public function release() : void
      {
         _widgetHandler.container = null;
         _messageListener = null;
         if(UnknownVarFromRoomWidgetBase_EventDispatcherWrapper_1 != null)
         {
            unregisterUpdateEvents(UnknownVarFromRoomWidgetBase_EventDispatcherWrapper_1);
            UnknownVarFromRoomWidgetBase_EventDispatcherWrapper_1 = null;
         }
      }
      
      public function reuse(param1:IRoomDesktop) : void
      {
      }
      
      public function set reusable(param1:Boolean) : void
      {
         _reusable = param1;
      }
      
      public function get reusable() : Boolean
      {
         return _reusable;
      }
      
      public function set widgetType(param1:String) : void
      {
         _widgetType = param1;
      }
      
      public function get widgetType() : String
      {
         return _widgetType;
      }
   }
}

