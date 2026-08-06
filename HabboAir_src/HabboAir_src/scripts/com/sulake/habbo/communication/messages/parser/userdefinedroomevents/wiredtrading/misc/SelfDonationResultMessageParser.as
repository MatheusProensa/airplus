package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.misc
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class SelfDonationResultMessageParser implements IMessageParser
   {
      public static const UnknownVarFromNftStorePurchaseMessageEventParser_Int_1:int = 0;
      
      public static const UnknownConstFromSelfDonationResultMessageParser_Int_1:int = 1;
      
      public static const UnknownConstFromSelfDonationResultMessageParser_Int_2:int = 2;
      
      private var _resultCode:int;
      
      public function SelfDonationResultMessageParser()
      {
         super();
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function flush() : Boolean
      {
         _resultCode = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _resultCode = param1.readInteger();
         return true;
      }
   }
}

