package com.sulake.habbo.roomevents.wired_trading.transactions.details
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBubbleController;
   import com.sulake.core.window.components.IDesktopController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.transactions.WiredTransactionDetails;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.transactions.WiredTransactionInfo;
   import com.sulake.habbo.roomevents.wired_trading.chests.WiredChestWrapperView;
   import com.sulake.habbo.roomevents.wired_trading.transactions.details.furni_overview.TransactionOverviewView;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class WiredTransactionDetailsView implements IComponentInterfaceQueue
   {
      private static const PROPERTY_TRANSACTION_TYPE:String = "transaction_type";
      
      private static const PROPERTY_TIMESTAMP:String = "timestamp";
      
      private static const PROPERTY_ROOM_ID:String = "room_id";
      
      private static const PROPERTY_CHEST_IDS:String = "chest_ids";
      
      private static const PROPERTY_USERNAME:String = "username";
      
      private static const PROPERTY_FURNI_TRANSACTIONS:String = "furni_transactions";
      
      private static const PROPERTY_EXTRA:String = "extra";
      
      public static const DESKTOP_WINDOW_LAYER:uint = 1;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromWiredTransactionDetailsView_WiredTransactionDetailsController_1:WiredTransactionDetailsController;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var UnknownVarFromWiredTransactionDetailsView_TransactionOverviewView_1:TransactionOverviewView;
      
      private var UnknownVarFromWiredTransactionDetailsView_TransactionOverviewView_2:TransactionOverviewView;
      
      private var _window:IFrameController;
      
      private var UnknownVarFromWiredTransactionDetailsView_IBubbleController_1:IBubbleController;
      
      public function WiredTransactionDetailsView(param1:WiredTransactionDetailsController, param2:IHabboWindowManagerComponent)
      {
         super();
         UnknownVarFromWiredTransactionDetailsView_WiredTransactionDetailsController_1 = param1;
         _windowManager = param2;
         _window = _windowManager.buildFromXML(XML(UnknownVarFromWiredTransactionDetailsView_WiredTransactionDetailsController_1.assets.getAssetByName("transaction_details_xml").content),1) as IFrameController;
         closeButton.addEventListener("WME_CLICK",onClose);
         extraInfoButton.addEventListener("WME_CLICK",onExtraButtonClick);
         UnknownVarFromWiredTransactionDetailsView_TransactionOverviewView_1 = new TransactionOverviewView(param1,withdrawalsContainer);
         UnknownVarFromWiredTransactionDetailsView_TransactionOverviewView_2 = new TransactionOverviewView(param1,depositsContainer);
         UnknownVarFromWiredTransactionDetailsView_IBubbleController_1 = _window.findChildByName("extra_info_bubble") as IBubbleController;
         _window.desktop.addChild(UnknownVarFromWiredTransactionDetailsView_IBubbleController_1);
         UnknownVarFromWiredTransactionDetailsView_IBubbleController_1.visible = false;
         UnknownVarFromWiredTransactionDetailsView_IBubbleController_1.addEventListener("WE_DEACTIVATED",onExtraInfoBubbleDeactivates);
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         hide();
      }
      
      public function hide() : void
      {
         var _loc1_:IDesktopController = null;
         if(isShowing())
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
            clear();
         }
      }
      
      public function show() : void
      {
         var _loc1_:IDesktopController = null;
         if(!isShowing())
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(_window);
               _window.center();
            }
         }
      }
      
      public function clear() : void
      {
         UnknownVarFromWiredTransactionDetailsView_IBubbleController_1.visible = false;
         UnknownVarFromWiredTransactionDetailsView_TransactionOverviewView_1.clear();
         UnknownVarFromWiredTransactionDetailsView_TransactionOverviewView_2.clear();
      }
      
      public function isShowing() : Boolean
      {
         return _window.parent != null;
      }
      
      public function updateUI() : void
      {
         if(UnknownVarFromWiredTransactionDetailsView_WiredTransactionDetailsController_1.details == null)
         {
            return;
         }
         var _loc1_:WiredTransactionDetails = UnknownVarFromWiredTransactionDetailsView_WiredTransactionDetailsController_1.details;
         var _loc2_:WiredTransactionInfo = _loc1_.transactionInfo;
         getValueWindow("transaction_type").text = loc("wired_transactions.type." + _loc2_.transactionType);
         getValueWindow("timestamp").text = _loc2_.readableTimestamp;
         getValueWindow("room_id").text = String(_loc2_.flatId);
         getValueWindow("chest_ids").text = _loc1_.chestIds.join(", ");
         getValueWindow("username").text = _loc2_.userName;
         getValueWindow("extra").text = _loc2_.transactionDefinitionInfo == "" ? "-" : _loc2_.transactionDefinitionInfo;
         UnknownVarFromWiredTransactionDetailsView_TransactionOverviewView_1.itemsInitialize(_loc2_.withdrawCoinsCount,_loc1_.withdrawnFurnis,_loc2_.withdrawFurniCount,_loc1_.isIncompleteData);
         UnknownVarFromWiredTransactionDetailsView_TransactionOverviewView_2.itemsInitialize(_loc2_.depositCoinsCount,_loc1_.depositedFurnis,_loc2_.depositFurniCount,_loc1_.isIncompleteData);
         UnknownVarFromWiredTransactionDetailsView_IBubbleController_1.visible = false;
         _window.activate();
      }
      
      public function loc(param1:String) : String
      {
         return UnknownVarFromWiredTransactionDetailsView_WiredTransactionDetailsController_1.localizationManager.getLocalization(param1,param1);
      }
      
      private function onExtraInfoBubbleDeactivates(param1:WindowEvent) : void
      {
         UnknownVarFromWiredTransactionDetailsView_IBubbleController_1.visible = false;
      }
      
      private function onExtraButtonClick(param1:WindowMouseEvent) : void
      {
         UnknownVarFromWiredTransactionDetailsView_IBubbleController_1.visible = true;
         WiredChestWrapperView.relocateBubbleFocus(UnknownVarFromWiredTransactionDetailsView_IBubbleController_1,extraInfoButton);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         UnknownVarFromWiredTransactionDetailsView_IBubbleController_1.dispose();
         UnknownVarFromWiredTransactionDetailsView_IBubbleController_1 = null;
         UnknownVarFromWiredTransactionDetailsView_TransactionOverviewView_1.dispose();
         UnknownVarFromWiredTransactionDetailsView_TransactionOverviewView_2.dispose();
         UnknownVarFromWiredTransactionDetailsView_TransactionOverviewView_1 = null;
         UnknownVarFromWiredTransactionDetailsView_TransactionOverviewView_2 = null;
         _window.dispose();
         _window = null;
         UnknownVarFromWiredTransactionDetailsView_WiredTransactionDetailsController_1 = null;
         _windowManager = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get closeButton() : IWindowModel
      {
         return _window.findChildByName("header_button_close");
      }
      
      private function getPairWindow(param1:String) : IItemListWindow
      {
         return _window.findChildByName(param1 + "_pair") as IItemListWindow;
      }
      
      private function getKeyWindow(param1:String) : ITextWindow
      {
         return getPairWindow(param1).getListItemAt(0) as ITextWindow;
      }
      
      private function getValueWindow(param1:String) : ITextWindow
      {
         return getPairWindow(param1).getListItemAt(1) as ITextWindow;
      }
      
      private function getIconWindow(param1:String) : IIconWindow
      {
         return getPairWindow(param1).getListItemAt(2) as IIconWindow;
      }
      
      private function get withdrawalsContainer() : IWindowController_1
      {
         return _window.findChildByName("withdrawals_container") as IWindowController_1;
      }
      
      private function get depositsContainer() : IWindowController_1
      {
         return _window.findChildByName("deposits_container") as IWindowController_1;
      }
      
      private function get extraInfoButton() : IRegionWindow
      {
         return _window.findChildByName("extra_info_button") as IRegionWindow;
      }
   }
}

