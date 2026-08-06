package com.sulake.core.window.graphics
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowContext_3;
   import com.sulake.core.window.IWindowModel;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public interface IWindowRenderer extends IComponentInterfaceQueue
   {
      function set debug(param1:Boolean) : void;
      
      function render() : void;
      
      function addToRenderQueue(param1:IWindowModel, param2:Rectangle, param3:uint) : void;
      
      function flushRenderQueue() : void;
      
      function invalidate(param1:IWindowContext_3, param2:Rectangle) : void;
      
      function getDrawBufferForRenderable(param1:IWindowModel) : BitmapData;
      
      function purge(param1:IWindowModel = null, param2:Boolean = true) : void;
   }
}

