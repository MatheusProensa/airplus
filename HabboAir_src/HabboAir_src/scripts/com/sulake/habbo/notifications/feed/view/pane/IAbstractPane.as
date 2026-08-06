package com.sulake.habbo.notifications.feed.view.pane
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   public interface IAbstractPane extends IComponentInterfaceQueue
   {
      function get paneLevel() : int;
      
      function set isVisible(param1:Boolean) : void;
      
      function get isVisible() : Boolean;
   }
}

