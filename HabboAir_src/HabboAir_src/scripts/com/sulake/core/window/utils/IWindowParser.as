package com.sulake.core.window.utils
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowModel;
   
   public interface IWindowParser extends IComponentInterfaceQueue
   {
      function parseAndConstruct(param1:XML, param2:IWindowModel, param3:Map) : IWindowModel;
      
      function windowToXMLString(param1:IWindowModel) : String;
   }
}

