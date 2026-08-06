package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.CatalogPageExpirationParser;
   
   [SecureSWF(rename="true")]
   public class CatalogPageExpirationEvent extends MessageEvent implements IMessageEvent
   {
      public function CatalogPageExpirationEvent(param1:Function)
      {
         super(param1,CatalogPageExpirationParser);
      }
      
      public function getParser() : CatalogPageExpirationParser
      {
         return this._parser as CatalogPageExpirationParser;
      }
   }
}

