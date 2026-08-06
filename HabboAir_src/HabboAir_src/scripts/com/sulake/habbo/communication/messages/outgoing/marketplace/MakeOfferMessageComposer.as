package com.sulake.habbo.communication.messages.outgoing.marketplace
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class MakeOfferMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      public static const UnknownConstFromMakeOfferMessageComposer_Int_1:int = 1;
      
      public static const UnknownConstFromMakeOfferMessageComposer_Int_2:int = 2;
      
      private var UnknownVarFromMakeOfferMessageComposer_Array_1:Array = [];
      
      public function MakeOfferMessageComposer(param1:int, param2:int, param3:Vector.<int>)
      {
         super();
         this.UnknownVarFromMakeOfferMessageComposer_Array_1.push(param1);
         this.UnknownVarFromMakeOfferMessageComposer_Array_1.push(param2);
         if(param3 == null)
         {
            this.UnknownVarFromMakeOfferMessageComposer_Array_1.push(0);
            return;
         }
         this.UnknownVarFromMakeOfferMessageComposer_Array_1.push(param3.length);
         for each(var _loc4_ in param3)
         {
            this.UnknownVarFromMakeOfferMessageComposer_Array_1.push(_loc4_);
         }
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromMakeOfferMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromMakeOfferMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

