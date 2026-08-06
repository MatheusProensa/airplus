package com.sulake.habbo.catalog.club
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   
   public class VipBenefitsWindow implements IComponentInterfaceQueue
   {
      private var _disposed:Boolean = false;
      
      private var _window:IWindowController_1;
      
      public function VipBenefitsWindow(param1:HabboCatalog)
      {
         super();
         _window = param1.utils.createWindow("vip_benefits") as IWindowController_1;
         _window.findChildByName("header_button_close").addEventListener("WME_CLICK",onClose);
         _window.center();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_window != null)
            {
               _window.dispose();
               _window = null;
            }
         }
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         dispose();
      }
   }
}

