package com.sulake.habbo.communication.messages.outgoing.gifts
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class GetGiftMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      public static const UnknownConstFromModMuteMessageComposer_Int_1:int = -1;
      
      private var UnknownVarFromGetGiftMessageComposer_Array_1:Array = [];
      
      public function GetGiftMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromGetGiftMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromGetGiftMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

