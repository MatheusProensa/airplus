package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalData;
   import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalProgressMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.quest.GetCommunityGoalProgressMessageComposer;
   import com.sulake.habbo.communication.messages.parser.quest.CommunityGoalProgressMessageParser;
   import com.sulake.habbo.friendbar.landingview.*;
   import com.sulake.habbo.friendbar.landingview.interfaces.ILandingViewWidget;
   import com.sulake.habbo.friendbar.landingview.interfaces.ISettingsAwareWidget;
   import com.sulake.habbo.friendbar.landingview.layout.CommonWidgetSettings;
   import com.sulake.habbo.friendbar.landingview.layout.WidgetContainerLayout;
   
   public class CommunityGoalWidget implements IProfiler_1, ILandingViewWidget, ISettingsAwareWidget
   {
      private static const METER_INITIAL_DELAY_MS:int = 1500;
      
      private static const METER_BUILDUP_TIME_MS:int = 1000;
      
      private static const CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES:Array = [0,8,16,23];
      
      protected var _landingView:HabboLandingView;
      
      protected var _container:IWindowController_1;
      
      private var UnknownVarFromCommunityGoalWidget_IStaticBitmapWrapperWindow_1:IStaticBitmapWrapperWindow;
      
      protected var _communityProgress:CommunityGoalData;
      
      private var UnknownVarFromCommunityGoalWidget_Boolean_1:Boolean = false;
      
      private var UnknownVarFromCommunityGoalWidget_Number_1:Number = 0;
      
      private var _buildupProgress:Number = 0;
      
      private var UnknownVarFromCommunityGoalWidget_Boolean_2:Boolean = false;
      
      private var UnknownVarFromCommunityGoalWidget_Boolean_3:Boolean = true;
      
      private var UnknownVarFromCommunityGoalWidget_Boolean_4:Boolean = false;
      
      public function CommunityGoalWidget(param1:HabboLandingView, param2:Boolean = false)
      {
         super();
         _landingView = param1;
         UnknownVarFromCommunityGoalWidget_Boolean_4 = param2;
      }
      
      public function get container() : IWindowModel
      {
         return _container;
      }
      
      public function dispose() : void
      {
         if(_landingView != null && _landingView.windowManager)
         {
            Component(_landingView.windowManager).removeUpdateReceiver(this);
         }
         _landingView = null;
         _container = null;
         _communityProgress = null;
      }
      
      public function get disposed() : Boolean
      {
         return _landingView == null;
      }
      
      public function initialize() : void
      {
         var _loc1_:IWindowModel = null;
         _landingView.communicationManager.addHabboConnectionMessageEvent(new CommunityGoalProgressMessageEvent(onCommunityGoalProgress));
         _container = IWindowController_1(UnknownVarFromCommunityGoalWidget_Boolean_4 ? _landingView.getXmlWindow("community_goal_voting") : _landingView.getXmlWindow("community_goal"));
         UnknownVarFromCommunityGoalWidget_IStaticBitmapWrapperWindow_1 = IStaticBitmapWrapperWindow(_container.findChildByName("meter_needle"));
         if(!UnknownVarFromCommunityGoalWidget_Boolean_4)
         {
            _loc1_ = _container.findChildByName("community_catalog_button");
            UnknownVarFromCommunityGoalWidget_Boolean_3 = _landingView.getBoolean("landing.view.community.interactive");
            _loc1_.visible = UnknownVarFromCommunityGoalWidget_Boolean_3;
            _loc1_.procedure = onCommunityCatalogButtonClick;
         }
         HabboLandingView.positionAfterAndStretch(_container,"community_title","hdr_line");
      }
      
      private function campaignizeMeterElementAssetUri(param1:IWindowModel) : void
      {
         var _loc3_:IStaticBitmapWrapperWindow = IStaticBitmapWrapperWindow(param1);
         var _loc2_:int = int(_loc3_.assetUri.indexOf(".png"));
         _loc3_.assetUri = _loc3_.assetUri.substr(0,_loc2_) + "_" + _communityProgress.goalCode + ".png";
      }
      
      protected function setCampaignLocalization(param1:String, param2:String) : void
      {
         var _loc3_:IWindowModel = _container.findChildByName(param1);
         if(_loc3_ != null)
         {
            _loc3_.caption = "${" + param2 + "." + _communityProgress.goalCode + "}";
         }
      }
      
      protected function getCurrentNeedleFrame() : int
      {
         if(_communityProgress.communityHighestAchievedLevel >= CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES.length - 1)
         {
            return CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES[CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES.length - 1];
         }
         var _loc1_:int = int(CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES[_communityProgress.communityHighestAchievedLevel]);
         var _loc2_:int = CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES[_communityProgress.communityHighestAchievedLevel + 1] - _loc1_;
         return _loc1_ + Math.floor(_communityProgress.percentCompletionTowardsNextLevel * (_loc2_ + 0.001) / 100);
      }
      
      private function initializeLocalizations() : void
      {
         var _loc1_:int = 0;
         if(_communityProgress != null && _communityProgress.goalCode != null)
         {
            _loc1_ = 0;
            while(_loc1_ < CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES.length)
            {
               campaignizeMeterElementAssetUri(_container.findChildByName("meter_level_" + _loc1_));
               if(_loc1_ > 0)
               {
                  campaignizeMeterElementAssetUri(_container.findChildByName("meter_level_" + _loc1_ + "_icon"));
                  campaignizeMeterElementAssetUri(_container.findChildByName("meter_level_" + _loc1_ + "_icon_locked"));
               }
               _loc1_++;
            }
            setCampaignLocalization("community_title","landing.view.community.headline");
            setCampaignLocalization("goal_caption","landing.view.community.caption");
            setCampaignLocalization("goal_info","landing.view.community.info");
            setCampaignLocalization("community_catalog_button","landing.view.community_catalog_button.text");
            UnknownVarFromCommunityGoalWidget_Boolean_2 = true;
         }
      }
      
      private function refreshContent() : void
      {
         var _loc3_:int = 0;
         if(_communityProgress == null)
         {
            _container.visible = false;
            return;
         }
         if(!UnknownVarFromCommunityGoalWidget_Boolean_2)
         {
            initializeLocalizations();
         }
         _loc3_ = 1;
         while(_loc3_ < CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES.length)
         {
            _container.findChildByName("meter_level_" + _loc3_).visible = false;
            _container.findChildByName("meter_level_" + _loc3_ + "_icon").visible = false;
            _container.findChildByName("meter_level_" + _loc3_ + "_icon_locked").visible = false;
            _loc3_++;
         }
         var _loc2_:String = "landing.view.community.meter";
         _landingView.localizationManager.registerParameter(_loc2_,"userRank",_communityProgress.personalContributionRank.toString());
         _landingView.localizationManager.registerParameter(_loc2_,"userAmount",_communityProgress.personalContributionScore.toString());
         _landingView.localizationManager.registerParameter(_loc2_,"totalAmount",_communityProgress.communityTotalScore.toString());
         if(_communityProgress != null && _communityProgress.goalCode != null)
         {
            _landingView.localizationManager.registerParameter("landing.view.community.meter." + _communityProgress.goalCode,"totalAmount",_communityProgress.communityTotalScore.toString());
            setCampaignLocalization("community_total_status","landing.view.community.meter");
            if(UnknownVarFromCommunityGoalWidget_Boolean_4)
            {
               setCampaignLocalization("community_vote_one_button","landing.view.vote_one_button.text");
               setCampaignLocalization("community_vote_two_button","landing.view.vote_two_button.text");
            }
         }
         var _loc1_:ITextWindow = ITextWindow(_container.findChildByName("goal_info"));
         _loc1_.height = _loc1_.textHeight + 6;
         if(!UnknownVarFromCommunityGoalWidget_Boolean_4)
         {
            _container.findChildByName("community_catalog_button").visible = UnknownVarFromCommunityGoalWidget_Boolean_3;
         }
         _container.visible = true;
         _container.invalidate();
      }
      
      protected function updateMeter(param1:int, param2:Boolean = true) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         _loc3_ = 1;
         while(_loc3_ < CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES.length)
         {
            _loc4_ = param2 && param1 >= CHALLENGE_LEVEL_NEEDLE_BASE_FRAMES[_loc3_];
            _container.findChildByName("meter_level_" + _loc3_).visible = _loc4_;
            _container.findChildByName("meter_level_" + _loc3_ + "_icon").visible = _loc4_;
            _container.findChildByName("meter_level_" + _loc3_ + "_icon_locked").visible = !_loc4_;
            _loc3_++;
         }
         UnknownVarFromCommunityGoalWidget_IStaticBitmapWrapperWindow_1.assetUri = "landing_view_needle_meter_needle" + param1;
      }
      
      public function refresh() : void
      {
         requestCommunityGoalProgress();
         refreshContent();
      }
      
      private function requestCommunityGoalProgress() : void
      {
         if(!UnknownVarFromCommunityGoalWidget_Boolean_1)
         {
            _landingView.send(new GetCommunityGoalProgressMessageComposer());
            UnknownVarFromCommunityGoalWidget_Boolean_1 = true;
         }
      }
      
      public function update(param1:uint) : void
      {
         UnknownVarFromCommunityGoalWidget_Number_1 += param1;
         if(UnknownVarFromCommunityGoalWidget_Number_1 > 1500)
         {
            _buildupProgress += param1 / 1000;
            if(_buildupProgress > 1)
            {
               _buildupProgress = 1;
               Component(_landingView.windowManager).removeUpdateReceiver(this);
            }
            updateMeter(Math.floor(getCurrentNeedleFrame() * _buildupProgress));
         }
      }
      
      private function onCommunityGoalProgress(param1:IMessageEvent) : void
      {
         _communityProgress = CommunityGoalProgressMessageParser(param1.parser).data;
         UnknownVarFromCommunityGoalWidget_Boolean_1 = false;
         refreshContent();
         Component(_landingView.windowManager).registerUpdateReceiver(this,10);
      }
      
      private function onCommunityCatalogButtonClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:String = null;
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = _landingView.getProperty("landing.view.community.catalog.target");
            _landingView.catalog.openCatalogPage(_loc3_);
            _landingView.tracking.trackGoogle("landingView","click_communityCatalogTarget");
         }
      }
      
      public function set settings(param1:CommonWidgetSettings) : void
      {
         WidgetContainerLayout.applyCommonWidgetSettings(_container,param1);
      }
      
      protected function get communityProgress() : CommunityGoalData
      {
         return _communityProgress;
      }
   }
}

