package com.sulake.habbo.communication.messages.outgoing.gifts
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class ResetPhoneNumberStateMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromResetPhoneNumberStateMessageComposer_Array_1:Array = [];
      
      public function ResetPhoneNumberStateMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromResetPhoneNumberStateMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromResetPhoneNumberStateMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

