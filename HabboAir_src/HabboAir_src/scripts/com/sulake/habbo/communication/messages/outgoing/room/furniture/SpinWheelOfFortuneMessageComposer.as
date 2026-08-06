package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SpinWheelOfFortuneMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromSpinWheelOfFortuneMessageComposer_Int_1:int;
      
      public function SpinWheelOfFortuneMessageComposer(param1:int)
      {
         super();
         UnknownVarFromSpinWheelOfFortuneMessageComposer_Int_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromSpinWheelOfFortuneMessageComposer_Int_1];
      }
   }
}

