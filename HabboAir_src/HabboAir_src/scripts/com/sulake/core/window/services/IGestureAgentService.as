package com.sulake.core.window.services
{
   import com.sulake.core.window.IWindowModel;
   
   public interface IGestureAgentService
   {
      function dispose() : void;
      
      function begin(param1:IWindowModel, param2:Function, param3:uint, param4:int, param5:int) : IWindowModel;
      
      function end(param1:IWindowModel) : IWindowModel;
   }
}

