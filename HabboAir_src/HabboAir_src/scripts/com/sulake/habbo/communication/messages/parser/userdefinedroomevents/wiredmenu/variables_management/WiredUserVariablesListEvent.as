package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu.variables_management
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class WiredUserVariablesListEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredUserVariablesListEvent(param1:Function)
      {
         super(param1,WiredUserVariablesListMessageParser);
      }
      
      public function getParser() : WiredUserVariablesListMessageParser
      {
         return this._parser as WiredUserVariablesListMessageParser;
      }
   }
}

