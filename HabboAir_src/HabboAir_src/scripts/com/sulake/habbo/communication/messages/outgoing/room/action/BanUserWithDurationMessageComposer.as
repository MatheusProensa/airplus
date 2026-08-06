package com.sulake.habbo.communication.messages.outgoing.room.action
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class BanUserWithDurationMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromBanUserWithDurationMessageComposer_Int_1:int;
      
      private var UnknownVarFromBanUserWithDurationMessageComposer_Int_2:int = 0;
      
      private var UnknownVarFromBanUserWithDurationMessageComposer_String_1:String;
      
      public function BanUserWithDurationMessageComposer(param1:int, param2:String, param3:int = 0)
      {
         super();
         UnknownVarFromBanUserWithDurationMessageComposer_Int_1 = param1;
         UnknownVarFromBanUserWithDurationMessageComposer_Int_2 = param3;
         UnknownVarFromBanUserWithDurationMessageComposer_String_1 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromBanUserWithDurationMessageComposer_Int_1,UnknownVarFromBanUserWithDurationMessageComposer_Int_2,UnknownVarFromBanUserWithDurationMessageComposer_String_1];
      }
   }
}

