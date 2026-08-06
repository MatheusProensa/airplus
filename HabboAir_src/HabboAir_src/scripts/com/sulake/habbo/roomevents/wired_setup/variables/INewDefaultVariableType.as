package com.sulake.habbo.roomevents.wired_setup.variables
{
   import com.sulake.habbo.roomevents.wired_setup.IDefaultElement;
   
   public interface INewDefaultVariableType extends IDefaultElement
   {
      function get initialVariableName() : String;
      
      function variableType() : int;
   }
}

