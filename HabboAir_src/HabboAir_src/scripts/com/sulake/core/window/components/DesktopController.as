package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.graphics.GraphicContext;
   import com.sulake.core.window.graphics.IGraphicContext;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class DesktopController extends ActivatorController implements IDesktopController, IDisplayObjectWrapperController
   {
      public function DesktopController(param1:String, param2:WindowContext, param3:Rectangle)
      {
         super(param1,0,0,0,param2,param3,null,defaultProcedure,null,null,0);
      }
      
      public function get mouseX() : int
      {
         return getDisplayObject().stage.mouseX;
      }
      
      public function get mouseY() : int
      {
         return getDisplayObject().stage.mouseY;
      }
      
      override public function set parent(param1:IWindowModel) : void
      {
         throw new Error("Desktop window doesn\'t have parent!");
      }
      
      override public function set procedure(param1:Function) : void
      {
         UnknownVarFromWindowController_Function_1 = param1 ?? defaultProcedure;
      }
      
      override public function get host() : IWindowModel
      {
         return this;
      }
      
      override public function get desktop() : IDesktopController
      {
         return this;
      }
      
      override public function getGraphicContext(param1:Boolean) : IGraphicContext
      {
         if(param1 && !UnknownVarFromWindowController_IGraphicContext_1)
         {
            UnknownVarFromWindowController_IGraphicContext_1 = new GraphicContext("GC {" + _name + "}",256,rectangle);
            GraphicContext(UnknownVarFromWindowController_IGraphicContext_1).mouseEnabled = true;
            GraphicContext(UnknownVarFromWindowController_IGraphicContext_1).doubleClickEnabled = true;
         }
         return UnknownVarFromWindowController_IGraphicContext_1;
      }
      
      public function getActiveWindow() : IWindowModel
      {
         return getActiveChild();
      }
      
      public function setActiveWindow(param1:IWindowModel) : IWindowModel
      {
         return setActiveChild(param1);
      }
      
      public function getDisplayObject() : DisplayObject
      {
         return getGraphicContext(true) as DisplayObject;
      }
      
      public function setDisplayObject(param1:DisplayObject) : void
      {
         getGraphicContext(true).setDisplayObject(param1);
      }
      
      override public function invalidate(param1:Rectangle = null) : void
      {
      }
      
      private function defaultProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
      }
   }
}

