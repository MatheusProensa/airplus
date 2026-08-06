package com.sulake.habbo.quest.rewardtrack.view
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.quest.rewardtrack.RewardTrackController;
   import com.sulake.habbo.quest.rewardtrack.data.RewardTrack;
   import com.sulake.habbo.quest.rewardtrack.data.RewardTrackPrize;
   import com.sulake.habbo.quest.rewardtrack.data.RewardTrackTask;
   import com.sulake.habbo.quest.rewardtrack.view.header.RewardTrackHeaderView;
   import com.sulake.habbo.quest.rewardtrack.view.prizes.RewardTrackPrizeTrackView;
   import com.sulake.habbo.quest.rewardtrack.view.tasks.RewardTrackTaskDetailsView;
   import com.sulake.habbo.quest.rewardtrack.view.tasks.RewardTrackTaskListView;
   import com.sulake.habbo.quest.rewardtrack.view.theme.RewardTrackTheme;
   import flash.geom.Point;
   
   public class RewardTrackView implements IComponentInterfaceQueue, IProfiler_1
   {
      private var UnknownVarFromRewardTrackView_RewardTrackController_1:RewardTrackController;
      
      private var _track:RewardTrack;
      
      private var _window:IFrameController;
      
      private var UnknownVarFromRewardTrackView_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromRewardTrackView_IWindowController_1_2:IWindowController_1;
      
      private var UnknownVarFromRewardTrackView_IWindowController_1_3:IWindowController_1;
      
      private var UnknownVarFromRewardTrackView_IWindowController_1_4:IWindowController_1;
      
      private var UnknownVarFromRewardTrackView_IWindowController_1_5:IWindowController_1;
      
      private var _theme:RewardTrackTheme;
      
      private var _headerView:RewardTrackHeaderView;
      
      private var UnknownVarFromRewardTrackView_RewardTrackPrizeTrackView_1:RewardTrackPrizeTrackView;
      
      private var UnknownVarFromRewardTrackView_RewardTrackTaskListView_1:RewardTrackTaskListView;
      
      private var UnknownVarFromRewardTrackView_RewardTrackTaskDetailsView_1:RewardTrackTaskDetailsView;
      
      private var _disposed:Boolean;
      
      public function RewardTrackView(param1:RewardTrackController, param2:RewardTrack)
      {
         super();
         UnknownVarFromRewardTrackView_RewardTrackController_1 = param1;
         _track = param2;
         _theme = RewardTrackTheme.resolve(_track.theme);
         _window = UnknownVarFromRewardTrackView_RewardTrackController_1.windowManager.buildFromXML(XML(UnknownVarFromRewardTrackView_RewardTrackController_1.assets.getAssetByName("reward_track_main_xml").content),1) as IFrameController;
         _theme.applyTo(_window);
         UnknownVarFromRewardTrackView_RewardTrackController_1.windowManager.LilithCustomsInstance.HandleWindowFrameColor(_window);
         extractTemplates();
         _window.enableLookupCache();
         closeButton.addEventListener("WME_CLICK",onCloseClicked);
      }
      
      public function initialize() : void
      {
         _headerView = new RewardTrackHeaderView(UnknownVarFromRewardTrackView_RewardTrackController_1,headerContainer,_track);
         UnknownVarFromRewardTrackView_RewardTrackTaskDetailsView_1 = new RewardTrackTaskDetailsView(UnknownVarFromRewardTrackView_RewardTrackController_1,taskInfoContainer,UnknownVarFromRewardTrackView_IWindowController_1_5,_theme);
         UnknownVarFromRewardTrackView_RewardTrackTaskListView_1 = new RewardTrackTaskListView(UnknownVarFromRewardTrackView_RewardTrackController_1,taskListContainer,UnknownVarFromRewardTrackView_IWindowController_1_4,UnknownVarFromRewardTrackView_RewardTrackTaskDetailsView_1,_track,_theme);
         UnknownVarFromRewardTrackView_RewardTrackPrizeTrackView_1 = new RewardTrackPrizeTrackView(UnknownVarFromRewardTrackView_RewardTrackController_1,_track,prizeContent,pointsIndicator,mainLoadingBar,UnknownVarFromRewardTrackView_IWindowController_1_1,UnknownVarFromRewardTrackView_IWindowController_1_2,UnknownVarFromRewardTrackView_IWindowController_1_3,previousButton,nextButton,previousUnclaimedIndicator,nextUnclaimedIndicator);
      }
      
      private function extractTemplates() : void
      {
         UnknownVarFromRewardTrackView_IWindowController_1_1 = prizeContent.removeChild(prizeContent.findChildByName("prize_template")) as IWindowController_1;
         UnknownVarFromRewardTrackView_IWindowController_1_2 = prizeContent.removeChild(prizeContent.findChildByName("prize_template_premium")) as IWindowController_1;
         UnknownVarFromRewardTrackView_IWindowController_1_3 = pointsIndicator.removeChild(pointsIndicator.findChildByName("point_indicator_template")) as IWindowController_1;
         UnknownVarFromRewardTrackView_IWindowController_1_4 = tasksList.removeListItemAt(0) as IWindowController_1;
         UnknownVarFromRewardTrackView_IWindowController_1_5 = levelsList.removeListItemAt(0) as IWindowController_1;
      }
      
      public function show() : void
      {
         var _loc1_:IDesktopController = null;
         _headerView.refreshOwnAvatar();
         if(_window.parent == null)
         {
            _loc1_ = UnknownVarFromRewardTrackView_RewardTrackController_1.windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(_window);
            }
         }
      }
      
      public function hide() : void
      {
         var _loc1_:IDesktopController = null;
         if(_window.parent != null)
         {
            _loc1_ = UnknownVarFromRewardTrackView_RewardTrackController_1.windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
         }
      }
      
      public function activate() : void
      {
         _window.activate();
      }
      
      public function center() : void
      {
         _window.center();
      }
      
      public function isShowing() : Boolean
      {
         return _window.parent != null;
      }
      
      public function get shouldAnimate() : Boolean
      {
         return isShowing();
      }
      
      public function taskProgressUpdated(param1:RewardTrackTask, param2:Boolean, param3:Boolean) : void
      {
         _headerView.refreshPoints();
         UnknownVarFromRewardTrackView_RewardTrackPrizeTrackView_1.pointsUpdated(shouldAnimate);
         if(param1 != null)
         {
            UnknownVarFromRewardTrackView_RewardTrackTaskListView_1.taskProgressUpdated(param1,param2,param3,shouldAnimate);
         }
      }
      
      public function prizeClaimed(param1:RewardTrackPrize) : void
      {
         _headerView.refreshRewardsCollected();
         UnknownVarFromRewardTrackView_RewardTrackPrizeTrackView_1.prizeClaimed(param1);
      }
      
      public function premiumPurchased() : void
      {
         _headerView.refreshPoints();
         UnknownVarFromRewardTrackView_RewardTrackTaskListView_1.premiumUpdated();
         UnknownVarFromRewardTrackView_RewardTrackPrizeTrackView_1.premiumUpdated(shouldAnimate);
      }
      
      public function update(param1:uint) : void
      {
         UnknownVarFromRewardTrackView_RewardTrackTaskListView_1.update(param1);
         UnknownVarFromRewardTrackView_RewardTrackPrizeTrackView_1.update(param1);
      }
      
      public function get location() : Point
      {
         return new Point(_window.x,_window.y);
      }
      
      public function setLocation(param1:Point) : void
      {
         _window.x = param1.x;
         _window.y = param1.y;
      }
      
      private function onCloseClicked(param1:WindowMouseEvent) : void
      {
         hide();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(UnknownVarFromRewardTrackView_RewardTrackPrizeTrackView_1 != null)
         {
            UnknownVarFromRewardTrackView_RewardTrackPrizeTrackView_1.dispose();
         }
         if(UnknownVarFromRewardTrackView_RewardTrackTaskListView_1 != null)
         {
            UnknownVarFromRewardTrackView_RewardTrackTaskListView_1.dispose();
         }
         if(UnknownVarFromRewardTrackView_RewardTrackTaskDetailsView_1 != null)
         {
            UnknownVarFromRewardTrackView_RewardTrackTaskDetailsView_1.dispose();
         }
         if(_headerView != null)
         {
            _headerView.dispose();
         }
         closeButton.removeEventListener("WME_CLICK",onCloseClicked);
         hide();
         UnknownVarFromRewardTrackView_IWindowController_1_1.dispose();
         UnknownVarFromRewardTrackView_IWindowController_1_2.dispose();
         UnknownVarFromRewardTrackView_IWindowController_1_3.dispose();
         UnknownVarFromRewardTrackView_IWindowController_1_4.dispose();
         UnknownVarFromRewardTrackView_IWindowController_1_5.dispose();
         _window.dispose();
         UnknownVarFromRewardTrackView_RewardTrackPrizeTrackView_1 = null;
         UnknownVarFromRewardTrackView_RewardTrackTaskListView_1 = null;
         UnknownVarFromRewardTrackView_RewardTrackTaskDetailsView_1 = null;
         _headerView = null;
         UnknownVarFromRewardTrackView_IWindowController_1_1 = null;
         UnknownVarFromRewardTrackView_IWindowController_1_2 = null;
         UnknownVarFromRewardTrackView_IWindowController_1_3 = null;
         UnknownVarFromRewardTrackView_IWindowController_1_4 = null;
         UnknownVarFromRewardTrackView_IWindowController_1_5 = null;
         _window = null;
         UnknownVarFromRewardTrackView_RewardTrackController_1 = null;
         _track = null;
         _theme = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get track() : RewardTrack
      {
         return _track;
      }
      
      private function get closeButton() : IWindowModel
      {
         return _window.findChildByName("header_button_close");
      }
      
      private function get headerContainer() : IWindowController_1
      {
         return _window.findChildByName("header") as IWindowController_1;
      }
      
      private function get prizeContent() : IWindowController_1
      {
         return _window.findChildByName("prize_content") as IWindowController_1;
      }
      
      private function get pointsIndicator() : IWindowController_1
      {
         return _window.findChildByName("points_indicator") as IWindowController_1;
      }
      
      private function get trackContainer() : IWindowController_1
      {
         return _window.findChildByName("track") as IWindowController_1;
      }
      
      private function get mainLoadingBar() : IWindowController_1
      {
         return trackContainer.findChildByName("loading_bar") as IWindowController_1;
      }
      
      private function get previousButton() : IRegionWindow
      {
         return _window.findChildByName("previous_btn") as IRegionWindow;
      }
      
      private function get nextButton() : IRegionWindow
      {
         return _window.findChildByName("next_btn") as IRegionWindow;
      }
      
      private function get previousUnclaimedIndicator() : IWindowController_1
      {
         return _window.findChildByName("previous_unclaimed_indicator") as IWindowController_1;
      }
      
      private function get nextUnclaimedIndicator() : IWindowController_1
      {
         return _window.findChildByName("next_unclaimed_indicator") as IWindowController_1;
      }
      
      private function get taskListContainer() : IWindowController_1
      {
         return _window.findChildByName("task_list") as IWindowController_1;
      }
      
      private function get taskInfoContainer() : IWindowController_1
      {
         return _window.findChildByName("task_info") as IWindowController_1;
      }
      
      private function get tasksList() : IScrollableListWindow
      {
         return _window.findChildByName("tasks") as IScrollableListWindow;
      }
      
      private function get levelsList() : IScrollableListWindow
      {
         return _window.findChildByName("levels") as IScrollableListWindow;
      }
   }
}

