package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.IElementHandler;
   import com.sulake.habbo.friendbar.landingview.interfaces.elements.ILayoutNameProvider;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public class AbstractButtonElementHandler implements IElementHandler, IComponentInterfaceQueue, ILayoutNameProvider
   {
      private var _landingView:HabboLandingView;
      
      private var _window:IWindowModel;
      
      public function AbstractButtonElementHandler()
      {
         super();
      }
      
      public function get layoutName() : String
      {
         return "element_button";
      }
      
      public function dispose() : void
      {
         _landingView = null;
         _window = null;
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      public function initialize(param1:HabboLandingView, param2:IWindowModel, param3:Array, param4:GenericWidget) : void
      {
         _landingView = param1;
         _window = param2;
         var _loc5_:String = param3[1];
         param2.procedure = onButton;
         param2.caption = "${" + _loc5_ + "}";
      }
      
      private function onButton(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            onClick();
         }
      }
      
      protected function onClick() : void
      {
      }
      
      public function refresh() : void
      {
      }
      
      public function get landingView() : HabboLandingView
      {
         return _landingView;
      }
      
      public function get window() : IWindowModel
      {
         return _window;
      }
   }
}

