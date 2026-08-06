package com.sulake.habbo.quest.rewardtrack.view.prizes
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.quest.rewardtrack.data.RewardTrack;
   
   public class RewardTrackPointIndicatorView implements IComponentInterfaceQueue
   {
      private var UnknownVarFromRewardTrackPointIndicatorView_RewardTrack_1:RewardTrack;
      
      private var UnknownVarFromRewardTrackPointIndicatorView_Int_1:int;
      
      private var _window:IWindowController_1;
      
      private var _disposed:Boolean;
      
      public function RewardTrackPointIndicatorView(param1:IWindowController_1)
      {
         super();
         _window = param1.clone() as IWindowController_1;
      }
      
      public function initialize(param1:RewardTrack, param2:int) : void
      {
         UnknownVarFromRewardTrackPointIndicatorView_RewardTrack_1 = param1;
         UnknownVarFromRewardTrackPointIndicatorView_Int_1 = param2;
         pointsText.text = String(param2);
         refreshAvailability();
      }
      
      public function refreshAvailability() : void
      {
         if(UnknownVarFromRewardTrackPointIndicatorView_RewardTrack_1 == null)
         {
            return;
         }
         availableIcon.assetUri = UnknownVarFromRewardTrackPointIndicatorView_RewardTrack_1.points >= UnknownVarFromRewardTrackPointIndicatorView_Int_1 ? "reward_track_available_icon" : "reward_track_not_available_icon";
      }
      
      public function clear() : void
      {
         UnknownVarFromRewardTrackPointIndicatorView_RewardTrack_1 = null;
         UnknownVarFromRewardTrackPointIndicatorView_Int_1 = 0;
         _window.visible = false;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(_window.parent != null)
         {
            IWindowController_1(_window.parent).removeChild(_window);
         }
         _window.dispose();
         _window = null;
         UnknownVarFromRewardTrackPointIndicatorView_RewardTrack_1 = null;
         UnknownVarFromRewardTrackPointIndicatorView_Int_1 = 0;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      private function get availableIcon() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("available_icon") as IStaticBitmapWrapperWindow;
      }
      
      private function get pointsText() : ITextWindow
      {
         return _window.findChildByName("points_txt") as ITextWindow;
      }
   }
}

