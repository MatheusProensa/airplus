package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.utils.tablet.ITouchAwareWindow;
   import flash.geom.Rectangle;
   
   public class DropMenuItemController extends ButtonController implements IDropListItemController, ITouchAwareWindow
   {
      public function DropMenuItemController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindowModel, param8:Function, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      public function get menu() : IDropBaseController_1
      {
         var _loc1_:IWindowModel = parent;
         while(_loc1_)
         {
            if(_loc1_ is IDropBaseController_1)
            {
               break;
            }
            _loc1_ = _loc1_.parent;
         }
         return _loc1_ as IDropBaseController_1;
      }
      
      public function get value() : IWindowModel
      {
         return this;
      }
      
      public function set value(param1:IWindowModel) : void
      {
      }
   }
}

