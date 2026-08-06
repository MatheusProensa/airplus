package com.sulake.habbo.communication.messages.outgoing.mysterybox
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class MysteryBoxWaitingCanceledMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromMysteryBoxWaitingCanceledMessageComposer_Array_1:Array = [];
      
      public function MysteryBoxWaitingCanceledMessageComposer(param1:int)
      {
         super();
         this.UnknownVarFromMysteryBoxWaitingCanceledMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromMysteryBoxWaitingCanceledMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromMysteryBoxWaitingCanceledMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

