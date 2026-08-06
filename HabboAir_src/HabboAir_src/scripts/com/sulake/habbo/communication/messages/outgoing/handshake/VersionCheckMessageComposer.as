package com.sulake.habbo.communication.messages.outgoing.handshake
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class VersionCheckMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromVersionCheckMessageComposer_Int_1:int;
      
      private var UnknownVarFromVersionCheckMessageComposer_String_1:String;
      
      private var UnknownVarFromVersionCheckMessageComposer_String_2:String;
      
      public function VersionCheckMessageComposer(param1:int, param2:String, param3:String)
      {
         super();
         UnknownVarFromVersionCheckMessageComposer_Int_1 = param1;
         UnknownVarFromVersionCheckMessageComposer_String_1 = param2;
         UnknownVarFromVersionCheckMessageComposer_String_2 = param3;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromVersionCheckMessageComposer_Int_1,UnknownVarFromVersionCheckMessageComposer_String_1,UnknownVarFromVersionCheckMessageComposer_String_2];
      }
   }
}

