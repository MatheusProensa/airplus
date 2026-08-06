package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.roomlogs
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class WiredRoomLogsEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredRoomLogsEvent(param1:Function)
      {
         super(param1,WiredRoomLogsMessageParser);
      }
      
      public function getParser() : WiredRoomLogsMessageParser
      {
         return this._parser as WiredRoomLogsMessageParser;
      }
   }
}

