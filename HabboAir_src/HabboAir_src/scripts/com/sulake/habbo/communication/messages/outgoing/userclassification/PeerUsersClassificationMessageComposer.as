package com.sulake.habbo.communication.messages.outgoing.userclassification
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PeerUsersClassificationMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromPeerUsersClassificationMessageComposer_String_1:String;
      
      public function PeerUsersClassificationMessageComposer(param1:String)
      {
         super();
         UnknownVarFromPeerUsersClassificationMessageComposer_String_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromPeerUsersClassificationMessageComposer_String_1];
      }
      
      public function dispose() : void
      {
         UnknownVarFromPeerUsersClassificationMessageComposer_String_1 = null;
      }
   }
}

