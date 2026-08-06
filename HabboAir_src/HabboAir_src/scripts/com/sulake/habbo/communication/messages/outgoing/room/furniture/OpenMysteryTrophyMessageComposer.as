package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class OpenMysteryTrophyMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromOpenMysteryTrophyMessageComposer_Int_1:int;
      
      private var UnknownVarFromOpenMysteryTrophyMessageComposer_String_1:String;
      
      public function OpenMysteryTrophyMessageComposer(param1:int, param2:String)
      {
         super();
         UnknownVarFromOpenMysteryTrophyMessageComposer_Int_1 = param1;
         UnknownVarFromOpenMysteryTrophyMessageComposer_String_1 = param2;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromOpenMysteryTrophyMessageComposer_Int_1,UnknownVarFromOpenMysteryTrophyMessageComposer_String_1];
      }
      
      public function dispose() : void
      {
      }
   }
}

