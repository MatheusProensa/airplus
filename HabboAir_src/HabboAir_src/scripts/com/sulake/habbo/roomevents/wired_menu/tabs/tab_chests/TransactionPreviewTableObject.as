package com.sulake.habbo.roomevents.wired_menu.tabs.tab_chests
{
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.transactions.WiredTransactionInfo;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableCell;
   
   public class TransactionPreviewTableObject implements ITableObject
   {
      private var _chestsTab:WiredMenuChestsTab;
      
      private var _transactionInfo:WiredTransactionInfo;
      
      public function TransactionPreviewTableObject(param1:WiredMenuChestsTab, param2:WiredTransactionInfo)
      {
         super();
         _chestsTab = param1;
         _transactionInfo = param2;
      }
      
      public function get identifier() : String
      {
         return _transactionInfo.transactionId + "";
      }
      
      public function getTableCell(param1:String) : TableCell
      {
         switch(param1)
         {
            case WiredMenuChestsTab.LOG_COLUMN_TYPE:
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,localize("transaction.type." + _transactionInfo.transactionType));
            case WiredMenuChestsTab.LOG_COLUMN_USERNAME:
               return new TableCell(TableCell.UnknownVarFromTableCell_Int_1,_transactionInfo.userName,false,true,null,onClickUsername);
            case WiredMenuChestsTab.UnknownConstFromWiredTransactionLogsView_String_1:
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,summarize(_transactionInfo.depositFurniCount,_transactionInfo.depositCoinsCount));
            case WiredMenuChestsTab.LOG_COLUMN_WITHDRAWS:
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,summarize(_transactionInfo.withdrawFurniCount,_transactionInfo.withdrawCoinsCount));
            default:
               return null;
         }
      }
      
      private function summarize(param1:int, param2:int) : String
      {
         if(param1 <= 0 && param2 <= 0)
         {
            return "-";
         }
         if(param1 > 0 && param2 == 0)
         {
            return localization.getLocalizationWithParams("wiredmenu.chests.room_logs.only_furni","","amount",param1);
         }
         if(param1 == 0 && param2 > 0)
         {
            return localization.getLocalizationWithParams("wiredmenu.chests.room_logs.only_coins","","amount",param2);
         }
         return localization.getLocalizationWithParams("wiredmenu.chests.room_logs.furni_and_coins","","amount",param1,"amount2",param2);
      }
      
      private function onClickUsername() : void
      {
         _chestsTab.controller.send(new GetExtendedProfileMessageComposer(_transactionInfo.userId,true));
      }
      
      private function localize(param1:String) : String
      {
         return _chestsTab.controller.localizationManager.getLocalization("wiredmenu.chests." + param1);
      }
      
      private function get localization() : IHabboLocalizationManager
      {
         return _chestsTab.controller.localizationManager;
      }
      
      public function isPropertyUpdated(param1:String, param2:Object) : Boolean
      {
         return false;
      }
      
      public function isUpdated(param1:Object) : Boolean
      {
         return false;
      }
   }
}

