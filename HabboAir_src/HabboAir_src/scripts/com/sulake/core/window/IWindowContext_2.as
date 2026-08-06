package com.sulake.core.window
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.utils.INotify;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils2;
   import flash.geom.Rectangle;
   
   public interface IWindowContext_2
   {
      function create(param1:String, param2:uint, param3:uint, param4:uint, param5:Rectangle, param6:Function = null, param7:String = "", param8:uint = 0, param9:Array = null, param10:IWindowModel = null, param11:Array = null, param12:String = "") : IWindowModel;
      
      function destroy(param1:IWindowModel) : void;
      
      function buildFromXML(param1:XML, param2:uint = 1, param3:Map = null) : IWindowModel;
      
      function windowToXMLString(param1:IWindowModel) : String;
      
      function getDesktop(param1:uint) : IDesktopController;
      
      function notify(param1:String, param2:String, param3:Function, param4:uint = 0) : INotify;
      
      function confirm(param1:String, param2:String, param3:uint, param4:Function) : UnknownICoreWindowUtils2;
      
      function confirmWithModal(param1:String, param2:String, param3:uint, param4:Function) : UnknownICoreWindowUtils2;
      
      function findWindowByName(param1:String) : IWindowModel;
      
      function findWindowByTag(param1:String) : IWindowModel;
      
      function groupWindowsWithTag(param1:String, param2:Array, param3:int = 0) : uint;
   }
}

