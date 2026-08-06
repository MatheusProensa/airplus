package com.sulake.habbo.roomevents.wired_menu.tabs
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   
   public class WiredMenuDefaultTab implements IWiredMenuDefaultTab
   {
      private var _disposed:Boolean = false;
      
      private var _controller:WiredMenuController;
      
      private var _container:IWindowController_1;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var _isActive:Boolean;
      
      private var _isViewing:Boolean;
      
      private var _isLoading:Boolean;
      
      public function WiredMenuDefaultTab(param1:WiredMenuController, param2:IWindowController_1)
      {
         super();
         _controller = param1;
         _container = param2;
         _messageEvents = new Vector.<IMessageEvent>(0);
         var _loc3_:IProfiler_1 = this as IProfiler_1;
         if(_loc3_ != null)
         {
            param1.context.registerUpdateReceiver(_loc3_,1);
         }
      }
      
      public function setTabActive() : void
      {
         _isActive = true;
      }
      
      public function setTabInactive() : void
      {
         _isActive = false;
      }
      
      public function startViewing() : void
      {
         _isViewing = true;
      }
      
      public function stopViewing() : void
      {
         _isViewing = false;
         if(_isLoading)
         {
            _controller.view.loadingContainer.visible = false;
         }
      }
      
      protected function updateLoadingState() : void
      {
         var _loc1_:Boolean = isDataReady();
         if(_isLoading && _loc1_)
         {
            initializeInterface();
         }
         _isLoading = !_loc1_;
         var _loc2_:IWindowController_1 = _controller.view.loadingContainer;
         if(_isViewing && _loc2_.visible != _isLoading)
         {
            _loc2_.visible = _isLoading;
            controller.view.window.caption = controller.localizationManager.getLocalization(_isLoading ? "wiredmenu.title.loading" : "wiredmenu.title");
         }
      }
      
      protected function isDataReady() : Boolean
      {
         return true;
      }
      
      protected function initializeInterface() : void
      {
      }
      
      public function get controller() : WiredMenuController
      {
         return _controller;
      }
      
      protected function get localization() : IHabboLocalizationManager
      {
         return _controller.localizationManager;
      }
      
      protected function loc(param1:String) : String
      {
         return localization.getLocalization(param1,"");
      }
      
      public function get container() : IWindowController_1
      {
         return _container;
      }
      
      public function get isActive() : Boolean
      {
         return _isActive;
      }
      
      public function get isViewing() : Boolean
      {
         return _isViewing;
      }
      
      public function get isLoading() : Boolean
      {
         return _isLoading;
      }
      
      protected function addMessageEvent(param1:IMessageEvent) : void
      {
         _messageEvents.push(param1);
         _controller.addMessageEvent(param1);
      }
      
      private function removeMessageEvents() : void
      {
         if(_messageEvents == null)
         {
            return;
         }
         for each(var _loc1_ in _messageEvents)
         {
            _controller.removeMessageEvent(_loc1_);
            _loc1_.dispose();
         }
         _messageEvents = null;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         removeMessageEvents();
         var _loc1_:IProfiler_1 = this as IProfiler_1;
         if(_loc1_ != null)
         {
            controller.context.removeUpdateReceiver(_loc1_);
         }
         _container = null;
         _controller = null;
         _isActive = false;
         _isViewing = false;
         _isLoading = false;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function permissionsUpdated() : void
      {
      }
   }
}

