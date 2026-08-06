package com.sulake.habbo.communication.messages.outgoing.help
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetFaqCategoryMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromGetFaqCategoryMessageComposer_Int_1:int;
      
      public function GetFaqCategoryMessageComposer(param1:int)
      {
         super();
         UnknownVarFromGetFaqCategoryMessageComposer_Int_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromGetFaqCategoryMessageComposer_Int_1];
      }
      
      public function dispose() : void
      {
      }
   }
}

