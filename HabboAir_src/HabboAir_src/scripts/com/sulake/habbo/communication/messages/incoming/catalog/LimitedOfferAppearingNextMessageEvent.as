package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.LimitedOfferAppearingNextMessageParser;
   
   [SecureSWF(rename="true")]
   public class LimitedOfferAppearingNextMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function LimitedOfferAppearingNextMessageEvent(param1:Function)
      {
         super(param1,LimitedOfferAppearingNextMessageParser);
      }
      
      public function getParser() : LimitedOfferAppearingNextMessageParser
      {
         return this._parser as LimitedOfferAppearingNextMessageParser;
      }
   }
}

