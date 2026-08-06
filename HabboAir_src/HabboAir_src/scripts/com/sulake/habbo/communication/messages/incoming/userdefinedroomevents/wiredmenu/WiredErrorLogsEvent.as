package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.WiredErrorLogsMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredErrorLogsEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredErrorLogsEvent(param1:Function)
      {
         super(param1,WiredErrorLogsMessageParser);
      }
      
      public function getParser() : WiredErrorLogsMessageParser
      {
         return this._parser as WiredErrorLogsMessageParser;
      }
   }
}

