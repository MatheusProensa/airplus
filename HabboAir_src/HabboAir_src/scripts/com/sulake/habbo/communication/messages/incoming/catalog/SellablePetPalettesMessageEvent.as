package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.SellablePetPalettesParser;
   
   [SecureSWF(rename="true")]
   public class SellablePetPalettesMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function SellablePetPalettesMessageEvent(param1:Function)
      {
         super(param1,SellablePetPalettesParser);
      }
      
      public function getParser() : SellablePetPalettesParser
      {
         return this._parser as SellablePetPalettesParser;
      }
   }
}

