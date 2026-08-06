package com.sulake.habbo.roomevents.wired_menu.tabs.tab_chests
{
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils2;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredtrading.transactions.WiredTransactionLogListMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.chests.LockAllChestsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.transactions.WiredTransactionGetRoomLogsMessageComposer;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.transactions.WiredTransactionInfo;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.transactions.WiredTransactionLogList;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   import com.sulake.habbo.roomevents.wired_menu.tabs.WiredMenuDefaultTab;
   import com.sulake.habbo.roomevents.wired_trading.transactions.overview.TransactionConfig;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableColumn;
   import com.sulake.habbo.window.utils.tableview.TableView;
   import flash.utils.getTimer;
   
   public class WiredMenuChestsTab extends WiredMenuDefaultTab implements IProfiler_1
   {
      private static var POLL_PREVIEW_MS:uint = 20000;
      
      private static var UnknownVarFromWiredMenuChestsTab_Uint_1:uint = 500;
      
      public static var LOG_COLUMN_TYPE:String = "type";
      
      public static var LOG_COLUMN_USERNAME:String = "username";
      
      public static var LOG_COLUMN_WITHDRAWS:String = "withdraws";
      
      public static var UnknownConstFromWiredTransactionLogsView_String_1:String = "deposits";
      
      public static var TRANSACTIONS_PREVIEW_AMOUNT:int = 10;
      
      public static var TRANSACTIONS_FIRST_PAGE:int = 1;
      
      private var UnknownVarFromWiredMenuChestsTab_TableView_1:TableView;
      
      private var UnknownVarFromWiredMenuChestsTab_Int_1:int = 0;
      
      private var UnknownVarFromWiredMenuChestsTab_Boolean_1:Boolean = false;
      
      private var UnknownVarFromWiredMenuChestsTab_Int_2:int = 0;
      
      private var UnknownVarFromWiredMenuChestsTab_Vector_1:Vector.<WiredTransactionInfo> = null;
      
      public function WiredMenuChestsTab(param1:WiredMenuController, param2:IWindowController_1)
      {
         super(param1,param2);
         createTransactionTable();
         addMessageEvent(new WiredTransactionLogListMessageEvent(onLogListResults));
         lockYourChestsButton.addEventListener("WME_CLICK",onLockChestsClick);
         unlockYourChestsButton.addEventListener("WME_CLICK",onUnlockChestsClick);
         lockAllChestsButton.addEventListener("WME_CLICK",onLockAllChestsClick);
         viewInDetailButton.addEventListener("WME_CLICK",onViewInDetailClick);
      }
      
      private function onLogListResults(param1:WiredTransactionLogListMessageEvent) : void
      {
         var _loc2_:WiredTransactionLogList = param1.getParser().logs;
         if(_loc2_.amount == TRANSACTIONS_PREVIEW_AMOUNT && _loc2_.currentPage == TRANSACTIONS_FIRST_PAGE && _loc2_.logListType == WiredTransactionLogList.UnknownVarFromWiredTransactionLogList_Int_2)
         {
            UnknownVarFromWiredMenuChestsTab_Vector_1 = _loc2_.logs;
            if(isLoading)
            {
               updateLoadingState();
            }
            else
            {
               updateTransactionLogsUI();
            }
         }
      }
      
      private function createTransactionTable() : void
      {
         UnknownVarFromWiredMenuChestsTab_TableView_1 = new TableView(controller.windowManager,transactionsTableViewContainer);
         var _loc1_:Array = [new TableColumn(LOG_COLUMN_TYPE,loc("wiredmenu.chests.room_logs.column.type"),0.28),new TableColumn(LOG_COLUMN_USERNAME,loc("wiredmenu.chests.room_logs.column.username"),0.24),new TableColumn(LOG_COLUMN_WITHDRAWS,loc("wiredmenu.chests.room_logs.column.withdraws"),0.24),new TableColumn(UnknownConstFromWiredTransactionLogsView_String_1,loc("wiredmenu.chests.room_logs.column.deposits"),0.24)];
         UnknownVarFromWiredMenuChestsTab_TableView_1.initialize(Vector.<TableColumn>(_loc1_));
      }
      
      override public function startViewing() : void
      {
         super.startViewing();
         clearData();
         updateLoadingState();
         requestData();
      }
      
      private function clearData() : void
      {
         UnknownVarFromWiredMenuChestsTab_Vector_1 = null;
      }
      
      override protected function isDataReady() : Boolean
      {
         return UnknownVarFromWiredMenuChestsTab_Vector_1 != null;
      }
      
      override protected function initializeInterface() : void
      {
         updateTransactionLogsUI();
         updateButtonsUI();
      }
      
      override public function permissionsUpdated() : void
      {
         updateButtonsUI();
      }
      
      private function updateButtonsUI() : void
      {
         Util.disableSection(lockYourChestsButton,!controller.hasWritePermission || UnknownVarFromWiredMenuChestsTab_Boolean_1);
         Util.disableSection(unlockYourChestsButton,!controller.hasWritePermission || UnknownVarFromWiredMenuChestsTab_Boolean_1);
         Util.disableSection(lockAllChestsButton,!controller.isRoomOwnerOrStaff() || UnknownVarFromWiredMenuChestsTab_Boolean_1);
      }
      
      private function updateTransactionLogsUI() : void
      {
         Util.disableSection(transactionsTableViewContainer,UnknownVarFromWiredMenuChestsTab_Vector_1.length == 0);
         var _loc1_:Vector.<ITableObject> = new Vector.<ITableObject>();
         for each(var _loc2_ in UnknownVarFromWiredMenuChestsTab_Vector_1)
         {
            _loc1_.push(new TransactionPreviewTableObject(this,_loc2_));
         }
         UnknownVarFromWiredMenuChestsTab_TableView_1.setObjects(_loc1_);
      }
      
      private function requestData() : void
      {
         UnknownVarFromWiredMenuChestsTab_Int_2 = getTimer();
         controller.send(new WiredTransactionGetRoomLogsMessageComposer(TRANSACTIONS_PREVIEW_AMOUNT,TRANSACTIONS_FIRST_PAGE));
      }
      
      private function onLockChestsClick(param1:WindowMouseEvent) : void
      {
         controller.send(new LockAllChestsMessageComposer(true,false));
         startLockTimeout();
      }
      
      private function onUnlockChestsClick(param1:WindowMouseEvent) : void
      {
         controller.send(new LockAllChestsMessageComposer(false,false));
         startLockTimeout();
      }
      
      private function onLockAllChestsClick(param1:WindowMouseEvent) : void
      {
         controller.roomEvents.windowManager.confirm("${wiredmenu.chests.chest_control.lock_all.warning.title}","${wiredmenu.chests.chest_control.lock_all.warning.desc}",0,onConfirmLockAllChest);
      }
      
      private function onConfirmLockAllChest(param1:UnknownICoreWindowUtils2, param2:WindowEvent) : void
      {
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            controller.send(new LockAllChestsMessageComposer(true,true));
            startLockTimeout();
         }
      }
      
      private function startLockTimeout() : void
      {
         UnknownVarFromWiredMenuChestsTab_Boolean_1 = true;
         UnknownVarFromWiredMenuChestsTab_Int_1 = getTimer();
         if(!isLoading)
         {
            updateButtonsUI();
         }
      }
      
      private function onViewInDetailClick(param1:WindowMouseEvent) : void
      {
         controller.send(new WiredTransactionGetRoomLogsMessageComposer(TransactionConfig.PAGE_SIZE,1));
      }
      
      public function update(param1:uint) : void
      {
         if(!isViewing)
         {
            return;
         }
         var _loc2_:int = getTimer();
         if(UnknownVarFromWiredMenuChestsTab_Int_2 < _loc2_ - POLL_PREVIEW_MS)
         {
            requestData();
         }
         if(!isLoading && UnknownVarFromWiredMenuChestsTab_Boolean_1 && UnknownVarFromWiredMenuChestsTab_Int_1 < _loc2_ - UnknownVarFromWiredMenuChestsTab_Uint_1)
         {
            UnknownVarFromWiredMenuChestsTab_Boolean_1 = false;
            updateButtonsUI();
         }
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         UnknownVarFromWiredMenuChestsTab_TableView_1.dispose();
         UnknownVarFromWiredMenuChestsTab_TableView_1 = null;
         UnknownVarFromWiredMenuChestsTab_Vector_1 = null;
         super.dispose();
      }
      
      private function get lockYourChestsButton() : UnknownICoreWindowComponents4
      {
         return container.findChildByName("lock_own_button") as UnknownICoreWindowComponents4;
      }
      
      private function get unlockYourChestsButton() : UnknownICoreWindowComponents4
      {
         return container.findChildByName("unlock_own_button") as UnknownICoreWindowComponents4;
      }
      
      private function get lockAllChestsButton() : UnknownICoreWindowComponents4
      {
         return container.findChildByName("lock_all_button") as UnknownICoreWindowComponents4;
      }
      
      private function get transactionsTableViewContainer() : IWindowController_1
      {
         return container.findChildByName("logs_table_container") as IWindowController_1;
      }
      
      private function get viewInDetailButton() : UnknownICoreWindowComponents4
      {
         return container.findChildByName("view_in_detail_button") as UnknownICoreWindowComponents4;
      }
   }
}

