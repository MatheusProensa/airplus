package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.CatalogPageWithEarliestExpiryMessageParser;
   
   [SecureSWF(rename="true")]
   public class CatalogPageWithEarliestExpiryMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function CatalogPageWithEarliestExpiryMessageEvent(param1:Function)
      {
         super(param1,CatalogPageWithEarliestExpiryMessageParser);
      }
      
      public function getParser() : CatalogPageWithEarliestExpiryMessageParser
      {
         return this._parser as CatalogPageWithEarliestExpiryMessageParser;
      }
   }
}

