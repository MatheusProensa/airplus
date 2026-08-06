package com.sulake.habbo.roomevents.wired_trading.chests
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_trading.chests.subcontrollers.ICoinChestSubController;
   import com.sulake.habbo.session.ISessionDataManager;
   
   public interface IWiredChestController_2
   {
      function addMessageEvent(param1:IMessageEvent) : void;
      
      function removeMessageEvent(param1:IMessageEvent) : void;
      
      function send(param1:IMessageComposer) : void;
      
      function get roomEvents() : HabboUserDefinedRoomEvents;
      
      function get localization() : IHabboLocalizationManager;
      
      function get sessionDataManager() : ISessionDataManager;
      
      function setClosedStatus() : void;
      
      function setOpeningStatus(param1:int) : void;
      
      function setOpenStatus(param1:int, param2:ICoinChestSubController) : void;
      
      function get status() : int;
      
      function get chestWrapperView() : WiredChestWrapperView;
      
      function get activeChestId() : int;
      
      function get requestedChestId() : int;
   }
}

