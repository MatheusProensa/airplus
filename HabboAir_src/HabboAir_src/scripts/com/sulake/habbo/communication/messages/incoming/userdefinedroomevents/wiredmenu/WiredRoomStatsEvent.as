package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.WiredRoomStatsMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredRoomStatsEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredRoomStatsEvent(param1:Function)
      {
         super(param1,WiredRoomStatsMessageParser);
      }
      
      public function getParser() : WiredRoomStatsMessageParser
      {
         return this._parser as WiredRoomStatsMessageParser;
      }
   }
}

