package com.sulake.habbo.help.reportstatus
{
   import com.sulake.habbo.communication.messages.incoming.callforhelp.CfhReportMessage;
   import com.sulake.habbo.help.MyReportStatus;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableCell;
   import flash.globalization.DateTimeFormatter;
   
   public class ReportStatusTableObject implements ITableObject
   {
      private var _myReportStatus:MyReportStatus;
      
      private var _message:CfhReportMessage;
      
      private var UnknownVarFromReportStatusTableObject_DateTimeFormatter_1:DateTimeFormatter;
      
      private var UnknownVarFromReportStatusTableObject_Object_1:Object;
      
      public function ReportStatusTableObject(param1:MyReportStatus, param2:CfhReportMessage)
      {
         super();
         _myReportStatus = param1;
         _message = param2;
         UnknownVarFromReportStatusTableObject_DateTimeFormatter_1 = new DateTimeFormatter("i-default");
         UnknownVarFromReportStatusTableObject_DateTimeFormatter_1.setDateTimePattern("dd/MM/yyyy");
         UnknownVarFromReportStatusTableObject_Object_1 = getReportedUserDeleted(_message.reportedAccountName);
      }
      
      public function get identifier() : String
      {
         return String(_message.id);
      }
      
      public function isPropertyUpdated(param1:String, param2:Object) : Boolean
      {
         return true;
      }
      
      public function isUpdated(param1:Object) : Boolean
      {
         return true;
      }
      
      public function getTableCell(param1:String) : TableCell
      {
         var _loc2_:String = null;
         var _loc3_:TableCell = null;
         switch(param1)
         {
            case MyReportStatus.COLUMN_REPORT_DATE:
               _loc2_ = UnknownVarFromReportStatusTableObject_DateTimeFormatter_1.format(new Date(_message.creationTime));
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,_loc2_);
            case MyReportStatus.COLUMN_REPORTED_ACCOUNT:
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,UnknownVarFromReportStatusTableObject_Object_1.userName,false,false,null,null,false,null,UnknownVarFromReportStatusTableObject_Object_1.textColor);
            case MyReportStatus.COLUMN_REASON:
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,_myReportStatus.localize("help.cfh.topic." + _message.userCategory));
            case MyReportStatus.COLUMN_APPEAL_STATUS:
               _loc3_ = new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,statusText);
               if(!UnknownVarFromReportStatusTableObject_Object_1.deleted)
               {
                  _loc3_.setExtraBtn("icons_info_grey",onExtraClick);
               }
               return _loc3_;
            default:
               return null;
         }
      }
      
      private function onExtraClick() : void
      {
         _myReportStatus.clickInfoButton(this);
      }
      
      private function get statusText() : String
      {
         if(_message.appealStatus == CfhReportMessage.UnknownConstFromHabboGroupDetailsData_Int_5)
         {
            return _myReportStatus.localize("report.status.state.appealed");
         }
         if(_message.closeTime != -1)
         {
            return _myReportStatus.localize("report.status.state.decided");
         }
         return _myReportStatus.localize("report.status.state.pending");
      }
      
      private function getReportedUserDeleted(param1:String) : Object
      {
         var _loc2_:Boolean = param1 == null || param1 == "";
         var _loc4_:String = _loc2_ ? _myReportStatus.localize("report.status.deleted","Deleted") : param1;
         var _loc3_:int = _loc2_ ? 13762560 : 0;
         return {
            "deleted":_loc2_,
            "userName":_loc4_,
            "textColor":_loc3_
         };
      }
      
      public function get message() : CfhReportMessage
      {
         return _message;
      }
   }
}

