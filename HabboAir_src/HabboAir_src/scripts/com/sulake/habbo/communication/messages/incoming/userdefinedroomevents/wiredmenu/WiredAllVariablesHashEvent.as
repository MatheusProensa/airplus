package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.WiredAllVariablesHashMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredAllVariablesHashEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredAllVariablesHashEvent(param1:Function)
      {
         super(param1,WiredAllVariablesHashMessageParser);
      }
      
      public function getParser() : WiredAllVariablesHashMessageParser
      {
         return this._parser as WiredAllVariablesHashMessageParser;
      }
   }
}

