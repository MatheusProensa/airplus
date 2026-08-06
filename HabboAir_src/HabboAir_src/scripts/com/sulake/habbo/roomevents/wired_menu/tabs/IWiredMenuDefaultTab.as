package com.sulake.habbo.roomevents.wired_menu.tabs
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   public interface IWiredMenuDefaultTab extends IComponentInterfaceQueue
   {
      function setTabActive() : void;
      
      function setTabInactive() : void;
      
      function startViewing() : void;
      
      function stopViewing() : void;
      
      function permissionsUpdated() : void;
   }
}

