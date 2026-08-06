package com.sulake.core.window
{
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.services.IInternalWindowServices;
   import com.sulake.core.window.utils.IWindowParser;
   import flash.geom.Rectangle;
   
   public interface IWindowContext_3
   {
      function getWindowServices() : IInternalWindowServices;
      
      function getWindowParser() : IWindowParser;
      
      function getDesktopWindow() : IDesktopController;
      
      function registerLocalizationListener(param1:String, param2:IWindowModel) : void;
      
      function removeLocalizationListener(param1:String, param2:IWindowModel) : void;
      
      function findWindowByName(param1:String) : IWindowModel;
      
      function findWindowByTag(param1:String) : IWindowModel;
      
      function groupChildrenWithTag(param1:String, param2:Array, param3:int = 0) : uint;
      
      function create(param1:String, param2:String, param3:uint, param4:uint, param5:uint, param6:Rectangle, param7:Function, param8:IWindowModel, param9:uint, param10:Array = null, param11:String = "", param12:Array = null) : IWindowModel;
      
      function destroy(param1:IWindowModel) : Boolean;
      
      function invalidate(param1:IWindowModel, param2:Rectangle, param3:uint) : void;
      
      function getLastError() : Error;
      
      function getLastErrorCode() : int;
      
      function flushError() : void;
      
      function addMouseEventTracker(param1:IInputEventTracker) : void;
      
      function removeMouseEventTracker(param1:IInputEventTracker) : void;
   }
}

