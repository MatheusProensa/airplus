package com.sulake.habbo.roomevents.wired_trading.chests.subcontrollers
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_trading.chests.IWiredChestController_2;
   import com.sulake.habbo.roomevents.wired_trading.chests.WiredChestWrapperView;
   
   public class AbstractChestSubController implements ICoinChestSubController
   {
      private var _disposed:Boolean;
      
      private var _parentController:IWiredChestController_2;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      public function AbstractChestSubController(param1:IWiredChestController_2)
      {
         super();
         _parentController = param1;
         _messageEvents = new Vector.<IMessageEvent>();
      }
      
      public function get parentController() : IWiredChestController_2
      {
         return _parentController;
      }
      
      public function get roomEvents() : HabboUserDefinedRoomEvents
      {
         return _parentController.roomEvents;
      }
      
      public function localize(param1:String) : String
      {
         return localization.getLocalization(param1,param1);
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _parentController.localization;
      }
      
      protected function addMessageEvent(param1:IMessageEvent) : void
      {
         _messageEvents.push(param1);
         _parentController.addMessageEvent(param1);
      }
      
      private function removeMessageEvents() : void
      {
         for each(var _loc1_ in _messageEvents)
         {
            _parentController.removeMessageEvent(_loc1_);
            _loc1_.dispose();
         }
         _messageEvents = null;
      }
      
      public function get canEdit() : Boolean
      {
         return wrapperView.canEdit;
      }
      
      public function get canRead() : Boolean
      {
         return wrapperView.canRead;
      }
      
      public function get canWithdraw() : Boolean
      {
         return wrapperView.canWithdraw;
      }
      
      public function get wrapperView() : WiredChestWrapperView
      {
         return _parentController.chestWrapperView;
      }
      
      public function get viewingChestId() : int
      {
         return parentController.chestWrapperView.viewingChestId;
      }
      
      public function get type() : int
      {
         return -1;
      }
      
      public function get view() : IWindowController_1
      {
         return null;
      }
      
      public function get title() : String
      {
         return "";
      }
      
      public function get isEmpty() : Boolean
      {
         return true;
      }
      
      public function clear() : void
      {
      }
      
      public function get itemCount() : int
      {
         return 0;
      }
      
      public function updateUI() : void
      {
      }
      
      public function get allowResizing() : Boolean
      {
         return true;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         removeMessageEvents();
         _parentController = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

