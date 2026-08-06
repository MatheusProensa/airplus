package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredClickSettingsMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredClickSettingsMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredClickSettingsMessageEvent(param1:Function)
      {
         super(param1,WiredClickSettingsMessageParser);
      }
      
      public function getParser() : WiredClickSettingsMessageParser
      {
         return this._parser as WiredClickSettingsMessageParser;
      }
   }
}

