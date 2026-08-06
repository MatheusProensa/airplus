package com.sulake.habbo.communication.messages.parser.peerservice
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class HasClaimedProductResponseParser implements IMessageParser
   {
      private var _claimId:String;
      
      private var _hasClaimed:Boolean;
      
      public function HasClaimedProductResponseParser()
      {
         super();
      }
      
      public function get claimId() : String
      {
         return _claimId;
      }
      
      public function get hasClaimed() : Boolean
      {
         return _hasClaimed;
      }
      
      public function flush() : Boolean
      {
         _claimId = null;
         _hasClaimed = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _claimId = param1.readString();
         _hasClaimed = param1.readBoolean();
         return true;
      }
   }
}

