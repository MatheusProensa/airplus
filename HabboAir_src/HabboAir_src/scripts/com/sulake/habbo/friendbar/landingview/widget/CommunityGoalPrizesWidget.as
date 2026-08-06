package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalData;
   import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalProgressMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.UserChangeMessageEvent;
   import com.sulake.habbo.friendbar.landingview.*;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
   import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;
   import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   
   public class CommunityGoalPrizesWidget implements ILandingViewWidget, ISettingsAwareWidget
   {
      private var _landingView:HabboLandingView;
      
      private var _container:IWindowController_1;
      
      private var UnknownVarFromCommunityGoalPrizesWidget_CommunityGoalData_1:CommunityGoalData;
      
      private var UnknownVarFromCommunityGoalPrizesWidget_String_1:String;
      
      public function CommunityGoalPrizesWidget(param1:HabboLandingView)
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
         UnknownVarFromCommunityGoalPrizesWidget_CommunityGoalData_1 = null;
      }
      
      public function initialize() : void
      {
         _container = IWindowController_1(_landingView.getXmlWindow("achievement_competition_prizes"));
         _landingView.communicationManager.addHabboConnectionMessageEvent(new CommunityGoalProgressMessageEvent(onCommunityGoalProgress));
         _landingView.communicationManager.addHabboConnectionMessageEvent(new UserChangeMessageEvent(onUserChange));
         _landingView.communicationManager.addHabboConnectionMessageEvent(new UserObjectEvent(onUserObject));
      }
      
      public function refresh() : void
      {
         refreshContent();
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      private function refreshContent() : void
      {
         if(UnknownVarFromCommunityGoalPrizesWidget_CommunityGoalData_1 == null)
         {
            _container.visible = false;
            return;
         }
         _container.visible = true;
         setPrizeRankLimits(1);
         setPrizeRankLimits(2);
         setPrizeRankLimits(3);
         _landingView.localizationManager.registerParameter(getCompetitionSpecificKey("yourrankinfo"),"points","" + UnknownVarFromCommunityGoalPrizesWidget_CommunityGoalData_1.personalContributionScore);
         _container.findChildByName("caption_txt").caption = getCompetitionSpecificText("caption");
         _container.findChildByName("info_txt").caption = getCompetitionSpecificText("info");
         _container.findChildByName("reward_name_txt").caption = getCompetitionSpecificText("rewardname");
         _container.findChildByName("reward_info_txt").caption = getCompetitionSpecificText("rewardinfo");
         _container.findChildByName("rank_1_txt").caption = getCompetitionSpecificText("rank1");
         _container.findChildByName("rank_2_txt").caption = getCompetitionSpecificText("rank2");
         _container.findChildByName("rank_3_txt").caption = getCompetitionSpecificText("rank3");
         _container.findChildByName("user_rank_border").visible = !UnknownVarFromCommunityGoalPrizesWidget_CommunityGoalData_1.hasGoalExpired || UnknownVarFromCommunityGoalPrizesWidget_CommunityGoalData_1.personalContributionRank > 0;
         var _loc1_:String = UnknownVarFromCommunityGoalPrizesWidget_CommunityGoalData_1.hasGoalExpired ? "yourfinalrank" : (UnknownVarFromCommunityGoalPrizesWidget_CommunityGoalData_1.personalContributionRank > 0 ? "yourrank" : "youarenotranked");
         _landingView.localizationManager.registerParameter(getKey(_loc1_),"rank","" + UnknownVarFromCommunityGoalPrizesWidget_CommunityGoalData_1.personalContributionRank);
         _container.findChildByName("user_rank_txt").caption = getText(_loc1_);
         _container.findChildByName("user_rank_info_txt").visible = !UnknownVarFromCommunityGoalPrizesWidget_CommunityGoalData_1.hasGoalExpired;
         _container.findChildByName("user_rank_info_txt").caption = getCompetitionSpecificText(UnknownVarFromCommunityGoalPrizesWidget_CommunityGoalData_1.personalContributionRank > 0 ? "yourrankinfo" : "youarenotrankedinfo");
         IStaticBitmapWrapperWindow(_container.findChildByName("reward_image")).assetUri = "${image.library.url}reception/" + UnknownVarFromCommunityGoalPrizesWidget_CommunityGoalData_1.goalCode + "Reward.png";
      }
      
      private function setPrizeRankLimits(param1:int) : void
      {
         var _loc4_:int = 0;
         _loc4_ = 0;
         var _loc5_:int = 1;
         _loc4_ = 0;
         while(_loc4_ < param1)
         {
            _loc5_ += resolveStartRank(param1 - _loc4_);
            _loc4_++;
         }
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < param1)
         {
            _loc3_ += resolveEndRank(param1 - _loc4_);
            _loc4_++;
         }
         var _loc6_:String = _loc5_ == _loc3_ ? getKey("rank") : getKey("ranks");
         var _loc2_:* = _landingView.localizationManager.getLocalizationWithParams(_loc6_,"","start",_loc5_,"end",_loc3_);
         _container.findChildByName("rank_" + param1 + "_info_txt").caption = _loc2_;
      }
      
      private function resolveStartRank(param1:int) : int
      {
         return UnknownVarFromCommunityGoalPrizesWidget_CommunityGoalData_1.rewardUserLimits[param1 - 2];
      }
      
      private function resolveEndRank(param1:int) : int
      {
         return UnknownVarFromCommunityGoalPrizesWidget_CommunityGoalData_1.rewardUserLimits[param1 - 1];
      }
      
      private function onCommunityGoalProgress(param1:CommunityGoalProgressMessageEvent) : void
      {
         UnknownVarFromCommunityGoalPrizesWidget_CommunityGoalData_1 = param1.getParser().data;
         refreshContent();
      }
      
      private function getKey(param1:String) : String
      {
         return "landing.view.competition.prizes." + param1;
      }
      
      private function getCompetitionSpecificKey(param1:String) : String
      {
         var _loc2_:String = getKey(UnknownVarFromCommunityGoalPrizesWidget_CommunityGoalData_1.goalCode + "." + param1);
         Logger.log("foobar: " + _loc2_);
         return _loc2_;
      }
      
      private function getCompetitionSpecificText(param1:String) : String
      {
         var _loc2_:String = getCompetitionSpecificKey(param1);
         return "${" + _loc2_ + "}";
      }
      
      private function getText(param1:String) : String
      {
         var _loc2_:String = getKey(param1);
         return "${" + _loc2_ + "}";
      }
      
      private function onUserObject(param1:UserObjectEvent) : void
      {
         UnknownVarFromCommunityGoalPrizesWidget_String_1 = param1.getParser().figure;
         refreshAvatarInfo();
      }
      
      private function onUserChange(param1:UserChangeMessageEvent) : void
      {
         if(param1 != null && param1.id == -1)
         {
            UnknownVarFromCommunityGoalPrizesWidget_String_1 = param1.figure;
            refreshAvatarInfo();
         }
      }
      
      private function refreshAvatarInfo() : void
      {
         var _loc1_:IWidgetWindowController = IWidgetWindowController(_container.findChildByName("avatar_image"));
         var _loc2_:IAvatarImageWidget = IAvatarImageWidget(_loc1_.widget);
         _loc2_.figure = UnknownVarFromCommunityGoalPrizesWidget_String_1;
      }
      
      public function set settings(param1:CommonWidgetSettings) : void
      {
         WidgetContainerLayout.applyCommonWidgetSettings(_container,param1);
      }
   }
}

