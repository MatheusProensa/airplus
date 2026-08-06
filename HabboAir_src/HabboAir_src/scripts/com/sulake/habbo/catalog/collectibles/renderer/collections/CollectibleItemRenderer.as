package com.sulake.habbo.catalog.collectibles.renderer.collections
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.collectibles.CollectiblesController;
   import com.sulake.habbo.catalog.collectibles.renderer.AbstractCollectibleItemRenderer;
   import com.sulake.habbo.catalog.collectibles.renderer.model.CollectionItemWrapper;
   import com.sulake.habbo.catalog.collectibles.tabs.subviews.CollectionView;
   import com.sulake.habbo.communication.messages.parser.collectibles.CollectibleItem;
   
   public class CollectibleItemRenderer extends AbstractCollectibleItemRenderer
   {
      protected var UnknownVarFromCollectibleItemRenderer_CollectionView_1:CollectionView;
      
      public function CollectibleItemRenderer(param1:CollectiblesController, param2:CollectibleItem, param3:IWindowController_1, param4:CollectionView)
      {
         super(param1,new CollectionItemWrapper(param2),param3);
         UnknownVarFromCollectibleItemRenderer_CollectionView_1 = param4;
      }
      
      override protected function onClick(param1:WindowMouseEvent) : void
      {
         UnknownVarFromCollectibleItemRenderer_CollectionView_1.selectItem(this);
      }
      
      override public function updateVisuals() : void
      {
         amountText.caption = "x" + item.amount;
         amountTextBorder.color = isComplete ? 3374080 : 7441834;
         checkmarkIcon.visible = isComplete;
      }
      
      public function get item() : CollectibleItem
      {
         return (renderableItem as CollectionItemWrapper).collectionItem;
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

