package com.sulake.habbo.friendbar.landingview.widget.elements
{
   public class UnknownHabboFriendbarLandingviewWidgetElements2 extends AbstractButtonElementHandler
   {
      public function UnknownHabboFriendbarLandingviewWidgetElements2()
      {
         super();
      }
      
      override protected function onClick() : void
      {
         landingView.catalog.openCreditsHabblet();
         landingView.tracking.trackGoogle("landingView","click_credithabblet");
      }
   }
}

