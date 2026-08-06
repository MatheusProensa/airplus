package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class RoomDimmerGetPresetsMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromRoomDimmerGetPresetsMessageComposer_Int_1:int;
      
      public function RoomDimmerGetPresetsMessageComposer(param1:int)
      {
         super();
         UnknownVarFromRoomDimmerGetPresetsMessageComposer_Int_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromRoomDimmerGetPresetsMessageComposer_Int_1];
      }
   }
}

