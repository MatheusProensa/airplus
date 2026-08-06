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
   import com.sulake.habbo.catalog.collectibles.renderer.model.MintableItemWrapper;
   import com.sulake.habbo.catalog.collectibles.tabs.MintInventoryListTab;
   import com.sulake.habbo.communication.messages.parser.collectibles.CollectiblesProductItem;
   
   public class MintInventoryItemRenderer extends AbstractCollectibleItemRenderer
   {
      protected var UnknownVarFromMintInventoryItemRenderer_MintInventoryListTab_1:MintInventoryListTab;
      
      public function MintInventoryItemRenderer(param1:CollectiblesController, param2:CollectiblesProductItem, param3:IWindowController_1, param4:MintInventoryListTab, param5:int)
      {
         super(param1,new MintableItemWrapper(param2,param5),param3);
         UnknownVarFromMintInventoryItemRenderer_MintInventoryListTab_1 = param4;
      }
      
      override protected function onClick(param1:WindowMouseEvent) : void
      {
         UnknownVarFromMintInventoryItemRenderer_MintInventoryListTab_1.selectItem(this);
      }
      
      override public function updateVisuals() : void
      {
         amountText.caption = isComplete ? "x" + renderableItem.amount : "-";
         amountTextBorder.color = isComplete ? 3374080 : 7441834;
      }
      
      public function get item() : CollectiblesProductItem
      {
         return (renderableItem as MintableItemWrapper).productItem;
      }
      
      override protected function completeColoring() : Object
      {
         return incompleteColoring();
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

