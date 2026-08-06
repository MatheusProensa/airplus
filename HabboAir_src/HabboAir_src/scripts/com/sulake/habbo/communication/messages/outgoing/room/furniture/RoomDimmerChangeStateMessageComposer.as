package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class RoomDimmerChangeStateMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromRoomDimmerChangeStateMessageComposer_Int_1:int;
      
      public function RoomDimmerChangeStateMessageComposer(param1:int)
      {
         super();
         UnknownVarFromRoomDimmerChangeStateMessageComposer_Int_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromRoomDimmerChangeStateMessageComposer_Int_1];
      }
      
      public function dispose() : void
      {
      }
   }
}

