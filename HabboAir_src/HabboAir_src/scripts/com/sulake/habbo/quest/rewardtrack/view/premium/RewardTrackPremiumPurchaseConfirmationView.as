package com.sulake.habbo.quest.rewardtrack.view.premium
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.quest.rewardtrack.RewardTrackController;
   import com.sulake.habbo.quest.rewardtrack.data.RewardTrack;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class RewardTrackPremiumPurchaseConfirmationView implements IComponentInterfaceQueue
   {
      private static const RETRY_ENABLE_DELAY_MS:int = 500;
      
      private var UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrackController_1:RewardTrackController;
      
      private var UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrack_1:RewardTrack;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_Timer_1:Timer;
      
      private var UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_Boolean_1:Boolean;
      
      private var _disposed:Boolean;
      
      public function RewardTrackPremiumPurchaseConfirmationView(param1:RewardTrackController, param2:RewardTrack)
      {
         super();
         UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrackController_1 = param1;
         UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrack_1 = param2;
         _window = UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrackController_1.windowManager.buildFromXML(XML(UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrackController_1.assets.getAssetByName("reward_track_premium_purchase_confirmation_xml").content),1) as IWindowController_1;
         _window.enableLookupCache();
         closeButton.addEventListener("WME_CLICK",onWindowClose);
         cancelButton.addEventListener("WME_CLICK",onWindowClose);
         confirmButton.addEventListener("WME_CLICK",onConfirmClicked);
         initializeUI();
      }
      
      private function initializeUI() : void
      {
         boostBenefitText.text = UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrackController_1.localizationManager.getLocalizationWithParams("reward_track.premium.confirm.benefit.boost","","percent",Math.round((UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrack_1.taskPointsBoost - 1) * 100));
         instantPointsBenefitText.text = UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrackController_1.localizationManager.getLocalizationWithParams("reward_track.premium.confirm.benefit.instant_points","","points",UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrack_1.instantPoints);
         boostBenefitRow.visible = UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrack_1.taskPointsBoost > 1;
         rewardsBenefitRow.visible = UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrack_1.hasPremiumPrizes;
         instantPointsBenefitRow.visible = UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrack_1.instantPoints > 0;
         tasksBenefitRow.visible = UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrack_1.hasPremiumTasks;
         levelsBenefitRow.visible = UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrack_1.hasPremiumLevels;
         priceCreditsText.text = String(UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrack_1.costCredits);
         priceDiamondsText.text = String(UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrack_1.costDiamonds);
         priceCreditsText.visible = UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrack_1.costCredits > 0;
         creditsIcon.visible = UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrack_1.costCredits > 0;
         priceDiamondsText.visible = UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrack_1.costDiamonds > 0;
         diamondsIcon.visible = UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrack_1.costDiamonds > 0;
         pricePlusText.visible = UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrack_1.costCredits > 0 && UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrack_1.costDiamonds > 0;
      }
      
      public function show() : void
      {
         var _loc1_:IDesktopController = null;
         if(_window.parent == null)
         {
            _loc1_ = UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrackController_1.windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(_window);
            }
         }
         _window.center();
         _window.activate();
      }
      
      public function purchaseFailed() : void
      {
         if(UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_Timer_1 != null)
         {
            UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_Timer_1.stop();
            UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_Timer_1.removeEventListener("timerComplete",onRetryTimerComplete);
         }
         UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_Timer_1 = new Timer(500,1);
         UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_Timer_1.addEventListener("timerComplete",onRetryTimerComplete);
         UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_Timer_1.start();
      }
      
      private function onConfirmClicked(param1:WindowMouseEvent) : void
      {
         setPending(true);
         UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrackController_1.purchasePremium(UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrack_1.id);
      }
      
      private function onRetryTimerComplete(param1:TimerEvent) : void
      {
         UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_Timer_1.removeEventListener("timerComplete",onRetryTimerComplete);
         UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_Timer_1 = null;
         setPending(false);
      }
      
      private function onWindowClose(param1:WindowEvent) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         if(UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_Boolean_1)
         {
            return;
         }
         UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrackController_1.closePremiumPurchaseConfirmation();
      }
      
      public function setPending(param1:Boolean) : void
      {
         UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_Boolean_1 = param1;
         if(UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_Boolean_1)
         {
            confirmButton.disable();
            cancelButton.disable();
            closeButton.disable();
            return;
         }
         confirmButton.enable();
         cancelButton.enable();
         closeButton.enable();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         if(UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_Timer_1 != null)
         {
            UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_Timer_1.stop();
            UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_Timer_1.removeEventListener("timerComplete",onRetryTimerComplete);
            UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_Timer_1 = null;
         }
         closeButton.removeEventListener("WME_CLICK",onWindowClose);
         cancelButton.removeEventListener("WME_CLICK",onWindowClose);
         confirmButton.removeEventListener("WME_CLICK",onConfirmClicked);
         if(_window.parent != null)
         {
            IWindowController_1(_window.parent).removeChild(_window);
         }
         _window.dispose();
         _window = null;
         UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrackController_1 = null;
         UnknownVarFromRewardTrackPremiumPurchaseConfirmationView_RewardTrack_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get closeButton() : IWindowModel
      {
         return _window.findChildByName("header_button_close");
      }
      
      private function get benefitsList() : IItemListWindow
      {
         return _window.findChildByName("benefits") as IItemListWindow;
      }
      
      private function get boostBenefitRow() : IWindowModel
      {
         return benefitsList.findChildByName("benefit_boost_row");
      }
      
      private function get boostBenefitText() : ITextWindow
      {
         return benefitsList.findChildByName("benefit_boost_txt") as ITextWindow;
      }
      
      private function get rewardsBenefitRow() : IWindowModel
      {
         return benefitsList.findChildByName("benefit_rewards_row");
      }
      
      private function get rewardsBenefitText() : ITextWindow
      {
         return benefitsList.findChildByName("benefit_rewards_txt") as ITextWindow;
      }
      
      private function get instantPointsBenefitRow() : IWindowModel
      {
         return benefitsList.findChildByName("benefit_instant_points_row");
      }
      
      private function get instantPointsBenefitText() : ITextWindow
      {
         return benefitsList.findChildByName("benefit_instant_points_txt") as ITextWindow;
      }
      
      private function get tasksBenefitRow() : IWindowModel
      {
         return benefitsList.findChildByName("benefit_tasks_row");
      }
      
      private function get tasksBenefitText() : ITextWindow
      {
         return benefitsList.findChildByName("benefit_tasks_txt") as ITextWindow;
      }
      
      private function get levelsBenefitRow() : IWindowModel
      {
         return benefitsList.findChildByName("benefit_levels_row");
      }
      
      private function get levelsBenefitText() : ITextWindow
      {
         return benefitsList.findChildByName("benefit_levels_txt") as ITextWindow;
      }
      
      private function get priceCreditsText() : ITextWindow
      {
         return _window.findChildByName("price_credits") as ITextWindow;
      }
      
      private function get pricePlusText() : ITextWindow
      {
         return _window.findChildByName("plus_txt") as ITextWindow;
      }
      
      private function get priceDiamondsText() : ITextWindow
      {
         return _window.findChildByName("price_diamonds") as ITextWindow;
      }
      
      private function get creditsIcon() : IWindowModel
      {
         return _window.findChildByName("credits_icon");
      }
      
      private function get diamondsIcon() : IWindowModel
      {
         return _window.findChildByName("diamonds_icon");
      }
      
      private function get cancelButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("cancel_button") as UnknownICoreWindowComponents4;
      }
      
      private function get confirmButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("confirm_button") as UnknownICoreWindowComponents4;
      }
   }
}

