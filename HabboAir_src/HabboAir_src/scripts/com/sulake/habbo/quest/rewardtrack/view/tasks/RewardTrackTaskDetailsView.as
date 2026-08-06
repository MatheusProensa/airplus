package com.sulake.habbo.quest.rewardtrack.view.tasks
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IScrollableListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.quest.rewardtrack.RewardTrackController;
   import com.sulake.habbo.quest.rewardtrack.data.RewardTrackTask;
   import com.sulake.habbo.quest.rewardtrack.data.RewardTrackTaskLevel;
   import com.sulake.habbo.quest.rewardtrack.view.theme.RewardTrackTheme;
   import flash.geom.Rectangle;
   
   public class RewardTrackTaskDetailsView implements IComponentInterfaceQueue
   {
      private var UnknownVarFromRewardTrackTaskDetailsView_RewardTrackController_1:RewardTrackController;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromRewardTrackTaskDetailsView_IWindowController_1_1:IWindowController_1;
      
      private var _theme:RewardTrackTheme;
      
      private var UnknownVarFromRewardTrackTaskDetailsView_RewardTrackTask_1:RewardTrackTask;
      
      private var UnknownVarFromRewardTrackTaskDetailsView_Vector_1:Vector.<RewardTrackTaskLevelView>;
      
      private var _hintInternalLink:String;
      
      private var _disposed:Boolean;
      
      public function RewardTrackTaskDetailsView(param1:RewardTrackController, param2:IWindowController_1, param3:IWindowController_1, param4:RewardTrackTheme)
      {
         super();
         UnknownVarFromRewardTrackTaskDetailsView_RewardTrackController_1 = param1;
         _window = param2;
         UnknownVarFromRewardTrackTaskDetailsView_IWindowController_1_1 = param3;
         _theme = param4;
         UnknownVarFromRewardTrackTaskDetailsView_Vector_1 = new Vector.<RewardTrackTaskLevelView>();
         hintButton.addEventListener("WME_CLICK",onHintClicked);
         initializeStaffActions();
      }
      
      private function initializeStaffActions() : void
      {
         taskNameRegion.interactiveCursorDisabled = !UnknownVarFromRewardTrackTaskDetailsView_RewardTrackController_1.canCopyDebugIds;
         if(UnknownVarFromRewardTrackTaskDetailsView_RewardTrackController_1.canCopyDebugIds)
         {
            taskNameRegion.addEventListener("WME_CLICK",onTaskNameClicked);
         }
      }
      
      public function selectTask(param1:RewardTrackTask, param2:Boolean) : void
      {
         UnknownVarFromRewardTrackTaskDetailsView_RewardTrackTask_1 = param1;
         _window.visible = true;
         taskNameText.text = localize("reward_track." + UnknownVarFromRewardTrackTaskDetailsView_RewardTrackTask_1.track.id + ".task." + UnknownVarFromRewardTrackTaskDetailsView_RewardTrackTask_1.id + ".name");
         taskDescriptionText.text = localize("reward_track." + UnknownVarFromRewardTrackTaskDetailsView_RewardTrackTask_1.track.id + ".task." + UnknownVarFromRewardTrackTaskDetailsView_RewardTrackTask_1.id + ".desc");
         taskImage.assetUri = "reward_track_tasks_" + UnknownVarFromRewardTrackTaskDetailsView_RewardTrackTask_1.actionType.toLowerCase();
         taskHintText.text = localize("reward_track." + UnknownVarFromRewardTrackTaskDetailsView_RewardTrackTask_1.track.id + ".task." + UnknownVarFromRewardTrackTaskDetailsView_RewardTrackTask_1.id + ".hint.desc");
         var _loc3_:String = "reward_track." + UnknownVarFromRewardTrackTaskDetailsView_RewardTrackTask_1.track.id + ".task." + UnknownVarFromRewardTrackTaskDetailsView_RewardTrackTask_1.id + ".hint";
         _hintInternalLink = UnknownVarFromRewardTrackTaskDetailsView_RewardTrackController_1.getProperty(_loc3_ + ".internal_link");
         hintButton.visible = _hintInternalLink != "";
         hintButton.caption = "${" + _loc3_ + ".button_text}";
         rebuildLevels(param2);
         scrollActiveLevelIntoView();
      }
      
      public function clear() : void
      {
         UnknownVarFromRewardTrackTaskDetailsView_RewardTrackTask_1 = null;
         _window.visible = false;
         levelsList.removeListItems();
         for each(var _loc1_ in UnknownVarFromRewardTrackTaskDetailsView_Vector_1)
         {
            _loc1_.recycle();
         }
         UnknownVarFromRewardTrackTaskDetailsView_Vector_1 = new Vector.<RewardTrackTaskLevelView>();
      }
      
      public function refresh(param1:Boolean) : void
      {
         for each(var _loc2_ in UnknownVarFromRewardTrackTaskDetailsView_Vector_1)
         {
            _loc2_.refresh(param1);
         }
      }
      
      public function update(param1:uint) : void
      {
         for each(var _loc2_ in UnknownVarFromRewardTrackTaskDetailsView_Vector_1)
         {
            _loc2_.update(param1);
         }
      }
      
      private function rebuildLevels(param1:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc4_:RewardTrackTaskLevel = null;
         var _loc2_:RewardTrackTaskLevelView = null;
         levelsList.removeListItems();
         for each(var _loc3_ in UnknownVarFromRewardTrackTaskDetailsView_Vector_1)
         {
            _loc3_.recycle();
         }
         UnknownVarFromRewardTrackTaskDetailsView_Vector_1 = new Vector.<RewardTrackTaskLevelView>();
         _loc5_ = 0;
         while(_loc5_ < UnknownVarFromRewardTrackTaskDetailsView_RewardTrackTask_1.levels.length)
         {
            _loc4_ = UnknownVarFromRewardTrackTaskDetailsView_RewardTrackTask_1.levels[_loc5_];
            _loc2_ = RewardTrackTaskLevelView.create(UnknownVarFromRewardTrackTaskDetailsView_IWindowController_1_1,UnknownVarFromRewardTrackTaskDetailsView_RewardTrackController_1,UnknownVarFromRewardTrackTaskDetailsView_RewardTrackTask_1,_loc4_,_loc5_,_theme);
            UnknownVarFromRewardTrackTaskDetailsView_Vector_1.push(_loc2_);
            levelsList.addListItem(_loc2_.window);
            _loc2_.refresh(param1);
            _loc5_ += 1;
         }
      }
      
      private function scrollActiveLevelIntoView() : void
      {
         if(levelsList.maxScrollV <= 0)
         {
            levelsList.scrollV = 0;
            return;
         }
         var _loc1_:RewardTrackTaskLevelView = UnknownVarFromRewardTrackTaskDetailsView_Vector_1[UnknownVarFromRewardTrackTaskDetailsView_RewardTrackTask_1.activeLevelIndex];
         var _loc5_:Rectangle = levelsList.visibleRegion;
         var _loc2_:int = int(_loc1_.window.y);
         var _loc3_:int = _loc2_ + _loc1_.window.height;
         var _loc4_:* = int(_loc5_.y);
         if(_loc2_ < _loc5_.y)
         {
            _loc4_ = _loc2_;
         }
         else if(_loc3_ > _loc5_.bottom)
         {
            _loc4_ = _loc3_ - _loc5_.height;
         }
         if(_loc4_ != _loc5_.y)
         {
            levelsList.scrollV = _loc4_ / levelsList.maxScrollV;
         }
      }
      
      private function onHintClicked(param1:WindowMouseEvent) : void
      {
         if(_hintInternalLink == "")
         {
            return;
         }
         UnknownVarFromRewardTrackTaskDetailsView_RewardTrackController_1.context.createLinkEvent(_hintInternalLink);
      }
      
      private function onTaskNameClicked(param1:WindowMouseEvent) : void
      {
         UnknownVarFromRewardTrackTaskDetailsView_RewardTrackController_1.copyTaskId(UnknownVarFromRewardTrackTaskDetailsView_RewardTrackTask_1.id);
      }
      
      private function localize(param1:String) : String
      {
         return UnknownVarFromRewardTrackTaskDetailsView_RewardTrackController_1.localizationManager.getLocalization(param1,param1);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         hintButton.removeEventListener("WME_CLICK",onHintClicked);
         taskNameRegion.removeEventListener("WME_CLICK",onTaskNameClicked);
         levelsList.removeListItems();
         for each(var _loc1_ in UnknownVarFromRewardTrackTaskDetailsView_Vector_1)
         {
            _loc1_.recycle();
         }
         UnknownVarFromRewardTrackTaskDetailsView_Vector_1 = null;
         UnknownVarFromRewardTrackTaskDetailsView_RewardTrackController_1 = null;
         _window = null;
         UnknownVarFromRewardTrackTaskDetailsView_IWindowController_1_1 = null;
         _theme = null;
         UnknownVarFromRewardTrackTaskDetailsView_RewardTrackTask_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get taskNameText() : ITextWindow
      {
         return _window.findChildByName("task_info_name") as ITextWindow;
      }
      
      private function get taskNameRegion() : IRegionWindow
      {
         return _window.findChildByName("task_info_name_region") as IRegionWindow;
      }
      
      private function get taskDescriptionText() : ITextWindow
      {
         return _window.findChildByName("task_info_description") as ITextWindow;
      }
      
      private function get taskImage() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("task_info_img") as IStaticBitmapWrapperWindow;
      }
      
      private function get levelsList() : IScrollableListWindow
      {
         return _window.findChildByName("levels") as IScrollableListWindow;
      }
      
      private function get taskHintText() : ITextWindow
      {
         return _window.findChildByName("task_hint_text") as ITextWindow;
      }
      
      private function get hintButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("hint_redirect_btn") as UnknownICoreWindowComponents4;
      }
   }
}

