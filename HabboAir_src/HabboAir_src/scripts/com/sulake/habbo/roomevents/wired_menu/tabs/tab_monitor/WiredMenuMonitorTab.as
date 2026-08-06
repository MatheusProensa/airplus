package com.sulake.habbo.roomevents.wired_menu.tabs.tab_monitor
{
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IHTMLTextController;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents4;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredErrorData;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredErrorLogsEvent;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredRoomStatsData;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredRoomStatsEvent;
   import com.sulake.habbo.communication.messages.outgoing.treasurehunt.ProgressTreasureHuntMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredClearErrorLogsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredGetErrorLogsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.WiredGetRoomStatsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredmenu.roomlogs.WiredGetRoomLogsComposer;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   import com.sulake.habbo.roomevents.wired_menu.roomlogs.WiredRoomLogsConfig;
   import com.sulake.habbo.roomevents.wired_menu.tabs.WiredMenuDefaultTab;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableColumn;
   import com.sulake.habbo.window.utils.tableview.TableView;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class WiredMenuMonitorTab extends WiredMenuDefaultTab implements IProfiler_1
   {
      private static var POLL_MONITOR_MS:uint = 500;
      
      private static var CLEAR_LOGS_TIMEOUT:uint = 4000;
      
      private static var COLOR_RED:String = "ff5733";
      
      private static var COLOR_ORANGE:String = "BD7800";
      
      private static var COLOR_GREEN:String = "008000";
      
      private static var THRESHOLD_USAGE_1:Number = 0.3;
      
      private static var THRESHOLD_USAGE_2:Number = 0.7;
      
      private static var THRESHOLD_FURNI_1:Number = 0.6;
      
      private static var THRESHOLD_FURNI_2:Number = 0.85;
      
      private static var THRESHOLD_VARS_1:Number = 0.5;
      
      private static var THRESHOLD_VARS_2:Number = 0.8;
      
      public static var LOG_COLUMN_TYPE:String = "type";
      
      public static var UnknownVarFromWiredMenuMonitorTab_String_1:String = "category";
      
      public static var UnknownVarFromWiredMenuMonitorTab_String_2:String = "quantity";
      
      public static var LOG_COLUMN_LATEST:String = "latest";
      
      private var UnknownVarFromWiredMenuMonitorTab_TableView_1:TableView;
      
      private var UnknownVarFromWiredMenuMonitorTab_Int_1:int = 0;
      
      private var UnknownVarFromWiredMenuMonitorTab_WiredErrorInfoView_1:WiredErrorInfoView = null;
      
      private var UnknownVarFromWiredMenuMonitorTab_Number_1:Number = 0;
      
      private var UnknownVarFromWiredMenuMonitorTab_Vector_1:Vector.<WiredErrorData> = null;
      
      private var UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1:WiredRoomStatsData = null;
      
      public function WiredMenuMonitorTab(param1:WiredMenuController, param2:IWindowController_1)
      {
         super(param1,param2);
         createLogTable();
         addMessageEvent(new WiredRoomStatsEvent(onRoomStatsEvent));
         addMessageEvent(new WiredErrorLogsEvent(onErrorLogsEvent));
         clearButton.addEventListener("WME_CLICK",onClearButtonClicked);
         logOverviewButton.addEventListener("WME_CLICK",onLogOverviewButtonClicked);
         monitorImage2.addEventListener("WME_CLICK",onClickMonitor);
      }
      
      private static function colorize(param1:int, param2:int, param3:int, param4:Number, param5:Number) : String
      {
         var _loc6_:Number = (param1 - param2) / (param3 - param2);
         if(_loc6_ < param4)
         {
            return COLOR_GREEN;
         }
         if(_loc6_ < param5)
         {
            return COLOR_ORANGE;
         }
         return COLOR_RED;
      }
      
      private function createLogTable() : void
      {
         UnknownVarFromWiredMenuMonitorTab_TableView_1 = new TableView(controller.windowManager,logTableContainer);
         var _loc1_:Array = [new TableColumn(LOG_COLUMN_TYPE,loc("wiredmenu.monitor.column.type"),0.33),new TableColumn(UnknownVarFromWiredMenuMonitorTab_String_1,loc("wiredmenu.monitor.column.category"),0.22),new TableColumn(UnknownVarFromWiredMenuMonitorTab_String_2,loc("wiredmenu.monitor.column.occurrences"),0.15),new TableColumn(LOG_COLUMN_LATEST,loc("wiredmenu.monitor.column.latest"),0.3)];
         UnknownVarFromWiredMenuMonitorTab_TableView_1.initialize(Vector.<TableColumn>(_loc1_));
      }
      
      override public function startViewing() : void
      {
         super.startViewing();
         clearData();
         updateLoadingState();
         requestData();
      }
      
      override protected function isDataReady() : Boolean
      {
         return UnknownVarFromWiredMenuMonitorTab_Vector_1 != null && UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1 != null;
      }
      
      private function clearData() : void
      {
         UnknownVarFromWiredMenuMonitorTab_Vector_1 = null;
         UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1 = null;
      }
      
      private function requestData() : void
      {
         UnknownVarFromWiredMenuMonitorTab_Int_1 = getTimer();
         controller.send(new WiredGetRoomStatsMessageComposer());
         controller.send(new WiredGetErrorLogsMessageComposer());
      }
      
      private function onRoomStatsEvent(param1:WiredRoomStatsEvent) : void
      {
         UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1 = param1.getParser().roomStats;
         if(isLoading)
         {
            updateLoadingState();
         }
         else
         {
            updateRoomStatsUI();
            updateImageUI();
         }
      }
      
      private function onErrorLogsEvent(param1:WiredErrorLogsEvent) : void
      {
         UnknownVarFromWiredMenuMonitorTab_Vector_1 = param1.getParser().errors;
         if(isLoading)
         {
            updateLoadingState();
         }
         else
         {
            updateErrorLogsUI();
            updateButtonsUI();
            updateImageUI();
         }
      }
      
      private function onClearButtonClicked(param1:WindowMouseEvent) : void
      {
         clearButton.disable();
         controller.send(new WiredClearErrorLogsMessageComposer());
         UnknownVarFromWiredMenuMonitorTab_Number_1 = getTimer();
         setTimeout(updateButtonsUI,CLEAR_LOGS_TIMEOUT + 500);
      }
      
      private function onLogOverviewButtonClicked(param1:WindowMouseEvent) : void
      {
         controller.roomLogListController.send(new WiredGetRoomLogsComposer(1,WiredRoomLogsConfig.PAGE_SIZE,-1,-1,""));
      }
      
      override protected function initializeInterface() : void
      {
         updateRoomStatsUI();
         updateErrorLogsUI();
         updateButtonsUI();
         updateImageUI();
      }
      
      private function updateRoomStatsUI() : void
      {
         statWiredUsageHtml.caption = localization.getLocalizationWithParams("wiredmenu.monitor.statistics.usage","","color",usageStatColor,"amount",UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.executionCost.toFixed(0),"limit",UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.executionCostCap.toFixed(0));
         statHeavyHtml.caption = localization.getLocalizationWithParams("wiredmenu.monitor.statistics.is_heavy","","color",UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.isHeavy ? COLOR_ORANGE : COLOR_GREEN,"bool",UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.isHeavy ? localization.getLocalization("wiredmenu.bool.yes") : localization.getLocalization("wiredmenu.bool.no"));
         statFloorCountHtml.caption = localization.getLocalizationWithParams("wiredmenu.monitor.statistics.floorfurni","","color",floorItemStatColor,"amount",UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.floorItemCount,"limit",UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.floorItemCap);
         statWallCountHtml.caption = localization.getLocalizationWithParams("wiredmenu.monitor.statistics.wallfurni","","color",wallItemStatColor,"amount",UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.wallItemCount,"limit",UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.wallItemCap);
         statPermFurniVarsHtml.caption = localization.getLocalizationWithParams("wiredmenu.monitor.statistics.perm_furni_vars","","color",varLimitColor(UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.permanentFurniVariables,UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.maxPermanentFurniVariables),"amount",UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.permanentFurniVariables,"limit",UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.maxPermanentFurniVariables);
         statPermUserVarsHtml.caption = localization.getLocalizationWithParams("wiredmenu.monitor.statistics.perm_user_vars","","color",varLimitColor(UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.permanentUserVariables,UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.maxPermanentUserVariables),"amount",UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.permanentUserVariables,"limit",UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.maxPermanentUserVariables);
         statPermGlobalVarsHtml.caption = localization.getLocalizationWithParams("wiredmenu.monitor.statistics.perm_global_vars","","color",varLimitColor(UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.permanentGlobalVariables,UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.maxPermanentGlobalVariables),"amount",UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.permanentGlobalVariables,"limit",UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.maxPermanentGlobalVariables);
      }
      
      private function get usageStatColor() : String
      {
         return colorize(UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.executionCost,0,UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.executionCostCap,THRESHOLD_USAGE_1,THRESHOLD_USAGE_2);
      }
      
      private function get floorItemStatColor() : String
      {
         return colorize(UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.floorItemCount,0,UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.floorItemCap,THRESHOLD_FURNI_1,THRESHOLD_FURNI_2);
      }
      
      private function get wallItemStatColor() : String
      {
         return colorize(UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.wallItemCount,0,UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.wallItemCap,THRESHOLD_FURNI_1,THRESHOLD_FURNI_2);
      }
      
      private function varLimitColor(param1:int, param2:int) : String
      {
         return colorize(param1,0,param2,THRESHOLD_VARS_1,THRESHOLD_VARS_2);
      }
      
      private function updateErrorLogsUI() : void
      {
         var _loc1_:Vector.<ITableObject> = new Vector.<ITableObject>();
         for each(var _loc2_ in UnknownVarFromWiredMenuMonitorTab_Vector_1)
         {
            _loc1_.push(new ErrorDataTableObject(this,_loc2_,localization));
         }
         UnknownVarFromWiredMenuMonitorTab_TableView_1.setObjects(_loc1_);
      }
      
      private function updateImageUI() : void
      {
         var _loc1_:Boolean = isFrankPanicking;
         monitorImage1.visible = !_loc1_;
         monitorImage2.visible = _loc1_;
      }
      
      private function get isFrankPanicking() : Boolean
      {
         if(UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1.isHeavy)
         {
            return true;
         }
         if(usageStatColor != COLOR_GREEN || floorItemStatColor != COLOR_GREEN || wallItemStatColor != COLOR_GREEN)
         {
            return true;
         }
         return hasErrors;
      }
      
      internal function onErrorLinkClicked(param1:WiredErrorData) : void
      {
         if(UnknownVarFromWiredMenuMonitorTab_WiredErrorInfoView_1 == null)
         {
            UnknownVarFromWiredMenuMonitorTab_WiredErrorInfoView_1 = new WiredErrorInfoView(controller);
         }
         UnknownVarFromWiredMenuMonitorTab_WiredErrorInfoView_1.initialize(param1);
         UnknownVarFromWiredMenuMonitorTab_WiredErrorInfoView_1.show();
      }
      
      private function updateButtonsUI() : void
      {
         Util.disableSection(logOverviewButton,!controller.hasReadPermission);
         var _loc1_:* = getTimer() < UnknownVarFromWiredMenuMonitorTab_Number_1 + CLEAR_LOGS_TIMEOUT;
         Util.disableSection(clearButton,!controller.hasWritePermission || _loc1_);
      }
      
      private function get hasErrors() : Boolean
      {
         for each(var _loc1_ in UnknownVarFromWiredMenuMonitorTab_Vector_1)
         {
            if(_loc1_.throwCount > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      override public function permissionsUpdated() : void
      {
         updateButtonsUI();
      }
      
      private function onClickMonitor(param1:WindowMouseEvent) : void
      {
         if(param1.localX < 14 || param1.localX > 61 || param1.localY < 45 || param1.localY > 107)
         {
            return;
         }
         controller.send(new ProgressTreasureHuntMessageComposer("wf15",(param1.window as IStaticBitmapWrapperWindow).assetUri));
      }
      
      public function update(param1:uint) : void
      {
         if(!isViewing)
         {
            return;
         }
         var _loc2_:int = getTimer();
         if(UnknownVarFromWiredMenuMonitorTab_Int_1 < _loc2_ - POLL_MONITOR_MS)
         {
            requestData();
         }
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(UnknownVarFromWiredMenuMonitorTab_WiredErrorInfoView_1 != null)
         {
            UnknownVarFromWiredMenuMonitorTab_WiredErrorInfoView_1.dispose();
            UnknownVarFromWiredMenuMonitorTab_WiredErrorInfoView_1 = null;
         }
         UnknownVarFromWiredMenuMonitorTab_TableView_1.dispose();
         UnknownVarFromWiredMenuMonitorTab_TableView_1 = null;
         UnknownVarFromWiredMenuMonitorTab_Vector_1 = null;
         UnknownVarFromWiredMenuMonitorTab_WiredRoomStatsData_1 = null;
         super.dispose();
      }
      
      private function get statWiredUsageHtml() : IHTMLTextController
      {
         return container.findChildByName("statistics_usage_html") as IHTMLTextController;
      }
      
      private function get statHeavyHtml() : IHTMLTextController
      {
         return container.findChildByName("statistics_heavy_html") as IHTMLTextController;
      }
      
      private function get statFloorCountHtml() : IHTMLTextController
      {
         return container.findChildByName("statistics_floorfurni_html") as IHTMLTextController;
      }
      
      private function get statWallCountHtml() : IHTMLTextController
      {
         return container.findChildByName("statistics_wallfurni_html") as IHTMLTextController;
      }
      
      private function get statPermFurniVarsHtml() : IHTMLTextController
      {
         return container.findChildByName("statistics_perm_vars_furni_html") as IHTMLTextController;
      }
      
      private function get statPermUserVarsHtml() : IHTMLTextController
      {
         return container.findChildByName("statistics_perm_vars_user_html") as IHTMLTextController;
      }
      
      private function get statPermGlobalVarsHtml() : IHTMLTextController
      {
         return container.findChildByName("statistics_perm_vars_global_html") as IHTMLTextController;
      }
      
      private function get logTableContainer() : IWindowController_1
      {
         return container.findChildByName("log_table_container") as IWindowController_1;
      }
      
      private function get clearButton() : UnknownICoreWindowComponents4
      {
         return container.findChildByName("clear_log_btn") as UnknownICoreWindowComponents4;
      }
      
      private function get logOverviewButton() : UnknownICoreWindowComponents4
      {
         return container.findChildByName("log_overview_btn") as UnknownICoreWindowComponents4;
      }
      
      private function get monitorImage1() : IStaticBitmapWrapperWindow
      {
         return container.findChildByName("monitor_image_1") as IStaticBitmapWrapperWindow;
      }
      
      private function get monitorImage2() : IStaticBitmapWrapperWindow
      {
         return container.findChildByName("monitor_image_2") as IStaticBitmapWrapperWindow;
      }
   }
}

