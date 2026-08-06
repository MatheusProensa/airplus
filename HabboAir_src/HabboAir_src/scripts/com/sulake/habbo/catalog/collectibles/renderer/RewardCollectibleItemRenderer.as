package com.sulake.habbo.catalog.collectibles.renderer
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.collectibles.CollectiblesController;
   import com.sulake.habbo.catalog.collectibles.renderer.model.BaseItemWrapper;
   import com.sulake.habbo.catalog.collectibles.tabs.RewardClaimsTab;
   import com.sulake.habbo.communication.messages.parser.collectibles.CollectibleBaseItem;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftClaim;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   
   public class RewardCollectibleItemRenderer extends AbstractCollectibleItemRenderer
   {
      protected var UnknownVarFromRewardCollectibleItemRenderer_RewardClaimsTab_1:RewardClaimsTab;
      
      protected var _rewardClaim:NftClaim;
      
      private var UnknownVarFromRewardCollectibleItemRenderer_BaseItemWrapper_1:BaseItemWrapper;
      
      public function RewardCollectibleItemRenderer(param1:CollectiblesController, param2:NftClaim, param3:IWindowController_1, param4:RewardClaimsTab)
      {
         UnknownVarFromRewardCollectibleItemRenderer_RewardClaimsTab_1 = param4;
         _rewardClaim = param2;
         UnknownVarFromRewardCollectibleItemRenderer_BaseItemWrapper_1 = new BaseItemWrapper(param2.claimItem);
         super(param1,UnknownVarFromRewardCollectibleItemRenderer_BaseItemWrapper_1,param3);
      }
      
      override protected function onClick(param1:WindowMouseEvent) : void
      {
      }
      
      override public function updateVisuals() : void
      {
         nameText.caption = UnknownVarFromAbstractCollectibleItemRenderer_CollectiblesController_1.getProductName(UnknownVarFromRewardCollectibleItemRenderer_BaseItemWrapper_1);
         amountText.caption = "x" + (_rewardClaim.claimLimit - _rewardClaim.claimedAmount);
         collectionText.caption = "<b>" + localization.getLocalization("collectibles.claim.collection") + "</b> " + collectionName;
         walletText.caption = _rewardClaim.wallet;
      }
      
      public function updateExpiresText(param1:String) : void
      {
         expiresText.caption = "<b>" + localization.getLocalization("collectibles.claim.expiration") + "</b> " + param1;
      }
      
      public function get item() : CollectibleBaseItem
      {
         return (renderableItem as BaseItemWrapper).baseItem;
      }
      
      public function get rewardClaim() : NftClaim
      {
         return _rewardClaim;
      }
      
      override protected function get borderOutline() : UnknownICoreWindowComponents6
      {
         return container.findChildByName("border_outline") as UnknownICoreWindowComponents6;
      }
      
      override protected function get borderBackground() : UnknownICoreWindowComponents6
      {
         return container.findChildByName("border_background") as UnknownICoreWindowComponents6;
      }
      
      override protected function get amountText() : ITextWindow
      {
         return container.findChildByTag("AMOUNT_TITLE") as ITextWindow;
      }
      
      override protected function get amountTextBorder() : UnknownICoreWindowComponents6
      {
         return container.findChildByName("text_border") as UnknownICoreWindowComponents6;
      }
      
      override protected function get bitmapWindow() : IBitmapWrapperController
      {
         return container.findChildByTag("BITMAP") as IBitmapWrapperController;
      }
      
      override protected function get unknownImageWindow() : IStaticBitmapWrapperWindow
      {
         return container.findChildByName("unknown_image") as IStaticBitmapWrapperWindow;
      }
      
      override protected function get badgeImageWindow() : IWidgetWindowController
      {
         return container.findChildByName("badge_image_widget") as IWidgetWindowController;
      }
      
      override protected function get petImageWindow() : IWidgetWindowController
      {
         return container.findChildByName("pet_image_widget") as IWidgetWindowController;
      }
      
      private function get nameText() : ITextWindow
      {
         return container.findChildByTag("NAME_TITLE") as ITextWindow;
      }
      
      private function get walletText() : ITextWindow
      {
         return container.findChildByName("wallet_text") as ITextWindow;
      }
      
      private function get collectionText() : ITextWindow
      {
         return container.findChildByName("collection_text") as ITextWindow;
      }
      
      private function get expiresText() : ITextWindow
      {
         return container.findChildByName("expires_text") as ITextWindow;
      }
      
      private function get localization() : IHabboLocalizationManager
      {
         return UnknownVarFromAbstractCollectibleItemRenderer_CollectiblesController_1.localizationManager;
      }
      
      private function get collectionName() : String
      {
         var _loc1_:String = localization.getLocalization("collectibles.set." + _rewardClaim.claimItem.setId);
         return _loc1_;
      }
   }
}

