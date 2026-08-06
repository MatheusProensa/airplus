package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class AcceptFriendFailureData
   {
      private var UnknownVarFromAcceptFriendFailureData_Int_1:int;
      
      private var _errorCode:int;
      
      public function AcceptFriendFailureData(param1:IMessageDataWrapper)
      {
         super();
         this.UnknownVarFromAcceptFriendFailureData_Int_1 = param1.readInteger();
         this._errorCode = param1.readInteger();
      }
      
      public function get senderId() : int
      {
         return this.UnknownVarFromAcceptFriendFailureData_Int_1;
      }
      
      public function get errorCode() : int
      {
         return this._errorCode;
      }
   }
}

