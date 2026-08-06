package com.sulake.habbo.communication.messages.parser.peerservice
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ClaimProductResultParser implements IMessageParser
   {
      private var _claimId:String;
      
      private var _result:int;
      
      public function ClaimProductResultParser()
      {
         super();
      }
      
      public function get claimId() : String
      {
         return _claimId;
      }
      
      public function get result() : int
      {
         return _result;
      }
      
      public function flush() : Boolean
      {
         _claimId = null;
         _result = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _claimId = param1.readString();
         _result = param1.readInteger();
         return true;
      }
   }
}

