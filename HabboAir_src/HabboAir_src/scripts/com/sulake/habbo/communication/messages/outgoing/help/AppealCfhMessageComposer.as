package com.sulake.habbo.communication.messages.outgoing.help
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class AppealCfhMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromAppealCfhMessageComposer_Int_1:int;
      
      public function AppealCfhMessageComposer(param1:int)
      {
         super();
         UnknownVarFromAppealCfhMessageComposer_Int_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromAppealCfhMessageComposer_Int_1];
      }
      
      public function dispose() : void
      {
      }
   }
}

