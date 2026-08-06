package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.graphics.GraphicContext;
   import com.sulake.core.window.graphics.IGraphicContext;
   import com.sulake.core.window.iterators.ContainerIterator;
   import com.sulake.core.window.utils.IIterator;
   import flash.geom.Rectangle;
   
   public class ContainerController extends WindowController implements IWindowController_1
   {
      public function ContainerController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindowModel, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         UnknownVarFromWindowController_Boolean_1 = _background || testParamFlag(1) || !testParamFlag(16);
      }
      
      public function get iterator() : IIterator
      {
         return new ContainerIterator(this);
      }
      
      override public function getGraphicContext(param1:Boolean) : IGraphicContext
      {
         if(param1 && !UnknownVarFromWindowController_IGraphicContext_1)
         {
            UnknownVarFromWindowController_IGraphicContext_1 = new GraphicContext("GC {" + _name + "}",testParamFlag(16) ? 4 : 1,rectangle);
            UnknownVarFromWindowController_IGraphicContext_1.visible = _visible;
         }
         return UnknownVarFromWindowController_IGraphicContext_1;
      }
   }
}

