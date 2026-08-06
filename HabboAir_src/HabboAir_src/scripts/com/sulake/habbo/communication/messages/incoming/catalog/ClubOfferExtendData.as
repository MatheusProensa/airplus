package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class ClubOfferExtendData extends ClubOfferData
   {
      private var UnknownVarFromClubOfferExtendData_Int_1:int;
      
      private var UnknownVarFromClubOfferExtendData_Int_2:int;
      
      private var _originalActivityPointType:int;
      
      private var _subscriptionDaysLeft:int;
      
      public function ClubOfferExtendData(param1:IMessageDataWrapper)
      {
         super(param1);
         UnknownVarFromClubOfferExtendData_Int_1 = param1.readInteger();
         UnknownVarFromClubOfferExtendData_Int_2 = param1.readInteger();
         _originalActivityPointType = param1.readInteger();
         _subscriptionDaysLeft = param1.readInteger();
      }
      
      public function get originalPrice() : int
      {
         return UnknownVarFromClubOfferExtendData_Int_1 * months;
      }
      
      public function get originalActivityPointPrice() : int
      {
         return UnknownVarFromClubOfferExtendData_Int_2 * months;
      }
      
      public function get originalActivityPointType() : int
      {
         return _originalActivityPointType;
      }
      
      public function get discountCreditAmount() : int
      {
         return UnknownVarFromClubOfferExtendData_Int_1 * months - this.priceCredits;
      }
      
      public function get discountActivityPointAmount() : int
      {
         return originalActivityPointPrice * months - this.priceActivityPoints;
      }
      
      public function get subscriptionDaysLeft() : int
      {
         return _subscriptionDaysLeft;
      }
   }
}

