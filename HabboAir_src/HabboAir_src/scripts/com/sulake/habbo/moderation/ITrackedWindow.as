package com.sulake.habbo.moderation
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.components.IFrameController;
   
   public interface ITrackedWindow extends IComponentInterfaceQueue
   {
      function getType() : int;
      
      function getId() : String;
      
      function getFrame() : IFrameController;
      
      function show() : void;
   }
}

