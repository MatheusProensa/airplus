package com.sulake.habbo.communication.messages.parser.talent
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class TalentTrackRewardProduct
   {
      private var _productCode:String;
      
      private var _vipDays:int;
      
      public function TalentTrackRewardProduct(param1:IMessageDataWrapper)
      {
         super();
         _productCode = param1.readString();
         _vipDays = param1.readInteger();
      }
      
      public function get productCode() : String
      {
         return _productCode;
      }
      
      public function get vipDays() : int
      {
         return _vipDays;
      }
   }
}

