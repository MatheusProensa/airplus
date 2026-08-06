package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.WiredRoomSettingsMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredRoomSettingsEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredRoomSettingsEvent(param1:Function)
      {
         super(param1,WiredRoomSettingsMessageParser);
      }
      
      public function getParser() : WiredRoomSettingsMessageParser
      {
         return this._parser as WiredRoomSettingsMessageParser;
      }
   }
}

