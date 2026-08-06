package com.sulake.core.window.utils.tablet
{
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.utils.EventProcessorState;
   import com.sulake.core.window.utils.IEventQueue;
   import com.sulake.core.window.utils.MouseEventProcessor;
   
   public class TabletEventProcessor extends MouseEventProcessor
   {
      private var UnknownVarFromTabletEventProcessor_String_1:String = "";
      
      public function TabletEventProcessor()
      {
         super();
      }
      
      override public function process(param1:EventProcessorState, param2:IEventQueue) : void
      {
         if(param2.length == 0)
         {
            return;
         }
         UnknownVarFromMouseEventProcessor_IDesktopController_1 = param1.desktop;
         UnknownVarFromMouseEventProcessor_WindowController_4 = param1.UnknownVarFromEventProcessorState_IWindowModel_1 as WindowController;
         UnknownVarFromMouseEventProcessor_WindowController_1 = param1.lastClickTarget as WindowController;
         UnknownVarFromMouseEventProcessor_IWindowRenderer_1 = param1.renderer;
         _eventTrackers = param1.eventTrackers;
         param2.begin();
         param2.end();
         param1.desktop = UnknownVarFromMouseEventProcessor_IDesktopController_1;
         param1.UnknownVarFromEventProcessorState_IWindowModel_1 = UnknownVarFromMouseEventProcessor_WindowController_4;
         param1.lastClickTarget = UnknownVarFromMouseEventProcessor_WindowController_1;
         param1.renderer = UnknownVarFromMouseEventProcessor_IWindowRenderer_1;
         param1.eventTrackers = _eventTrackers;
      }
   }
}

