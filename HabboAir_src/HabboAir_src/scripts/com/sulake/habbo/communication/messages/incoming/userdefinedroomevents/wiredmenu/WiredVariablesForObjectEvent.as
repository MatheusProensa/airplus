package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.WiredVariablesForObjectMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredVariablesForObjectEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredVariablesForObjectEvent(param1:Function)
      {
         super(param1,WiredVariablesForObjectMessageParser);
      }
      
      public function getParser() : WiredVariablesForObjectMessageParser
      {
         return this._parser as WiredVariablesForObjectMessageParser;
      }
   }
}

