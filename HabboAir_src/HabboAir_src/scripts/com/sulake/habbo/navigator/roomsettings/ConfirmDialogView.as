package com.sulake.habbo.navigator.roomsettings
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.navigator.IHabboNavigator_2;
   import com.sulake.habbo.navigator.Util;
   import flash.geom.Rectangle;
   
   public class ConfirmDialogView implements IComponentInterfaceQueue
   {
      private var _window:IFrameController;
      
      private var UnknownVarFromConfirmDialogView_Function_1:Function;
      
      public function ConfirmDialogView(param1:IHabboNavigator_2, param2:Function, param3:String, param4:String)
      {
         super();
         this._window = IFrameController(param1.getXmlWindow("ros_confirm"));
         this.UnknownVarFromConfirmDialogView_Function_1 = param2;
         _window.findChildByTag("close").addEventListener("WME_CLICK",onCancel);
         _window.findChildByName("ok").addEventListener("WME_CLICK",onOk);
         _window.caption = param3;
         _window.findChildByName("message").caption = param4;
         var _loc5_:Rectangle = Util.getLocationRelativeTo(_window.desktop,_window.width,_window.height);
         _window.x = _loc5_.x;
         _window.y = _loc5_.y;
         _window.visible = true;
         _window.activate();
      }
      
      private function onCancel(param1:WindowMouseEvent) : void
      {
         dispose();
      }
      
      private function onOk(param1:WindowMouseEvent) : void
      {
         UnknownVarFromConfirmDialogView_Function_1.apply();
         dispose();
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.destroy();
            _window = null;
         }
         UnknownVarFromConfirmDialogView_Function_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _window == null;
      }
   }
}

