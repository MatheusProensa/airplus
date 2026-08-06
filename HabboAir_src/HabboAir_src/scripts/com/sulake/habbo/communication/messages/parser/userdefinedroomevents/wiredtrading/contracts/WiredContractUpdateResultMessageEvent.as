package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.contracts
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class WiredContractUpdateResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredContractUpdateResultMessageEvent(param1:Function)
      {
         super(param1,WiredContractUpdateResultMessageParser);
      }
      
      public function getParser() : WiredContractUpdateResultMessageParser
      {
         return this._parser as WiredContractUpdateResultMessageParser;
      }
   }
}

