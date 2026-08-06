package com.sulake.habbo.ui
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.ui.widget.IRoomWidget;
   
   public interface IRoomWidgetFactory extends IComponentInterfaceQueue
   {
      function createWidget(param1:String, param2:IRoomWidgetHandler) : IRoomWidget;
   }
}

