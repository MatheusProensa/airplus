package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.variables_management
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class WiredSetUserPermanentVariableResultEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredSetUserPermanentVariableResultEvent(param1:Function)
      {
         super(param1,WiredSetUserPermanentVariableResultMessageParser);
      }
      
      public function getParser() : WiredSetUserPermanentVariableResultMessageParser
      {
         return this._parser as WiredSetUserPermanentVariableResultMessageParser;
      }
   }
}

