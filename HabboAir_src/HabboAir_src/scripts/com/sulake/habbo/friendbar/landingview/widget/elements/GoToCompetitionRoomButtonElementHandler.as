package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.communication.messages.outgoing.competition.ForwardToRandomCompetitionRoomMessageComposer;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public class GoToCompetitionRoomButtonElementHandler extends AbstractButtonElementHandler
   {
      private var _goalCode:String;
      
      public function GoToCompetitionRoomButtonElementHandler()
      {
         super();
      }
      
      override public function initialize(param1:HabboLandingView, param2:IWindowModel, param3:Array, param4:GenericWidget) : void
      {
         super.initialize(param1,param2,param3,param4);
         _goalCode = param3[2];
      }
      
      override protected function onClick() : void
      {
         landingView.questEngine.reenableRoomCompetitionWindow();
         landingView.send(new ForwardToRandomCompetitionRoomMessageComposer(_goalCode));
         landingView.tracking.trackGoogle("landingView","click_gotocompetitionroom");
      }
   }
}

