package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class EnterOneWayDoorMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromEnterOneWayDoorMessageComposer_Int_1:int;
      
      public function EnterOneWayDoorMessageComposer(param1:int)
      {
         super();
         UnknownVarFromEnterOneWayDoorMessageComposer_Int_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromEnterOneWayDoorMessageComposer_Int_1];
      }
   }
}

