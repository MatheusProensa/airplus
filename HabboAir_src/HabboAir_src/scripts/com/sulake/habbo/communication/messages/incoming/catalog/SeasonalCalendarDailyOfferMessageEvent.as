package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.SeasonalCalendarDailyOfferMessageParser;
   
   [SecureSWF(rename="true")]
   public class SeasonalCalendarDailyOfferMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function SeasonalCalendarDailyOfferMessageEvent(param1:Function)
      {
         super(param1,SeasonalCalendarDailyOfferMessageParser);
      }
      
      public function get offer() : CatalogPageMessageOfferData
      {
         return SeasonalCalendarDailyOfferMessageParser(parser).offerData;
      }
      
      public function get pageId() : int
      {
         return SeasonalCalendarDailyOfferMessageParser(parser).pageId;
      }
   }
}

