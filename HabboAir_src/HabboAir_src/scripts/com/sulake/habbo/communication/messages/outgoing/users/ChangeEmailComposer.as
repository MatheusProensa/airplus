package com.sulake.habbo.communication.messages.outgoing.users
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ChangeEmailComposer implements IMessageComposer
   {
      private var UnknownVarFromChangeEmailComposer_String_1:String;
      
      public function ChangeEmailComposer(param1:String)
      {
         super();
         UnknownVarFromChangeEmailComposer_String_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromChangeEmailComposer_String_1];
      }
   }
}

