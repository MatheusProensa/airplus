package com.sulake.habbo.help
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBubbleController;
   import com.sulake.core.window.components.IHTMLTextController;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowLinkEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.CfhReportMessage;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.MyCfhReportStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.callforhelp.MyCfhReportStatusMessageParser;
   import com.sulake.habbo.communication.messages.outgoing.help.AppealCfhMessageComposer;
   import com.sulake.habbo.help.reportstatus.ReportStatusTableObject;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableColumn;
   import com.sulake.habbo.window.utils.tableview.TableView;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.globalization.DateTimeFormatter;
   
   public class MyReportStatus implements IComponentInterfaceQueue
   {
      public static var COLUMN_REPORT_DATE:String = "report_date";
      
      public static var COLUMN_REPORTED_ACCOUNT:String = "account";
      
      public static var COLUMN_REASON:String = "reason";
      
      public static var COLUMN_APPEAL_STATUS:String = "appeal_status";
      
      private var _disposed:Boolean = false;
      
      private var _window:IWindowController_1;
      
      private var _habboHelp:HabboHelp;
      
      private var UnknownVarFromMyReportStatus_TableView_1:TableView;
      
      private var _shownObject:ReportStatusTableObject;
      
      private var UnknownVarFromMyReportStatus_Boolean_1:Boolean;
      
      private var UnknownVarFromMyReportStatus_IBubbleController_1:IBubbleController;
      
      private var UnknownVarFromMyReportStatus_DateTimeFormatter_1:DateTimeFormatter;
      
      public function MyReportStatus(param1:HabboHelp)
      {
         super();
         _habboHelp = param1;
         UnknownVarFromMyReportStatus_DateTimeFormatter_1 = new DateTimeFormatter("i-default");
         UnknownVarFromMyReportStatus_DateTimeFormatter_1.setDateTimePattern("dd/MM/yyyy");
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(UnknownVarFromMyReportStatus_TableView_1)
         {
            UnknownVarFromMyReportStatus_TableView_1.dispose();
            UnknownVarFromMyReportStatus_TableView_1 = null;
         }
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         _shownObject = null;
         if(UnknownVarFromMyReportStatus_IBubbleController_1)
         {
            UnknownVarFromMyReportStatus_IBubbleController_1.dispose();
            UnknownVarFromMyReportStatus_IBubbleController_1 = null;
         }
         UnknownVarFromMyReportStatus_Boolean_1 = false;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function openWindow(param1:MyCfhReportStatusMessageEvent) : void
      {
         dispose();
         _disposed = false;
         _window = _habboHelp.getXmlWindow("my_reports") as IWindowController_1;
         UnknownVarFromMyReportStatus_IBubbleController_1 = _window.findChildByName("status_info_bubble") as IBubbleController;
         _window.desktop.addChild(UnknownVarFromMyReportStatus_IBubbleController_1);
         UnknownVarFromMyReportStatus_IBubbleController_1.visible = false;
         appealButton.addEventListener("WME_CLICK",onClickAppeal);
         _window.center();
         _window.procedure = windowEventHandler;
         createTable();
         var _loc2_:MyCfhReportStatusMessageParser = param1.getParser() as MyCfhReportStatusMessageParser;
         setTableObjects(_loc2_.messages);
      }
      
      public function createTable() : void
      {
         UnknownVarFromMyReportStatus_TableView_1 = new TableView(_habboHelp.windowManager,reportsTableContainer);
         var _loc1_:Array = [new TableColumn(COLUMN_REPORT_DATE,localize("report.status.col.report_date"),0.26,"left"),new TableColumn(COLUMN_REPORTED_ACCOUNT,localize("report.status.col.reported_account"),0.18,"left"),new TableColumn(COLUMN_REASON,localize("report.status.col.reason"),0.38,"left"),new TableColumn(COLUMN_APPEAL_STATUS,localize("report.status.col.appeal_status"),0.18,"left")];
         UnknownVarFromMyReportStatus_TableView_1.initialize(Vector.<TableColumn>(_loc1_),true,false);
         UnknownVarFromMyReportStatus_TableView_1.onRowHoveredCallback = onRowHover;
      }
      
      public function setTableObjects(param1:Vector.<CfhReportMessage>) : void
      {
         var message:CfhReportMessage;
         var messages:Vector.<CfhReportMessage> = param1;
         var tableObjects:Vector.<ITableObject> = new Vector.<ITableObject>();
         messages.sort(function(param1:CfhReportMessage, param2:CfhReportMessage):int
         {
            if(param1.creationTime > param2.creationTime)
            {
               return -1;
            }
            if(param1.creationTime < param2.creationTime)
            {
               return 1;
            }
            return 0;
         });
         for each(message in messages)
         {
            tableObjects.push(new ReportStatusTableObject(this,message));
         }
         UnknownVarFromMyReportStatus_TableView_1.setObjects(tableObjects);
      }
      
      public function localize(param1:String, param2:String = null) : String
      {
         return _habboHelp.localization.getLocalization(param1,param2 ?? param1);
      }
      
      private function windowEventHandler(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(_disposed || !_window || param1.type != "WME_CLICK" || !param2)
         {
            return;
         }
         var _loc3_:* = param2.name;
         if("header_button_close" === _loc3_)
         {
            dispose();
         }
      }
      
      private function onRowHover(param1:ReportStatusTableObject) : void
      {
         if(param1 != null && _shownObject != param1 && UnknownVarFromMyReportStatus_Boolean_1)
         {
            setFocusRow(param1);
         }
      }
      
      public function clickInfoButton(param1:ReportStatusTableObject) : void
      {
         UnknownVarFromMyReportStatus_Boolean_1 = !UnknownVarFromMyReportStatus_Boolean_1;
         setFocusRow(UnknownVarFromMyReportStatus_Boolean_1 ? param1 : null);
      }
      
      private function setFocusRow(param1:ReportStatusTableObject) : void
      {
         if(param1 == _shownObject)
         {
            return;
         }
         _shownObject = param1;
         UnknownVarFromMyReportStatus_IBubbleController_1.visible = _shownObject != null;
         if(UnknownVarFromMyReportStatus_IBubbleController_1.visible)
         {
            refreshBubbleUI();
            relocateBubbleAndFocus();
         }
      }
      
      private function refreshBubbleUI() : void
      {
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc7_:String = null;
         var _loc4_:CfhReportMessage = _shownObject.message;
         var _loc6_:* = _loc4_.appealStatus != CfhReportMessage.UnknownVarFromCfhReportMessage_Int_1;
         var _loc5_:Boolean = _loc6_ ? _loc4_.appealResolutionTime != -1 : _loc4_.closeTime != -1;
         var _loc10_:String = _loc6_ ? (_loc5_ ? UnknownVarFromMyReportStatus_DateTimeFormatter_1.format(new Date(_loc4_.appealResolutionTime)) : "-") : (_loc5_ ? UnknownVarFromMyReportStatus_DateTimeFormatter_1.format(new Date(_loc4_.closeTime)) : "-");
         var _loc3_:String = _loc6_ ? "report.status.info.appealed" : "report.status.info.reported";
         if(_loc5_)
         {
            _loc8_ = _loc4_.sanctioned ? "report.status.info.action" : "report.status.info.no_action";
            actionDescText.text = localize(getActionExplanation(_loc4_.sanctioned,_loc4_.sanctionGivenByAutoModeration,_loc4_.appealStatus));
         }
         else
         {
            _loc8_ = "report.status.info.sanction_pending";
            actionDescText.text = "";
         }
         actionText.text = localize(_loc8_);
         createdKeyText.text = localize(_loc3_);
         var _loc1_:Number = _loc6_ ? _loc4_.appealCreationTime : _loc4_.creationTime;
         reportedDateText.text = UnknownVarFromMyReportStatus_DateTimeFormatter_1.format(new Date(_loc1_));
         decisionDateText.text = _loc10_;
         var _loc2_:Boolean = _loc4_.appealStatus == CfhReportMessage.UnknownVarFromCfhReportMessage_Int_1 && _loc5_ && !_loc4_.sanctioned;
         if(_loc2_)
         {
            appealButton.enable();
         }
         else
         {
            appealButton.disable();
         }
         if(_loc4_.sanctioned)
         {
            _loc9_ = _habboHelp.getProperty("zendesk.url");
            _loc7_ = _habboHelp.localization.getLocalizationWithParams("report.status.info.sanction_help","","url",_loc9_);
            sanctionInfoText.text = _loc7_;
            sanctionInfoText.initializeLinkStyle();
            sanctionInfoText.addEventListener("WE_LINK",onClickHtmlLink);
         }
         else
         {
            sanctionInfoText.text = "";
         }
      }
      
      private function onClickHtmlLink(param1:WindowEvent) : void
      {
         var _loc2_:WindowLinkEvent = param1 as WindowLinkEvent;
         if(_loc2_ != null)
         {
            HabboWebTools.openWebPageAndMinimizeClient(_loc2_.link);
         }
      }
      
      private function onClickAppeal(param1:WindowMouseEvent) : void
      {
         if(_shownObject == null)
         {
            return;
         }
         _habboHelp.sendMessage(new AppealCfhMessageComposer(_shownObject.message.id));
         appealButton.disable();
      }
      
      private function getActionExplanation(param1:Boolean, param2:Boolean, param3:int) : String
      {
         if(param3 == CfhReportMessage.UnknownVarFromCfhReportMessage_Int_2)
         {
            return "report.status.info.appeal.action";
         }
         if(param3 == CfhReportMessage.UnknownVarFromCfhReportMessage_Int_3)
         {
            return "report.status.info.appeal.no_action";
         }
         return param2 ? (param1 ? "report.status.info.auto_moderated.action" : "report.status.info.auto_moderated.no_action") : (param1 ? "report.status.info.manually_moderated.action" : "report.status.info.manually_moderated.no_action");
      }
      
      private function relocateBubbleAndFocus() : void
      {
         var _loc1_:Rectangle = UnknownVarFromMyReportStatus_TableView_1.getGlobalRowRectangle(_shownObject);
         UnknownVarFromMyReportStatus_IBubbleController_1.position = new Point(_loc1_.x + _loc1_.width - 2,_loc1_.y + _loc1_.height / 2 - UnknownVarFromMyReportStatus_IBubbleController_1.height / 2);
         UnknownVarFromMyReportStatus_IBubbleController_1.activate();
      }
      
      private function get reportsTableContainer() : IWindowController_1
      {
         return _window.findChildByName("reports_table_cont") as IWindowController_1;
      }
      
      private function get reportedDateText() : ITextWindow
      {
         return UnknownVarFromMyReportStatus_IBubbleController_1.findChildByName("reported_date_txt") as ITextWindow;
      }
      
      private function get decisionDateText() : ITextWindow
      {
         return UnknownVarFromMyReportStatus_IBubbleController_1.findChildByName("decision_date_txt") as ITextWindow;
      }
      
      private function get createdKeyText() : ITextWindow
      {
         return UnknownVarFromMyReportStatus_IBubbleController_1.findChildByName("created_key_txt") as ITextWindow;
      }
      
      private function get actionText() : ITextWindow
      {
         return UnknownVarFromMyReportStatus_IBubbleController_1.findChildByName("action_txt") as ITextWindow;
      }
      
      private function get actionDescText() : ITextWindow
      {
         return UnknownVarFromMyReportStatus_IBubbleController_1.findChildByName("action_desc_txt") as ITextWindow;
      }
      
      private function get appealButton() : UnknownICoreWindowComponents4
      {
         return UnknownVarFromMyReportStatus_IBubbleController_1.findChildByName("appeal_button") as UnknownICoreWindowComponents4;
      }
      
      private function get sanctionInfoText() : IHTMLTextController
      {
         return UnknownVarFromMyReportStatus_IBubbleController_1.findChildByName("sanction_info_txt") as IHTMLTextController;
      }
   }
}

