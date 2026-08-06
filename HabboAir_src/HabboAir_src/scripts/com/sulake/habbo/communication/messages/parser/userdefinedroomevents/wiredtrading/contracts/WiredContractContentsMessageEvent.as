package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.contracts
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class WiredContractContentsMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredContractContentsMessageEvent(param1:Function)
      {
         super(param1,WiredContractContentsMessageParser);
      }
      
      public function getParser() : WiredContractContentsMessageParser
      {
         return this._parser as WiredContractContentsMessageParser;
      }
   }
}

