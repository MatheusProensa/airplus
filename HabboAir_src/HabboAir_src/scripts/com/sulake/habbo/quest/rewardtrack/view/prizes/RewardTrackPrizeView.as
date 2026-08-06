package com.sulake.habbo.quest.rewardtrack.view.prizes
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.WindowUtils;
   import com.sulake.habbo.quest.rewardtrack.RewardTrackController;
   import com.sulake.habbo.quest.rewardtrack.data.RewardTrack;
   import com.sulake.habbo.quest.rewardtrack.data.RewardTrackPrize;
   import com.sulake.habbo.quest.rewardtrack.data.RewardTrackRewardDisplayWrapper;
   import com.sulake.habbo.window.widgets.IProductIconWidget;
   
   public class RewardTrackPrizeView implements IComponentInterfaceQueue
   {
      private static const UnknownConstFromRewardTrackPrizeView_Int_1:int = 3;
      
      private var UnknownVarFromRewardTrackPrizeView_RewardTrackController_1:RewardTrackController;
      
      private var UnknownVarFromRewardTrackPrizeView_RewardTrack_1:RewardTrack;
      
      private var _prize:RewardTrackPrize;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromRewardTrackPrizeView_Int_1:int;
      
      private var _disposed:Boolean;
      
      public function RewardTrackPrizeView(param1:IWindowController_1)
      {
         super();
         _window = param1.clone() as IWindowController_1;
         UnknownVarFromRewardTrackPrizeView_Int_1 = productIcon.y;
         clickRegion.addEventListener("WME_CLICK",onClick);
      }
      
      public function initialize(param1:RewardTrackController, param2:RewardTrack, param3:RewardTrackPrize) : void
      {
         UnknownVarFromRewardTrackPrizeView_RewardTrackController_1 = param1;
         UnknownVarFromRewardTrackPrizeView_RewardTrack_1 = param2;
         _prize = param3;
         refresh();
      }
      
      public function refresh() : void
      {
         (productIcon.widget as IProductIconWidget).productInfo = new RewardTrackRewardDisplayWrapper(_prize);
         quantityContainer.visible = _prize.rewardAmount > 1;
         quantityText.text = String(_prize.rewardAmount);
         productIcon.y = _prize.rewardAmount > 1 ? UnknownVarFromRewardTrackPrizeView_Int_1 - 3 : UnknownVarFromRewardTrackPrizeView_Int_1;
         refreshState();
      }
      
      public function refreshState() : void
      {
         claimedIcon.visible = _prize.claimed;
         lockedIcon.visible = _prize.isPremiumLocked(UnknownVarFromRewardTrackPrizeView_RewardTrack_1);
         if(_prize.claimed)
         {
            clickRegion.toolTipCaption = "${reward_track.rewards.reward_tooltip.claimed}";
         }
         else if(_prize.isPremiumLocked(UnknownVarFromRewardTrackPrizeView_RewardTrack_1))
         {
            clickRegion.toolTipCaption = "${reward_track.rewards.reward_tooltip.premium}";
         }
         else if(!_prize.isAvailable(UnknownVarFromRewardTrackPrizeView_RewardTrack_1))
         {
            clickRegion.toolTipCaption = "${reward_track.rewards.reward_tooltip.not_enough_points}";
         }
         else
         {
            clickRegion.toolTipCaption = "${reward_track.rewards.reward_tooltip.claim}";
         }
         WindowUtils.disableSection(_window,!_prize.hasEnoughPoints(UnknownVarFromRewardTrackPrizeView_RewardTrack_1),0.75);
      }
      
      public function clear() : void
      {
         UnknownVarFromRewardTrackPrizeView_RewardTrackController_1 = null;
         UnknownVarFromRewardTrackPrizeView_RewardTrack_1 = null;
         _prize = null;
         _window.visible = false;
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         if(_prize == null)
         {
            return;
         }
         if(_prize.claimed)
         {
            return;
         }
         if(_prize.isPremiumLocked(UnknownVarFromRewardTrackPrizeView_RewardTrack_1))
         {
            UnknownVarFromRewardTrackPrizeView_RewardTrackController_1.openPremiumPurchaseConfirmation(UnknownVarFromRewardTrackPrizeView_RewardTrack_1);
            return;
         }
         if(_prize.isClaimable(UnknownVarFromRewardTrackPrizeView_RewardTrack_1))
         {
            UnknownVarFromRewardTrackPrizeView_RewardTrackController_1.claimPrize(UnknownVarFromRewardTrackPrizeView_RewardTrack_1.id,_prize.id);
         }
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
         clickRegion.removeEventListener("WME_CLICK",onClick);
         _window.dispose();
         _window = null;
         UnknownVarFromRewardTrackPrizeView_RewardTrackController_1 = null;
         UnknownVarFromRewardTrackPrizeView_RewardTrack_1 = null;
         _prize = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function get prize() : RewardTrackPrize
      {
         return _prize;
      }
      
      private function get clickRegion() : IRegionWindow
      {
         return _window.findChildByName("click_region") as IRegionWindow;
      }
      
      private function get productIcon() : IWidgetWindowController
      {
         return _window.findChildByName("product_icon") as IWidgetWindowController;
      }
      
      private function get quantityContainer() : IWindowController_1
      {
         return _window.findChildByName("quantity_container") as IWindowController_1;
      }
      
      private function get quantityText() : ITextWindow
      {
         return quantityContainer.getChildAt(0) as ITextWindow;
      }
      
      private function get lockedIcon() : IWindowModel
      {
         return _window.findChildByName("locked_icon");
      }
      
      private function get claimedIcon() : IWindowModel
      {
         return _window.findChildByName("claimed_icon");
      }
   }
}

