package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.roomlogs
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class WiredRoomLogsMessageParser implements IMessageParser
   {
      private var _page:WiredLogPage;
      
      public function WiredRoomLogsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _page = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _page = new WiredLogPage(param1);
         return true;
      }
      
      public function get page() : WiredLogPage
      {
         return _page;
      }
   }
}

