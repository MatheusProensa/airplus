package com.sulake.habbo.communication.messages.outgoing.gifts
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class VerifyCodeMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      public static const UnknownConstFromModMuteMessageComposer_Int_1:int = -1;
      
      private var UnknownVarFromVerifyCodeMessageComposer_Array_1:Array = [];
      
      public function VerifyCodeMessageComposer(param1:String)
      {
         super();
         this.UnknownVarFromVerifyCodeMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromVerifyCodeMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromVerifyCodeMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

