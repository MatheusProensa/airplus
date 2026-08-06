package com.sulake.habbo.quest.rewardtrack.view.header
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.quest.rewardtrack.RewardTrackController;
   import com.sulake.habbo.quest.rewardtrack.data.RewardTrack;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   
   public class RewardTrackHeaderView implements IComponentInterfaceQueue
   {
      private var UnknownVarFromRewardTrackHeaderView_RewardTrackController_1:RewardTrackController;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromRewardTrackHeaderView_RewardTrack_1:RewardTrack;
      
      private var _disposed:Boolean;
      
      public function RewardTrackHeaderView(param1:RewardTrackController, param2:IWindowController_1, param3:RewardTrack)
      {
         super();
         UnknownVarFromRewardTrackHeaderView_RewardTrackController_1 = param1;
         _window = param2;
         UnknownVarFromRewardTrackHeaderView_RewardTrack_1 = param3;
         initialize();
      }
      
      private function initialize() : void
      {
         refreshOwnAvatar();
         trackTitleText.text = localize("reward_track." + UnknownVarFromRewardTrackHeaderView_RewardTrack_1.id + ".name");
         trackDescText.text = localize("reward_track." + UnknownVarFromRewardTrackHeaderView_RewardTrack_1.id + ".desc");
         trackInstructionsText.text = localize("reward_track." + UnknownVarFromRewardTrackHeaderView_RewardTrack_1.id + ".info");
         initializeStaffActions();
         refresh();
      }
      
      private function initializeStaffActions() : void
      {
         trackTitleRegion.interactiveCursorDisabled = !UnknownVarFromRewardTrackHeaderView_RewardTrackController_1.canCopyDebugIds;
         if(UnknownVarFromRewardTrackHeaderView_RewardTrackController_1.canCopyDebugIds)
         {
            trackTitleRegion.addEventListener("WME_CLICK",onTrackTitleClicked);
         }
      }
      
      public function refresh() : void
      {
         refreshPoints();
         refreshRewardsCollected();
      }
      
      public function refreshOwnAvatar() : void
      {
         ownAvatar.figure = UnknownVarFromRewardTrackHeaderView_RewardTrackController_1.questEngine.sessionDataManager.figure;
      }
      
      public function refreshPoints() : void
      {
         pointsTotalCollectedText.text = String(UnknownVarFromRewardTrackHeaderView_RewardTrack_1.points);
      }
      
      public function refreshRewardsCollected() : void
      {
         rewardsCollectedText.text = UnknownVarFromRewardTrackHeaderView_RewardTrackController_1.localizationManager.getLocalizationWithParams("reward_track.profile.rewards_collected","","progress",UnknownVarFromRewardTrackHeaderView_RewardTrack_1.claimedPrizeCount,"total",UnknownVarFromRewardTrackHeaderView_RewardTrack_1.totalPrizeCount);
      }
      
      private function localize(param1:String) : String
      {
         return UnknownVarFromRewardTrackHeaderView_RewardTrackController_1.localizationManager.getLocalization(param1,param1);
      }
      
      private function onTrackTitleClicked(param1:WindowMouseEvent) : void
      {
         UnknownVarFromRewardTrackHeaderView_RewardTrackController_1.copyTrackId(UnknownVarFromRewardTrackHeaderView_RewardTrack_1.id);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         trackTitleRegion.removeEventListener("WME_CLICK",onTrackTitleClicked);
         UnknownVarFromRewardTrackHeaderView_RewardTrackController_1 = null;
         _window = null;
         UnknownVarFromRewardTrackHeaderView_RewardTrack_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get ownAvatar() : IAvatarImageWidget
      {
         return ownAvatarWidget.widget as IAvatarImageWidget;
      }
      
      private function get ownAvatarWidget() : IWidgetWindowController
      {
         return _window.findChildByName("own_avatar") as IWidgetWindowController;
      }
      
      private function get trackTitleText() : ITextWindow
      {
         return _window.findChildByName("track_title_txt") as ITextWindow;
      }
      
      private function get trackTitleRegion() : IRegionWindow
      {
         return _window.findChildByName("track_title_region") as IRegionWindow;
      }
      
      private function get trackDescText() : ITextWindow
      {
         return _window.findChildByName("track_desc_txt") as ITextWindow;
      }
      
      private function get trackInstructionsText() : ITextWindow
      {
         return _window.findChildByName("track_instructions_txt") as ITextWindow;
      }
      
      private function get pointsTotalCollectedText() : ITextWindow
      {
         return _window.findChildByName("points_total_collected_txt") as ITextWindow;
      }
      
      private function get rewardsCollectedText() : ITextWindow
      {
         return _window.findChildByName("rewards_collected_txt") as ITextWindow;
      }
   }
}

