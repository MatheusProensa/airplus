package com.sulake.habbo.roomevents.wired_menu.roomlogs
{
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.roomlogs.WiredLogEntry;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableCell;
   
   public class WiredRoomLogListTableObject implements ITableObject
   {
      private static var COLOR_INFO:uint = 4607;
      
      private static var COLOR_WARN:uint = 11757568;
      
      private static var COLOR_ERROR:uint = 14362624;
      
      private static var COLOR_DEBUG:uint = 10158534;
      
      private static var COLORS:Array = [COLOR_INFO,COLOR_WARN,COLOR_ERROR,COLOR_DEBUG];
      
      private var UnknownVarFromWiredRoomLogListTableObject_WiredRoomLogListController_1:WiredRoomLogListController;
      
      private var _element:WiredLogEntry;
      
      public function WiredRoomLogListTableObject(param1:WiredRoomLogListController, param2:WiredLogEntry)
      {
         super();
         UnknownVarFromWiredRoomLogListTableObject_WiredRoomLogListController_1 = param1;
         _element = param2;
      }
      
      public function get identifier() : String
      {
         return String(_element.id);
      }
      
      public function getTableCell(param1:String) : TableCell
      {
         var _loc2_:int = int(COLORS[_element.logLevel]);
         switch(param1)
         {
            case "timestamp":
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,_element.timestampStr,false,true,null,null,false,null,_loc2_);
            case "source":
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,localize("wiredmenu.logs_overview.log_source." + _element.logSource),false,false,null,null,false,null,_loc2_);
            case "level":
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,localize("wiredmenu.logs_overview.log_level." + _element.logLevel),false,false,null,null,false,null,_loc2_);
            case "message":
               return new TableCell(TableCell.UnknownConstFromIlluminaChatBubbleMessage_Int_1,_element.logMessage,false,true,null,null,false,null,_loc2_);
            default:
               return null;
         }
      }
      
      private function localize(param1:String) : String
      {
         return localization.getLocalization(param1);
      }
      
      private function get localization() : IHabboLocalizationManager
      {
         return UnknownVarFromWiredRoomLogListTableObject_WiredRoomLogListController_1.localizationManager;
      }
      
      public function get element() : WiredLogEntry
      {
         return _element;
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

