package com.sulake.habbo.communication.messages.outgoing.moderator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class ModTradingLockMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      public static const UnknownConstFromModMuteMessageComposer_Int_1:int = -1;
      
      private var UnknownVarFromModTradingLockMessageComposer_Array_1:Array = [];
      
      public function ModTradingLockMessageComposer(param1:int, param2:String, param3:int, param4:int, param5:int)
      {
         super();
         this.UnknownVarFromModTradingLockMessageComposer_Array_1.push(param1);
         this.UnknownVarFromModTradingLockMessageComposer_Array_1.push(param2);
         this.UnknownVarFromModTradingLockMessageComposer_Array_1.push(param3);
         this.UnknownVarFromModTradingLockMessageComposer_Array_1.push(param4);
         if(param5 != -1)
         {
            this.UnknownVarFromModTradingLockMessageComposer_Array_1.push(param5);
         }
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromModTradingLockMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromModTradingLockMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

