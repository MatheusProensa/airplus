package com.sulake.habbo.configuration
{
   import com.sulake.core.runtime.IComponent_1;
   import flash.events.IEventDispatcher;
   
   public interface IHabboConfigurationManager extends IComponent_1
   {
      function isInitialized() : Boolean;
      
      function updateEnvironmentId(param1:String) : void;
      
      function resetAll() : void;
      
      function initConfigurationDownload() : void;
      
      function get events() : IEventDispatcher;
   }
}

