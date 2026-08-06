package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class ClubGiftData
   {
      private var _offerId:int;
      
      private var _isVip:Boolean;
      
      private var _isSelectable:Boolean;
      
      private var _daysRequired:int;
      
      public function ClubGiftData(param1:IMessageDataWrapper)
      {
         super();
         _offerId = param1.readInteger();
         _isVip = param1.readBoolean();
         _daysRequired = param1.readInteger();
         _isSelectable = param1.readBoolean();
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
      
      public function get isVip() : Boolean
      {
         return _isVip;
      }
      
      public function get isSelectable() : Boolean
      {
         return _isSelectable;
      }
      
      public function get daysRequired() : int
      {
         return _daysRequired;
      }
   }
}

