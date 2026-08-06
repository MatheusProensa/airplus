package com.sulake.habbo.roomevents.wired_trading.chests.subcontrollers.views
{
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage.IChestStorage;
   
   public interface IFurniChestItemView
   {
      function get ltdBackgroundBitmap() : IStaticBitmapWrapperWindow;
      
      function get furniIcon() : IWidgetWindowController;
      
      function get ltdOverlayWidget() : IWidgetWindowController;
      
      function get rarityOverlayWidget() : IWidgetWindowController;
      
      function get chestBasedItemSample() : IChestStorage;
   }
}

