package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogLocalizationData;
   import com.sulake.habbo.communication.messages.incoming.catalog.CatalogPageMessageOfferData;
   import com.sulake.habbo.communication.messages.incoming.catalog.FrontPageItem;
   
   [SecureSWF(rename="true")]
   public class CatalogPageMessageParser implements IMessageParser
   {
      private var _pageId:int;
      
      private var _catalogType:String;
      
      private var _layoutCode:String;
      
      private var _localization:CatalogLocalizationData;
      
      private var _offers:Vector.<CatalogPageMessageOfferData>;
      
      private var _offerId:int;
      
      private var _acceptSeasonCurrencyAsCredits:Boolean;
      
      private var _frontPageItems:Vector.<FrontPageItem>;
      
      public function CatalogPageMessageParser()
      {
         super();
      }
      
      public function get pageId() : int
      {
         return _pageId;
      }
      
      public function get catalogType() : String
      {
         return _catalogType;
      }
      
      public function get layoutCode() : String
      {
         return _layoutCode;
      }
      
      public function get localization() : CatalogLocalizationData
      {
         return _localization;
      }
      
      public function get offers() : Vector.<CatalogPageMessageOfferData>
      {
         return _offers;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get acceptSeasonCurrencyAsCredits() : Boolean
      {
         return _acceptSeasonCurrencyAsCredits;
      }
      
      public function get frontPageItems() : Vector.<FrontPageItem>
      {
         return _frontPageItems;
      }
      
      public function flush() : Boolean
      {
         _pageId = -1;
         _catalogType = "";
         _layoutCode = "";
         _localization = null;
         _offers = new Vector.<CatalogPageMessageOfferData>(0);
         _offerId = -1;
         _acceptSeasonCurrencyAsCredits = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _pageId = param1.readInteger();
         _catalogType = param1.readString();
         _layoutCode = param1.readString();
         _localization = new CatalogLocalizationData(param1);
         _offers = new Vector.<CatalogPageMessageOfferData>(0);
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _offers.push(new CatalogPageMessageOfferData(param1));
            _loc3_++;
         }
         _offerId = param1.readInteger();
         _acceptSeasonCurrencyAsCredits = param1.readBoolean();
         if(param1.bytesAvailable)
         {
            _frontPageItems = new Vector.<FrontPageItem>(0);
            _loc2_ = param1.readInteger();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _frontPageItems.push(new FrontPageItem(param1));
               _loc3_++;
            }
         }
         return true;
      }
   }
}

