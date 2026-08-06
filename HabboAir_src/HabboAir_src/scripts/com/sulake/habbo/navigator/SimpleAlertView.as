package com.sulake.habbo.navigator
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class SimpleAlertView extends AlertView
   {
      private var _text:String;
      
      public function SimpleAlertView(param1:IHabboNavigator_2, param2:String, param3:String)
      {
         super(param1,"nav_simple_alert",param2);
         _text = param3;
      }
      
      override internal function setupAlertWindow(param1:IFrameController) : void
      {
         var _loc3_:IWindowController_1 = param1.content;
         ITextWindow(_loc3_.findChildByName("body_text")).text = _text;
         var _loc2_:IWindowModel = _loc3_.findChildByName("ok");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onOk);
         }
         param1.tags.push("SimpleAlertView");
      }
      
      private function onOk(param1:WindowMouseEvent) : void
      {
         dispose();
      }
   }
}

