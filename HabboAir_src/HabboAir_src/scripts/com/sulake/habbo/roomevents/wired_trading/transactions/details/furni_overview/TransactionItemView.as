package com.sulake.habbo.roomevents.wired_trading.transactions.details.furni_overview
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage.ChestItemType;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage.IChestStorage;
   import com.sulake.habbo.roomevents.wired_trading.chests.subcontrollers.views.FurniChestItemView;
   import com.sulake.habbo.roomevents.wired_trading.chests.subcontrollers.views.FurniChestView;
   import com.sulake.habbo.roomevents.wired_trading.chests.subcontrollers.views.IFurniChestItemView;
   import com.sulake.habbo.roomevents.wired_trading.transactions.details.WiredTransactionDetailsController;
   
   public class TransactionItemView implements IComponentInterfaceQueue, IFurniChestItemView
   {
      public static const TYPE_FURNI:int = 0;
      
      public static const UnknownConstFromTransactionItemView_Int_1:int = 1;
      
      public static const TYPE_INCOMPLETE_DATA:int = 2;
      
      private var _disposed:Boolean;
      
      private var UnknownVarFromTransactionItemView_WiredTransactionDetailsController_1:WiredTransactionDetailsController;
      
      private var _count:int;
      
      private var UnknownVarFromTransactionItemView_Int_1:int;
      
      private var UnknownVarFromTransactionItemView_ChestItemType_1:ChestItemType;
      
      private var _chestBasedItemSample:IChestStorage;
      
      private var UnknownVarFromTransactionItemView_Boolean_1:Boolean = false;
      
      private var _window:IRegionWindow;
      
      public function TransactionItemView(param1:IRegionWindow, param2:WiredTransactionDetailsController)
      {
         super();
         _window = param1.clone() as IRegionWindow;
         UnknownVarFromTransactionItemView_WiredTransactionDetailsController_1 = param2;
         _window.addEventListener("WME_OVER",onOver);
         _window.addEventListener("WME_OUT",onOut);
      }
      
      public function get window() : IRegionWindow
      {
         return _window;
      }
      
      public function initialize(param1:int, param2:int, param3:ChestItemType) : void
      {
         _count = param1;
         UnknownVarFromTransactionItemView_Int_1 = param2;
         UnknownVarFromTransactionItemView_ChestItemType_1 = param3;
         if(param3 == null)
         {
            _chestBasedItemSample = null;
         }
         else
         {
            _chestBasedItemSample = new TransactionChestItemWrapper(param3);
         }
         var _loc4_:String = "";
         if(UnknownVarFromTransactionItemView_Int_1 == 0)
         {
            _loc4_ = FurniChestView.getChestBasedItemName(_chestBasedItemSample,UnknownVarFromTransactionItemView_WiredTransactionDetailsController_1.localizationManager,UnknownVarFromTransactionItemView_WiredTransactionDetailsController_1.sessionDataManager);
         }
         else if(UnknownVarFromTransactionItemView_Int_1 == 1)
         {
            _loc4_ = "${wiredcontracts.element.type.0}";
         }
         else if(UnknownVarFromTransactionItemView_Int_1 == 2)
         {
            _loc4_ = "${wiredchests.log_details.incomplete_data}";
         }
         _window.toolTipCaption = _loc4_;
         initializeUI();
      }
      
      public function get numItems() : int
      {
         return _count;
      }
      
      private function initializeUI() : void
      {
         FurniChestItemView.initChestBasedIconUI(this,_chestBasedItemSample);
         coinsIcon.visible = UnknownVarFromTransactionItemView_Int_1 == 1;
         incompleteText.visible = UnknownVarFromTransactionItemView_Int_1 == 2;
         updateUI();
         updateColoring();
      }
      
      public function updateUI() : void
      {
         if(UnknownVarFromTransactionItemView_Int_1 == 2)
         {
            numberContainer.visible = false;
            incompleteText.fontSize = numItems >= 1000 ? 12 : 16;
            incompleteText.text = "+" + numItems;
         }
         else if(numItems > 1)
         {
            numberContainer.visible = true;
            furniQuantity.text = String(numItems);
         }
         else
         {
            numberContainer.visible = false;
         }
      }
      
      public function updateColoring() : void
      {
         focusOutline.visible = false;
         border.color = UnknownVarFromTransactionItemView_Boolean_1 ? FurniChestItemView.UnknownVarFromFurniChestItemView_Uint_1 : FurniChestItemView.NOT_HOVERED_COLOR;
      }
      
      private function onOut(param1:WindowMouseEvent) : void
      {
         UnknownVarFromTransactionItemView_Boolean_1 = false;
         updateColoring();
      }
      
      private function onOver(param1:WindowMouseEvent) : void
      {
         UnknownVarFromTransactionItemView_Boolean_1 = true;
         updateColoring();
      }
      
      public function recycle() : void
      {
         UnknownVarFromTransactionItemView_Boolean_1 = false;
         _count = 0;
         UnknownVarFromTransactionItemView_ChestItemType_1 = null;
      }
      
      public function get chestBasedItemSample() : IChestStorage
      {
         return _chestBasedItemSample;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _window.dispose();
         _window = null;
         UnknownVarFromTransactionItemView_Boolean_1 = false;
         _count = null;
         UnknownVarFromTransactionItemView_ChestItemType_1 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get border() : UnknownICoreWindowComponents6
      {
         return _window.findChildByName("border") as UnknownICoreWindowComponents6;
      }
      
      private function get focusOutline() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("outline_focus") as IStaticBitmapWrapperWindow;
      }
      
      public function get ltdBackgroundBitmap() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("unique_item_background_bitmap") as IStaticBitmapWrapperWindow;
      }
      
      public function get coinsIcon() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("coins_icon") as IStaticBitmapWrapperWindow;
      }
      
      public function get incompleteText() : ITextWindow
      {
         return _window.findChildByName("incomplete_text") as ITextWindow;
      }
      
      public function get furniIcon() : IWidgetWindowController
      {
         return _window.findChildByName("furni_icon") as IWidgetWindowController;
      }
      
      private function get numberContainer() : IWindowController_1
      {
         return _window.findChildByName("number_container") as IWindowController_1;
      }
      
      private function get furniQuantity() : ITextWindow
      {
         return _window.findChildByName("furni_quantity") as ITextWindow;
      }
      
      public function get ltdOverlayWidget() : IWidgetWindowController
      {
         return _window.findChildByName("unique_item_overlay_container") as IWidgetWindowController;
      }
      
      public function get rarityOverlayWidget() : IWidgetWindowController
      {
         return _window.findChildByName("rarity_item_overlay_container") as IWidgetWindowController;
      }
   }
}

