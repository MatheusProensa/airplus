package com.sulake.habbo.window
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.IResourceManager;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IInputEventTracker;
   import com.sulake.core.window.IWindowContext_2;
   import com.sulake.core.window.IWindowContext_3;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils6;
   import com.sulake.habbo.window.utils.IModalDialog;
   import flash.geom.Rectangle;
   import flash.text.StyleSheet;
   
   public interface IHabboWindowManagerComponent extends IUnknown, IWindowContext_2
   {
      function createWindow(param1:String, param2:String = "", param3:uint = 0, param4:uint = 0, param5:uint = 0, param6:Rectangle = null, param7:Function = null, param8:uint = 0, param9:uint = 1, param10:String = "") : IWindowModel;
      
      function removeWindow(param1:String, param2:uint = 1) : void;
      
      function getWindowByName(param1:String, param2:uint = 1) : IWindowModel;
      
      function getActiveWindow(param1:uint = 1) : IWindowModel;
      
      function toggleFullScreen() : void;
      
      function getWindowContext(param1:uint) : IWindowContext_3;
      
      function alert(param1:String, param2:String, param3:uint, param4:Function) : UnknownICoreWindowUtils1;
      
      function alertWithModal(param1:String, param2:String, param3:uint, param4:Function) : UnknownICoreWindowUtils1;
      
      function alertWithLink(param1:String, param2:String, param3:String, param4:String, param5:uint, param6:Function) : UnknownICoreWindowUtils6;
      
      function registerLocalizationParameter(param1:String, param2:String, param3:String, param4:String = "%") : void;
      
      function addMouseEventTracker(param1:IInputEventTracker) : void;
      
      function removeMouseEventTracker(param1:IInputEventTracker) : void;
      
      function createUnseenItemCounter() : IWindowController_1;
      
      function get resourceManager() : IResourceManager;
      
      function buildModalDialogFromXML(param1:XML) : IModalDialog;
      
      function simpleAlert(param1:String, param2:String, param3:String, param4:String = null, param5:String = null, param6:Map = null, param7:String = null, param8:Function = null, param9:Function = null) : void;
      
      function get assets() : IAssetLibraryCollection;
      
      function registerHintWindow(param1:String, param2:IWindowModel, param3:int = 1) : void;
      
      function unregisterHintWindow(param1:String) : void;
      
      function showHint(param1:String, param2:Rectangle = null) : void;
      
      function hideHint() : void;
      
      function displayFloorPlanEditor() : void;
      
      function openHelpPage(param1:String) : void;
      
      function get habboPagesStyleSheet() : StyleSheet;
      
      function hideMatchingHint(param1:String) : void;
   }
}

