package com.sulake.habbo.catalog.habbicons
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.WindowUtils;
   import com.sulake.habbo.catalog.purse.ActivityPointTypeEnum;
   import com.sulake.habbo.habbicons.assets.HabbiconAssetManager;
   import flash.display.BitmapData;
   
   public class HabbiconRewardPanelView implements IComponentInterfaceQueue
   {
      private var UnknownVarFromHabbiconRewardPanelView_HabbiconController_1:HabbiconController;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromHabbiconRewardPanelView_HabbiconSetModel_1:HabbiconSetModel;
      
      private var UnknownVarFromHabbiconRewardPanelView_Function_1:Function;
      
      private var UnknownVarFromHabbiconRewardPanelView_IWindowModel_1:IWindowModel;
      
      private var _disposed:Boolean;
      
      public function HabbiconRewardPanelView(param1:HabbiconController, param2:IWindowController_1, param3:Function)
      {
         super();
         UnknownVarFromHabbiconRewardPanelView_HabbiconController_1 = param1;
         _window = param2;
         UnknownVarFromHabbiconRewardPanelView_Function_1 = param3;
         rewardHabbicon.disposesBitmap = true;
         rewardActionButton.addEventListener("WME_CLICK",onClaimClicked);
         if(rewardBuyButton != null)
         {
            rewardBuyButton.addEventListener("WME_CLICK",onBuyClicked);
         }
         if(UnknownVarFromHabbiconRewardPanelView_Function_1 != null && rewardTile != null)
         {
            UnknownVarFromHabbiconRewardPanelView_IWindowModel_1 = rewardHabbiconFrame ?? rewardHabbicon;
            UnknownVarFromHabbiconRewardPanelView_IWindowModel_1.addEventListener("WME_CLICK",onRewardTileClick);
         }
      }
      
      public function refresh(param1:HabbiconSetModel, param2:Boolean) : void
      {
         UnknownVarFromHabbiconRewardPanelView_HabbiconSetModel_1 = param1;
         if(UnknownVarFromHabbiconRewardPanelView_HabbiconSetModel_1 == null || UnknownVarFromHabbiconRewardPanelView_HabbiconSetModel_1.rewardHabbicon == null)
         {
            rewardPanel.visible = false;
            if(rewardBuyContainer != null)
            {
               rewardBuyContainer.visible = false;
            }
            rewardActionButton.visible = false;
            rewardActionButton.caption = "${habbicon_reward.claim}";
            WindowUtils.disableSection(rewardActionButton,true);
            clearRewardBitmap();
            return;
         }
         var _loc3_:HabbiconEntryModel = UnknownVarFromHabbiconRewardPanelView_HabbiconSetModel_1.rewardHabbicon;
         var _loc6_:Boolean = isRewardOwned(_loc3_);
         var _loc4_:Boolean = isRewardClaimable(_loc3_);
         var _loc7_:Boolean = isRewardBuyable(UnknownVarFromHabbiconRewardPanelView_HabbiconSetModel_1,_loc3_);
         var _loc5_:String = _loc4_ ? UnknownVarFromHabbiconRewardPanelView_HabbiconController_1.localizationManager.getLocalization("habbicon_book.reward.claimable","Reward ready to claim.") : (_loc6_ ? UnknownVarFromHabbiconRewardPanelView_HabbiconController_1.localizationManager.getLocalization("habbicon_book.reward.claimed","Reward claimed.") : UnknownVarFromHabbiconRewardPanelView_HabbiconController_1.localizationManager.getLocalization("habbicon_book.reward.locked","Complete this set to unlock the reward."));
         rewardPanel.visible = true;
         updateRewardBitmap(_loc3_);
         rewardTitle.text = "${habbicon_book.reward.title}";
         rewardDescription.text = _loc5_;
         rewardActionButton.visible = true;
         rewardActionButton.caption = _loc6_ ? "${habbicon_reward.claimed}" : "${habbicon_reward.claim}";
         WindowUtils.disableSection(rewardActionButton,!_loc4_);
         if(rewardBuyContainer != null)
         {
            rewardBuyContainer.visible = _loc7_;
         }
         if(_loc7_)
         {
            rewardBuyPrice.text = formatPrice(UnknownVarFromHabbiconRewardPanelView_HabbiconSetModel_1.priceCredits,UnknownVarFromHabbiconRewardPanelView_HabbiconSetModel_1.priceActivityPoints);
            rewardBuyCurrencyIcon.style = getPriceIconStyle(UnknownVarFromHabbiconRewardPanelView_HabbiconSetModel_1.priceCredits,UnknownVarFromHabbiconRewardPanelView_HabbiconSetModel_1.priceActivityPoints,UnknownVarFromHabbiconRewardPanelView_HabbiconSetModel_1.activityPointType);
            rewardBuyCurrencyIcon.fitToSize();
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         rewardActionButton.removeEventListener("WME_CLICK",onClaimClicked);
         if(rewardBuyButton != null)
         {
            rewardBuyButton.removeEventListener("WME_CLICK",onBuyClicked);
         }
         if(UnknownVarFromHabbiconRewardPanelView_IWindowModel_1 != null)
         {
            UnknownVarFromHabbiconRewardPanelView_IWindowModel_1.removeEventListener("WME_CLICK",onRewardTileClick);
            UnknownVarFromHabbiconRewardPanelView_IWindowModel_1 = null;
         }
         clearRewardBitmap();
         UnknownVarFromHabbiconRewardPanelView_HabbiconController_1 = null;
         _window = null;
         UnknownVarFromHabbiconRewardPanelView_HabbiconSetModel_1 = null;
         UnknownVarFromHabbiconRewardPanelView_Function_1 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get rewardTile() : HabbiconTileView
      {
         return null;
      }
      
      public function update(param1:uint) : void
      {
      }
      
      private function updateRewardBitmap(param1:HabbiconEntryModel) : void
      {
         var _loc2_:BitmapData = HabbiconAssetManager.getPreviewBitmap(param1.habbiconId,false);
         clearRewardBitmap();
         rewardHabbicon.bitmap = _loc2_ != null ? _loc2_.clone() : new BitmapData(40,40,false,9408399);
         rewardHabbicon.visible = true;
         rewardHabbicon.invalidate();
      }
      
      private function clearRewardBitmap() : void
      {
         if(rewardHabbicon.bitmap != null)
         {
            rewardHabbicon.bitmap = null;
            rewardHabbicon.invalidate();
         }
      }
      
      private function isRewardOwned(param1:HabbiconEntryModel) : Boolean
      {
         return param1 != null && (param1.owned || param1.favorite);
      }
      
      private function isRewardClaimable(param1:HabbiconEntryModel) : Boolean
      {
         return param1 != null && param1.claimable && !isRewardOwned(param1);
      }
      
      private function isRewardBuyable(param1:HabbiconSetModel, param2:HabbiconEntryModel) : Boolean
      {
         return param1 != null && param1.canBuy && param2 != null && !param2.owned && !param2.favorite && !param2.claimable;
      }
      
      private function formatPrice(param1:int, param2:int) : String
      {
         if(param1 > 0 && param2 > 0)
         {
            return param1 + "c + " + param2;
         }
         if(param1 > 0)
         {
            return param1.toString();
         }
         return Math.max(0,param2).toString();
      }
      
      private function getPriceIconStyle(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:int = param2 > 0 ? param3 : 7;
         return ActivityPointTypeEnum.getIconStyleFor(_loc4_,UnknownVarFromHabbiconRewardPanelView_HabbiconController_1.configuration,false);
      }
      
      private function onClaimClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:HabbiconEntryModel = UnknownVarFromHabbiconRewardPanelView_HabbiconSetModel_1 != null ? UnknownVarFromHabbiconRewardPanelView_HabbiconSetModel_1.rewardHabbicon : null;
         if(isRewardClaimable(_loc2_))
         {
            UnknownVarFromHabbiconRewardPanelView_HabbiconController_1.claimHabbicon(_loc2_.habbiconId);
         }
      }
      
      private function onBuyClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:HabbiconEntryModel = UnknownVarFromHabbiconRewardPanelView_HabbiconSetModel_1 != null ? UnknownVarFromHabbiconRewardPanelView_HabbiconSetModel_1.rewardHabbicon : null;
         if(isRewardBuyable(UnknownVarFromHabbiconRewardPanelView_HabbiconSetModel_1,_loc2_))
         {
            UnknownVarFromHabbiconRewardPanelView_HabbiconController_1.openHabbiconSetPurchaseConfirmation(UnknownVarFromHabbiconRewardPanelView_HabbiconSetModel_1);
         }
      }
      
      private function onRewardTileClick(param1:WindowMouseEvent) : void
      {
         if(UnknownVarFromHabbiconRewardPanelView_Function_1 != null && rewardTile != null)
         {
            UnknownVarFromHabbiconRewardPanelView_Function_1(rewardTile);
         }
      }
      
      private function get rewardPanel() : IWindowController_1
      {
         return _window.findChildByName("reward_panel") as IWindowController_1;
      }
      
      private function get rewardTitle() : ITextWindow
      {
         return _window.findChildByName("reward_title") as ITextWindow;
      }
      
      private function get rewardHabbiconFrame() : IWindowModel
      {
         return _window.findChildByName("reward_habbicon_frame");
      }
      
      private function get rewardHabbicon() : IBitmapWrapperController
      {
         return _window.findChildByName("reward_habbicon") as IBitmapWrapperController;
      }
      
      private function get rewardDescription() : ITextWindow
      {
         return _window.findChildByName("reward_description") as ITextWindow;
      }
      
      private function get rewardActionButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("reward_action_button") as UnknownICoreWindowComponents4;
      }
      
      private function get rewardBuyContainer() : IWindowController_1
      {
         return _window.findChildByName("reward_buy_container") as IWindowController_1;
      }
      
      private function get rewardBuyPrice() : ITextWindow
      {
         return _window.findChildByName("reward_buy_price") as ITextWindow;
      }
      
      private function get rewardBuyCurrencyIcon() : IIconWindow
      {
         return _window.findChildByName("reward_buy_currency_icon") as IIconWindow;
      }
      
      private function get rewardBuyButton() : UnknownICoreWindowComponents4
      {
         return _window.findChildByName("reward_buy_button") as UnknownICoreWindowComponents4;
      }
   }
}

