package com.sulake.habbo.communication.messages.outgoing.moderator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class ModBanMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      public static const UnknownConstFromModMuteMessageComposer_Int_1:int = -1;
      
      private var UnknownVarFromModBanMessageComposer_Array_1:Array = [];
      
      public function ModBanMessageComposer(param1:int, param2:String, param3:int, param4:int, param5:Boolean, param6:int)
      {
         super();
         this.UnknownVarFromModBanMessageComposer_Array_1.push(param1);
         this.UnknownVarFromModBanMessageComposer_Array_1.push(param2);
         this.UnknownVarFromModBanMessageComposer_Array_1.push(param3);
         this.UnknownVarFromModBanMessageComposer_Array_1.push(param4);
         this.UnknownVarFromModBanMessageComposer_Array_1.push(param5);
         if(param6 != -1)
         {
            this.UnknownVarFromModBanMessageComposer_Array_1.push(param6);
         }
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromModBanMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromModBanMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

