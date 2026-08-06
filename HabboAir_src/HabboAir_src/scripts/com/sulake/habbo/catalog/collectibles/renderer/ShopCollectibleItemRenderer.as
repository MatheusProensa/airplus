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
   import com.sulake.habbo.catalog.collectibles.tabs.ShopTab;
   import com.sulake.habbo.communication.messages.parser.collectibles.CollectibleBaseItem;
   import com.sulake.habbo.communication.messages.parser.collectibles.NftStoreOffer;
   
   public class ShopCollectibleItemRenderer extends AbstractCollectibleItemRenderer
   {
      protected var UnknownVarFromShopCollectibleItemRenderer_ShopTab_1:ShopTab;
      
      protected var _offer:NftStoreOffer;
      
      public function ShopCollectibleItemRenderer(param1:CollectiblesController, param2:NftStoreOffer, param3:IWindowController_1, param4:ShopTab)
      {
         UnknownVarFromShopCollectibleItemRenderer_ShopTab_1 = param4;
         _offer = param2;
         super(param1,new BaseItemWrapper(param2.productInfo),param3);
      }
      
      override protected function onClick(param1:WindowMouseEvent) : void
      {
         UnknownVarFromShopCollectibleItemRenderer_ShopTab_1.selectItem(this);
      }
      
      override public function updateVisuals() : void
      {
         amountText.caption = _offer.emeraldPrice.toString();
      }
      
      public function get item() : CollectibleBaseItem
      {
         return (renderableItem as BaseItemWrapper).baseItem;
      }
      
      public function get offer() : NftStoreOffer
      {
         return _offer;
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
         return container.findChildByName("number") as ITextWindow;
      }
      
      override protected function get amountTextBorder() : UnknownICoreWindowComponents6
      {
         return container.findChildByName("text_border") as UnknownICoreWindowComponents6;
      }
      
      private function get checkmarkIcon() : IStaticBitmapWrapperWindow
      {
         return container.findChildByName("checkmark_icon") as IStaticBitmapWrapperWindow;
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
   }
}

