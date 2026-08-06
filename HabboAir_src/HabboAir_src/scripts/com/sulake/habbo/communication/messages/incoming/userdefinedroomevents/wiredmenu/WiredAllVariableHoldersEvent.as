package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.WiredAllVariableHoldersMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredAllVariableHoldersEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredAllVariableHoldersEvent(param1:Function)
      {
         super(param1,WiredAllVariableHoldersMessageParser);
      }
      
      public function getParser() : WiredAllVariableHoldersMessageParser
      {
         return this._parser as WiredAllVariableHoldersMessageParser;
      }
   }
}

