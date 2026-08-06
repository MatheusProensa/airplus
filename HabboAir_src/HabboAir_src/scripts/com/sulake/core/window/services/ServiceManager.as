package com.sulake.core.window.services
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowContext_3;
   import flash.display.DisplayObject;
   
   public class ServiceManager implements IInternalWindowServices, IComponentInterfaceQueue
   {
      private var UnknownVarFromServiceManager_Uint_1:uint;
      
      private var UnknownVarFromServiceManager_DisplayObject_1:DisplayObject;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromServiceManager_IWindowContext_3_1:IWindowContext_3;
      
      private var _mouseDraggingService:IMouseDraggingService;
      
      private var _mouseScalingService:IMouseScalingService;
      
      private var _mouseListenerService:IMouseListenerService;
      
      private var _focusManagerService:IFocusManager;
      
      private var _toolTipAgentService:IToolTipAgentService;
      
      private var _gestureAgentService:IGestureAgentService;
      
      public function ServiceManager(param1:IWindowContext_3, param2:DisplayObject)
      {
         super();
         UnknownVarFromServiceManager_Uint_1 = 0;
         UnknownVarFromServiceManager_DisplayObject_1 = param2;
         UnknownVarFromServiceManager_IWindowContext_3_1 = param1;
         _mouseDraggingService = new WindowMouseDragger(param2);
         _mouseScalingService = new WindowMouseScaler(param2);
         _mouseListenerService = new WindowMouseListener(param2);
         _focusManagerService = new FocusManager(param2);
         _toolTipAgentService = new WindowToolTipAgent(param2);
         _gestureAgentService = new GestureAgentService();
      }
      
      public function dispose() : void
      {
         if(_mouseDraggingService != null)
         {
            _mouseDraggingService.dispose();
            _mouseDraggingService = null;
         }
         if(_mouseScalingService != null)
         {
            _mouseScalingService.dispose();
            _mouseScalingService = null;
         }
         if(_mouseListenerService != null)
         {
            _mouseListenerService.dispose();
            _mouseListenerService = null;
         }
         if(_focusManagerService != null)
         {
            _focusManagerService.dispose();
            _focusManagerService = null;
         }
         if(_toolTipAgentService != null)
         {
            _toolTipAgentService.dispose();
            _toolTipAgentService = null;
         }
         if(_gestureAgentService != null)
         {
            _gestureAgentService.dispose();
            _gestureAgentService = null;
         }
         UnknownVarFromServiceManager_DisplayObject_1 = null;
         UnknownVarFromServiceManager_IWindowContext_3_1 = null;
         _disposed = true;
      }
      
      public function getMouseDraggingService() : IMouseDraggingService
      {
         return _mouseDraggingService;
      }
      
      public function getMouseScalingService() : IMouseScalingService
      {
         return _mouseScalingService;
      }
      
      public function getMouseListenerService() : IMouseListenerService
      {
         return _mouseListenerService;
      }
      
      public function getFocusManagerService() : IFocusManager
      {
         return _focusManagerService;
      }
      
      public function getToolTipAgentService() : IToolTipAgentService
      {
         return _toolTipAgentService;
      }
      
      public function getGestureAgentService() : IGestureAgentService
      {
         return _gestureAgentService;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

