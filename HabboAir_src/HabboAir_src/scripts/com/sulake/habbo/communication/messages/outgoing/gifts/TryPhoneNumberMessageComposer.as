package com.sulake.habbo.communication.messages.outgoing.gifts
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class TryPhoneNumberMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      public static const UnknownConstFromModMuteMessageComposer_Int_1:int = -1;
      
      private var UnknownVarFromTryPhoneNumberMessageComposer_Array_1:Array = [];
      
      public function TryPhoneNumberMessageComposer(param1:String, param2:String)
      {
         super();
         this.UnknownVarFromTryPhoneNumberMessageComposer_Array_1.push(param1);
         this.UnknownVarFromTryPhoneNumberMessageComposer_Array_1.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromTryPhoneNumberMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromTryPhoneNumberMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

