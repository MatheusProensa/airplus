package com.sulake.habbo.communication.messages.outgoing.moderator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class DefaultSanctionMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromDefaultSanctionMessageComposer_Array_1:Array = [];
      
      public function DefaultSanctionMessageComposer(param1:int, param2:int, param3:String, param4:int)
      {
         super();
         this.UnknownVarFromDefaultSanctionMessageComposer_Array_1.push(param1);
         this.UnknownVarFromDefaultSanctionMessageComposer_Array_1.push(param2);
         this.UnknownVarFromDefaultSanctionMessageComposer_Array_1.push(param3);
         if(param4 != -1)
         {
            this.UnknownVarFromDefaultSanctionMessageComposer_Array_1.push(param4);
         }
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromDefaultSanctionMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromDefaultSanctionMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

