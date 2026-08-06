package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   
   public class HabboModerationPromoWidget implements ILandingViewWidget
   {
      private var _landingView:HabboLandingView;
      
      private var _container:IWindowController_1;
      
      public function HabboModerationPromoWidget(param1:HabboLandingView)
      {
         super();
         _landingView = param1;
      }
      
      public function get container() : IWindowModel
      {
         return _container;
      }
      
      public function dispose() : void
      {
         _landingView = null;
         _container = null;
      }
      
      public function initialize() : void
      {
         _container = IWindowController_1(_landingView.getXmlWindow("habbo_moderation_promo"));
         HabboLandingView.positionAfterAndStretch(_container,"title_txt","hdr_line");
      }
      
      public function refresh() : void
      {
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
   }
}

