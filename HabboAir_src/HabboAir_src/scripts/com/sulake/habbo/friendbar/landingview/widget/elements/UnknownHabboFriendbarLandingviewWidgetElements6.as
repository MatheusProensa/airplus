package com.sulake.habbo.friendbar.landingview.widget.elements
{
   public class UnknownHabboFriendbarLandingviewWidgetElements6 extends AbstractButtonElementHandler
   {
      public function UnknownHabboFriendbarLandingviewWidgetElements6()
      {
         super();
      }
      
      override protected function onClick() : void
      {
         landingView.catalog.openClubCenter();
         landingView.tracking.trackGoogle("landingView","click_buyVip");
      }
   }
}

