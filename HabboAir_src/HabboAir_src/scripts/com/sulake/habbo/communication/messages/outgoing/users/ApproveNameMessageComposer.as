package com.sulake.habbo.communication.messages.outgoing.users
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ApproveNameMessageComposer implements IMessageComposer
   {
      private var _name:String;
      
      private var UnknownVarFromApproveNameMessageComposer_Int_1:int;
      
      public function ApproveNameMessageComposer(param1:String, param2:int)
      {
         super();
         _name = param1;
         UnknownVarFromApproveNameMessageComposer_Int_1 = param2;
      }
      
      public function getMessageArray() : Array
      {
         return [_name,UnknownVarFromApproveNameMessageComposer_Int_1];
      }
      
      public function dispose() : void
      {
      }
   }
}

