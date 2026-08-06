package com.sulake.habbo.communication.messages.outgoing.room.action
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class AmbassadorAlertMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromAmbassadorAlertMessageComposer_Int_1:int;
      
      public function AmbassadorAlertMessageComposer(param1:int)
      {
         super();
         UnknownVarFromAmbassadorAlertMessageComposer_Int_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromAmbassadorAlertMessageComposer_Int_1];
      }
      
      public function dispose() : void
      {
      }
   }
}

