package com.sulake.habbo.communication.messages.parser.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.catalog.ClubOfferExtendData;
   
   [SecureSWF(rename="true")]
   public class HabboClubExtendOfferMessageParser implements IMessageParser
   {
      private var _offer:ClubOfferExtendData;
      
      public function HabboClubExtendOfferMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _offer = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _offer = new ClubOfferExtendData(param1);
         return true;
      }
      
      public function offer() : ClubOfferExtendData
      {
         return _offer;
      }
   }
}

