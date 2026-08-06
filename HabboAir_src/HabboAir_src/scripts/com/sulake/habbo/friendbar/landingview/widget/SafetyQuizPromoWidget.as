package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   
   public class SafetyQuizPromoWidget implements ILandingViewWidget
   {
      private var _landingView:HabboLandingView;
      
      private var _container:IWindowController_1;
      
      private var _disposed:Boolean;
      
      public function SafetyQuizPromoWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
      }
      
      public function initialize() : void
      {
         _container = IWindowController_1(_landingView.getXmlWindow("safety_quiz_promo"));
         _container.procedure = widgetProcedure;
         refresh();
      }
      
      private function widgetProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK" && param2.name == "safety_quiz_button")
         {
            _landingView.habboHelp.showSafetyBooklet();
         }
      }
      
      public function refresh() : void
      {
         if(_container != null && !_container.disposed)
         {
            IAvatarImageWidget(IWidgetWindowController(_container.findChildByName("avatar")).widget).figure = _landingView.sessionDataManager.figure;
         }
      }
      
      public function get container() : IWindowModel
      {
         return _container;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_container != null)
            {
               _container.dispose();
               _container = null;
            }
            _landingView = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

