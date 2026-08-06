package com.sulake.core.window.utils
{
   import com.sulake.core.window.IInputEventTracker;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.graphics.IWindowRenderer;
   
   public class EventProcessorState
   {
      public var renderer:IWindowRenderer;
      
      public var desktop:IDesktopController;
      
      public var UnknownVarFromEventProcessorState_IWindowModel_1:IWindowModel;
      
      public var lastClickTarget:IWindowModel;
      
      public var lastMouseDownTarget:IWindowModel;
      
      public var UnknownVarFromEventProcessorState_IWindowModel_2:IWindowModel;
      
      public var eventTrackers:Vector.<IInputEventTracker>;
      
      public function EventProcessorState(param1:IWindowRenderer, param2:IDesktopController, param3:IWindowModel, param4:IWindowModel, param5:IWindowModel, param6:IWindowModel, param7:Vector.<IInputEventTracker>)
      {
         super();
         this.renderer = param1;
         this.desktop = param2;
         this.UnknownVarFromEventProcessorState_IWindowModel_1 = param3;
         this.lastClickTarget = param4;
         this.lastMouseDownTarget = param5;
         this.UnknownVarFromEventProcessorState_IWindowModel_2 = param6;
         this.eventTrackers = param7;
      }
   }
}

