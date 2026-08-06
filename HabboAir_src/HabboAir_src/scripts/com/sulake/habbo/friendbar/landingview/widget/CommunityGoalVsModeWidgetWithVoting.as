package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.landingview.votes.CommunityVoteReceivedEvent;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   
   public class CommunityGoalVsModeWidgetWithVoting extends CommunityGoalVsModeWidget
   {
      private var UnknownVarFromCommunityGoalVsModeWidgetWithVoting_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromCommunityGoalVsModeWidgetWithVoting_IWindowModel_2:IWindowModel;
      
      private var UnknownVarFromCommunityGoalVsModeWidgetWithVoting_String_1:String;
      
      public function CommunityGoalVsModeWidgetWithVoting(param1:HabboLandingView)
      {
         super(param1,true);
      }
      
      override public function initialize() : void
      {
         super.initialize();
         UnknownVarFromCommunityGoalVsModeWidgetWithVoting_IWindowModel_1 = _container.findChildByName("community_vote_one_button");
         UnknownVarFromCommunityGoalVsModeWidgetWithVoting_IWindowModel_1.procedure = onVoteOptionOneClick;
         UnknownVarFromCommunityGoalVsModeWidgetWithVoting_IWindowModel_2 = _container.findChildByName("community_vote_two_button");
         UnknownVarFromCommunityGoalVsModeWidgetWithVoting_IWindowModel_2.procedure = onVoteOptionTwoClick;
         _landingView.communicationManager.addHabboConnectionMessageEvent(new CommunityVoteReceivedEvent(onInfo));
      }
      
      override public function refresh() : void
      {
         super.refresh();
         if(communityProgress != null)
         {
            if(UnknownVarFromCommunityGoalVsModeWidgetWithVoting_IWindowModel_1 != null)
            {
               UnknownVarFromCommunityGoalVsModeWidgetWithVoting_IWindowModel_1.visible = communityProgress.personalContributionScore == 0;
            }
            if(UnknownVarFromCommunityGoalVsModeWidgetWithVoting_IWindowModel_2 != null)
            {
               UnknownVarFromCommunityGoalVsModeWidgetWithVoting_IWindowModel_2.visible = communityProgress.personalContributionScore == 0;
            }
         }
      }
      
      private function onVoteOptionOneClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            hideVoteButtons();
            _landingView.communityGoalVote(1);
            _landingView.tracking.trackGoogle("landingView","click_voteoption_one");
         }
      }
      
      private function onVoteOptionTwoClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            hideVoteButtons();
            _landingView.communityGoalVote(2);
            _landingView.tracking.trackGoogle("landingView","click_voteoption_two");
         }
      }
      
      private function onInfo(param1:CommunityVoteReceivedEvent) : void
      {
         if(param1.getParser().acknowledged)
         {
            hideVoteButtons();
         }
      }
      
      private function hideVoteButtons() : void
      {
         UnknownVarFromCommunityGoalVsModeWidgetWithVoting_IWindowModel_1.visible = false;
         UnknownVarFromCommunityGoalVsModeWidgetWithVoting_IWindowModel_2.visible = false;
      }
   }
}

