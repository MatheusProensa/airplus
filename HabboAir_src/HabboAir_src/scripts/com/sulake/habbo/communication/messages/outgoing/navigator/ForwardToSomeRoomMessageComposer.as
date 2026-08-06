package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ForwardToSomeRoomMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromForwardToSomeRoomMessageComposer_String_1:String;
      
      public function ForwardToSomeRoomMessageComposer(param1:String)
      {
         super();
         UnknownVarFromForwardToSomeRoomMessageComposer_String_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromForwardToSomeRoomMessageComposer_String_1];
      }
      
      public function dispose() : void
      {
         UnknownVarFromForwardToSomeRoomMessageComposer_String_1 = null;
      }
   }
}

