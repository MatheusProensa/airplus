package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.WiredAllVariablesDiffsMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredAllVariablesDiffsEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredAllVariablesDiffsEvent(param1:Function)
      {
         super(param1,WiredAllVariablesDiffsMessageParser);
      }
      
      public function getParser() : WiredAllVariablesDiffsMessageParser
      {
         return this._parser as WiredAllVariablesDiffsMessageParser;
      }
   }
}

