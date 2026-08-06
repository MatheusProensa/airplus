package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.contracts
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class WiredOpenContractMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredOpenContractMessageEvent(param1:Function)
      {
         super(param1,WiredOpenContractMessageParser);
      }
      
      public function getParser() : WiredOpenContractMessageParser
      {
         return this._parser as WiredOpenContractMessageParser;
      }
   }
}

