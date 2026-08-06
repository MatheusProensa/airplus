package com.sulake.habbo.communication.messages.outgoing.handshake
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class TryLoginMessageComposer implements IMessageComposer
   {
      private var _username:String;
      
      private var UnknownVarFromTryLoginMessageComposer_String_1:String;
      
      private var UnknownVarFromTryLoginMessageComposer_Int_1:int;
      
      public function TryLoginMessageComposer(param1:String, param2:String, param3:int)
      {
         super();
         _username = param1;
         UnknownVarFromTryLoginMessageComposer_String_1 = param2;
         UnknownVarFromTryLoginMessageComposer_Int_1 = param3;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [];
      }
   }
}

