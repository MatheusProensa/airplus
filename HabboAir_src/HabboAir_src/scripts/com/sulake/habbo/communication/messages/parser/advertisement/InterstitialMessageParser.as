package com.sulake.habbo.communication.messages.parser.advertisement
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class InterstitialMessageParser implements IMessageParser
   {
      private var _canShowInterstitial:Boolean;
      
      public function InterstitialMessageParser()
      {
         super();
      }
      
      public function get canShowInterstitial() : Boolean
      {
         return _canShowInterstitial;
      }
      
      public function flush() : Boolean
      {
         _canShowInterstitial = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _canShowInterstitial = param1.readBoolean();
         return true;
      }
   }
}

