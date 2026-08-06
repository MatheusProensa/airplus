package com.sulake.habbo.friendbar.landingview.widget.elements
{
   public class UnknownHabboFriendbarLandingviewWidgetElements4 extends AbstractButtonElementHandler
   {
      public function UnknownHabboFriendbarLandingviewWidgetElements4()
      {
         super();
      }
      
      override protected function onClick() : void
      {
         landingView.questEngine.reenableRoomCompetitionWindow();
         landingView.navigator.goToHomeRoom();
         landingView.tracking.trackGoogle("landingView","click_gotohomeroom");
      }
   }
}

