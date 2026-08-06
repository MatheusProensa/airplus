package com.sulake.core.window.services
{
   import com.sulake.core.window.IWindowModel;
   
   public interface IToolTipAgentService
   {
      function dispose() : void;
      
      function begin(param1:IWindowModel, param2:uint = 0) : IWindowModel;
      
      function end(param1:IWindowModel) : IWindowModel;
      
      function updateCaption(param1:IWindowModel) : void;
   }
}

