package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.events.WindowEvent;
   import flash.geom.Rectangle;
   
   public class ActivatorController extends ContainerController
   {
      protected var _activeChild:IWindowModel;
      
      public function ActivatorController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindowModel, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      override public function update(param1:WindowController, param2:WindowEvent) : Boolean
      {
         if(param2.type == "WE_CHILD_ACTIVATED")
         {
            setActiveChild(param1 as IWindowModel);
         }
         else if(param2.type == "WE_PARENT_ACTIVATED")
         {
            return true;
         }
         return super.update(param1,param2);
      }
      
      public function getActiveChild() : IWindowModel
      {
         return _activeChild;
      }
      
      public function setActiveChild(param1:IWindowModel) : IWindowModel
      {
         if(param1.parent != this)
         {
            do
            {
               param1 = param1.parent;
               if(param1 == null)
               {
                  throw new Error("Window passed to activator is not a child!");
               }
            }
            while(param1.parent != this);
            
         }
         var _loc2_:IWindowModel = _activeChild;
         if(_activeChild != param1)
         {
            if(_activeChild != null)
            {
               if(!_activeChild.disposed)
               {
                  _activeChild.deactivate();
               }
            }
            _activeChild = param1;
            if(getChildIndex(param1) != numChildren - 1)
            {
               setChildIndex(param1,numChildren - 1);
            }
         }
         return _loc2_;
      }
   }
}

