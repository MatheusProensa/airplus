package com.sulake.habbo.roomevents.wired_trading.transactions.overview
{
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.transactions.WiredTransactionGetLogDetailsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.transactions.WiredTransactionInfo;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableCell;
   
   public class TransactionTableObject implements ITableObject
   {
      private var UnknownVarFromTransactionTableObject_WiredTransactionLogsController_1:WiredTransactionLogsController;
      
      private var _transactionInfo:WiredTransactionInfo;
      
      public function TransactionTableObject(param1:WiredTransactionLogsController, param2:WiredTransactionInfo)
      {
         super();
         UnknownVarFromTransactionTableObject_WiredTransactionLogsController_1 = param1;
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
            case "type":
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,localize("wired_transactions.type." + _transactionInfo.transactionType));
            case "timestamp":
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,_transactionInfo.readableTimestamp);
            case "username":
               return new TableCell(TableCell.UnknownVarFromTableCell_Int_1,_transactionInfo.userName,false,true,null,onClickUsername);
            case "deposits":
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,summarize(_transactionInfo.depositFurniCount,_transactionInfo.depositCoinsCount));
            case "withdraws":
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,summarize(_transactionInfo.withdrawFurniCount,_transactionInfo.withdrawCoinsCount));
            case "chests":
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,_transactionInfo.chestCount + "");
            case "details":
               return new TableCell(TableCell.UnknownVarFromTableCell_Int_1,localize("wiredchests.logs.details_text"),false,false,null,onClickDetails);
            default:
               return null;
         }
      }
      
      private function onClickUsername() : void
      {
         UnknownVarFromTransactionTableObject_WiredTransactionLogsController_1.send(new GetExtendedProfileMessageComposer(_transactionInfo.userId,true));
      }
      
      private function onClickDetails() : void
      {
         UnknownVarFromTransactionTableObject_WiredTransactionLogsController_1.send(new WiredTransactionGetLogDetailsMessageComposer(_transactionInfo.transactionId));
      }
      
      private function localize(param1:String) : String
      {
         return localization.getLocalization(param1);
      }
      
      private function summarize(param1:int, param2:int) : String
      {
         if(param1 <= 0 && param2 <= 0)
         {
            return "-";
         }
         if(param1 > 0 && param2 == 0)
         {
            return localization.getLocalizationWithParams("wiredchests.logs.only_furni","","amount",param1);
         }
         if(param1 == 0 && param2 > 0)
         {
            return localization.getLocalizationWithParams("wiredchests.logs.only_coins","","amount",param2);
         }
         return localization.getLocalizationWithParams("wiredchests.logs.furni_and_coins","","amount",param1,"amount2",param2);
      }
      
      private function get localization() : IHabboLocalizationManager
      {
         return UnknownVarFromTransactionTableObject_WiredTransactionLogsController_1.localizationManager;
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

