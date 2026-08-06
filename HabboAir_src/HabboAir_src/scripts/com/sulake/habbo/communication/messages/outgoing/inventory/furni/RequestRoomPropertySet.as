package com.sulake.habbo.communication.messages.outgoing.inventory.furni
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class RequestRoomPropertySet implements IMessageComposer
   {
      private var UnknownVarFromRequestRoomPropertySet_Int_1:int = 0;
      
      public function RequestRoomPropertySet(param1:int)
      {
         super();
         UnknownVarFromRequestRoomPropertySet_Int_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(UnknownVarFromRequestRoomPropertySet_Int_1);
         return _loc1_;
      }
   }
}

