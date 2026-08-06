package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
   
   [SecureSWF(rename="true")]
   public class SeasonalCalendarDailyOfferMessageParser implements IMessageParser
   {
      private var _pageId:int;
      
      private var _offerData:CatalogPageMessageOfferData;
      
      public function SeasonalCalendarDailyOfferMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _pageId = -1;
         _offerData = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _pageId = param1.readInteger();
         _offerData = new CatalogPageMessageOfferData(param1);
         return true;
      }
      
      public function get pageId() : int
      {
         return _pageId;
      }
      
      public function get offerData() : CatalogPageMessageOfferData
      {
         return _offerData;
      }
   }
}

