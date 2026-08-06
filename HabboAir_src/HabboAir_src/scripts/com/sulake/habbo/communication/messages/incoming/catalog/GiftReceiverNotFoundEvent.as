package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.UnknownHabboCommunicationMessagesParserCatalog1;
   
   [SecureSWF(rename="true")]
   public class GiftReceiverNotFoundEvent extends MessageEvent implements IMessageEvent
   {
      public function GiftReceiverNotFoundEvent(param1:Function)
      {
         super(param1,UnknownHabboCommunicationMessagesParserCatalog1);
      }
      
      public function getParser() : UnknownHabboCommunicationMessagesParserCatalog1
      {
         return this._parser as UnknownHabboCommunicationMessagesParserCatalog1;
      }
   }
}

