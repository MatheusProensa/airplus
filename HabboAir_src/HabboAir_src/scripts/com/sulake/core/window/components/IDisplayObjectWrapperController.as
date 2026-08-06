package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowModel;
   import flash.display.DisplayObject;
   
   public interface IDisplayObjectWrapperController extends IWindowModel
   {
      function setDisplayObject(param1:DisplayObject) : void;
      
      function getDisplayObject() : DisplayObject;
   }
}

