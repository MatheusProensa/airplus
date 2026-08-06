package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.variables_management
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class WiredUserPermanentVariablesEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredUserPermanentVariablesEvent(param1:Function)
      {
         super(param1,WiredUserPermanentVariablesMessageParser);
      }
      
      public function getParser() : WiredUserPermanentVariablesMessageParser
      {
         return this._parser as WiredUserPermanentVariablesMessageParser;
      }
   }
}

