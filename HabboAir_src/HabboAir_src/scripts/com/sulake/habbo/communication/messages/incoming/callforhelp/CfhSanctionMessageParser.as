package com.sulake.habbo.communication.messages.incoming.callforhelp
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CfhSanctionMessageParser implements IMessageParser
   {
      private var _issueId:int = -1;
      
      private var _accountId:int = -1;
      
      private var _sanctionType:CfhSanctionTypeData;
      
      public function CfhSanctionMessageParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _issueId = param1.readInteger();
         _accountId = param1.readInteger();
         _sanctionType = new CfhSanctionTypeData(param1);
         return true;
      }
      
      public function get issueId() : int
      {
         return _issueId;
      }
      
      public function get accountId() : int
      {
         return _accountId;
      }
      
      public function get sanctionType() : CfhSanctionTypeData
      {
         return _sanctionType;
      }
      
      public function flush() : Boolean
      {
         _issueId = -1;
         _accountId = -1;
         _sanctionType = null;
         return true;
      }
   }
}

