package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PickupObjectMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromPickupObjectMessageComposer_Int_1:int;
      
      private var UnknownVarFromPickupObjectMessageComposer_Int_2:int;
      
      private var UnknownVarFromPickupObjectMessageComposer_Boolean_1:Boolean;
      
      public function PickupObjectMessageComposer(param1:int, param2:int, param3:Boolean = false)
      {
         super();
         UnknownVarFromPickupObjectMessageComposer_Int_1 = param1;
         UnknownVarFromPickupObjectMessageComposer_Int_2 = param2;
         UnknownVarFromPickupObjectMessageComposer_Boolean_1 = param3;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         var _loc1_:int = 0;
         switch(UnknownVarFromPickupObjectMessageComposer_Int_2 - 10)
         {
            case 0:
               _loc1_ = 2;
               break;
            case 10:
               _loc1_ = 1;
               break;
            default:
               return [];
         }
         return [_loc1_,UnknownVarFromPickupObjectMessageComposer_Int_1,UnknownVarFromPickupObjectMessageComposer_Boolean_1];
      }
   }
}

