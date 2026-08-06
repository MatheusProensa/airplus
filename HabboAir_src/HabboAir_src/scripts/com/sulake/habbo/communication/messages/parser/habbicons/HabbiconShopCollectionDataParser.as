package com.sulake.habbo.communication.messages.parser.habbicons
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class HabbiconShopCollectionDataParser
   {
      private var UnknownVarFromHabbiconShopCollectionDataParser_UnknownHabboCommunicationMessagesParserHabbicons5_1:UnknownHabboCommunicationMessagesParserHabbicons5;
      
      public function HabbiconShopCollectionDataParser()
      {
         super();
         UnknownVarFromHabbiconShopCollectionDataParser_UnknownHabboCommunicationMessagesParserHabbicons5_1 = new UnknownHabboCommunicationMessagesParserHabbicons5();
      }
      
      public function parse(param1:IMessageDataWrapper) : UnknownHabboCommunicationMessagesParserHabbicons3
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:UnknownHabboCommunicationMessagesParserHabbicons3 = new UnknownHabboCommunicationMessagesParserHabbicons3();
         _loc4_.collectionId = param1.readInteger();
         _loc4_.name = param1.readString();
         _loc4_.completed = param1.readBoolean();
         _loc4_.UnknownVarFromUnknownHabboCommunicationMessagesParserHabbicons3_Int_1 = param1.readInteger();
         _loc4_.UnknownVarFromUnknownHabboCommunicationMessagesParserHabbicons3_Int_2 = param1.readInteger();
         _loc4_.priceCredits = param1.readInteger();
         _loc4_.priceActivityPoints = param1.readInteger();
         _loc4_.activityPointType = param1.readInteger();
         _loc4_.habbicons = [];
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_.habbicons.push(UnknownVarFromHabbiconShopCollectionDataParser_UnknownHabboCommunicationMessagesParserHabbicons5_1.parse(param1));
            _loc3_++;
         }
         return _loc4_;
      }
   }
}

