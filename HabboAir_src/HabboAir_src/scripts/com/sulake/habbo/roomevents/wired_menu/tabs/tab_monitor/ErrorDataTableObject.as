package com.sulake.habbo.roomevents.wired_menu.tabs.tab_monitor
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu.WiredErrorData;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.utils.FriendlyTime;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableCell;
   
   public class ErrorDataTableObject implements ITableObject
   {
      private var UnknownVarFromErrorDataTableObject_WiredMenuMonitorTab_1:WiredMenuMonitorTab;
      
      private var _data:WiredErrorData;
      
      private var _localization:IHabboLocalizationManager;
      
      public function ErrorDataTableObject(param1:WiredMenuMonitorTab, param2:WiredErrorData, param3:IHabboLocalizationManager)
      {
         super();
         UnknownVarFromErrorDataTableObject_WiredMenuMonitorTab_1 = param1;
         _data = param2;
         _localization = param3;
      }
      
      private static function convertTimestamp(param1:Number) : String
      {
         var _loc2_:Date = new Date(param1);
         var _loc6_:int = _loc2_.fullYear;
         var _loc5_:int = _loc2_.month + 1;
         var _loc8_:int = _loc2_.date;
         var _loc3_:int = _loc2_.hours;
         var _loc7_:int = _loc2_.minutes;
         var _loc4_:int = _loc2_.seconds;
         return _loc6_ + "-" + addLeadingZero(_loc5_) + "-" + addLeadingZero(_loc8_) + " " + addLeadingZero(_loc3_) + ":" + addLeadingZero(_loc7_) + ":" + addLeadingZero(_loc4_);
      }
      
      private static function addLeadingZero(param1:int) : String
      {
         return param1 < 10 ? "0" + param1.toString() : param1.toString();
      }
      
      public function get data() : WiredErrorData
      {
         return _data;
      }
      
      public function get identifier() : String
      {
         return String(_data.errorId);
      }
      
      public function isPropertyUpdated(param1:String, param2:Object) : Boolean
      {
         var _loc3_:WiredErrorData = (param2 as ErrorDataTableObject).data;
         switch(param1)
         {
            case WiredMenuMonitorTab.UnknownVarFromWiredMenuMonitorTab_String_2:
               return _data.throwCount != _loc3_.throwCount;
            case WiredMenuMonitorTab.LOG_COLUMN_LATEST:
               return _data.msSinceLastOccurrence != _loc3_.msSinceLastOccurrence;
            default:
               return false;
         }
      }
      
      public function isUpdated(param1:Object) : Boolean
      {
         var _loc2_:WiredErrorData = (param1 as ErrorDataTableObject).data;
         return _data.msSinceLastOccurrence != _loc2_.msSinceLastOccurrence || _data.throwCount != _loc2_.throwCount;
      }
      
      public function onLinkClicked() : void
      {
         UnknownVarFromErrorDataTableObject_WiredMenuMonitorTab_1.onErrorLinkClicked(_data);
      }
      
      public function getTableCell(param1:String) : TableCell
      {
         switch(param1)
         {
            case WiredMenuMonitorTab.LOG_COLUMN_TYPE:
               return new TableCell(TableCell.UnknownVarFromTableCell_Int_1,_data.errorName,false,false,null,onLinkClicked);
            case WiredMenuMonitorTab.UnknownVarFromWiredMenuMonitorTab_String_1:
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,_data.category);
            case WiredMenuMonitorTab.UnknownVarFromWiredMenuMonitorTab_String_2:
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,String(_data.throwCount));
            case WiredMenuMonitorTab.LOG_COLUMN_LATEST:
               if(_data.msSinceLastOccurrence < 0)
               {
                  return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,"/");
               }
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,FriendlyTime.getFriendlyTime(_localization,_data.msSinceLastOccurrence / 1000,".ago",3),false,false,null,null,false,timestampString);
               break;
            default:
               return null;
         }
      }
      
      private function get timestampString() : String
      {
         var _loc1_:Number = new Date().time - _data.msSinceLastOccurrence;
         _loc1_ -= _loc1_ % 1000;
         return convertTimestamp(_loc1_);
      }
   }
}

