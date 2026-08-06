package com.sulake.habbo.communication.messages.outgoing.moderator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class ModToolSanctionComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromModToolSanctionComposer_Array_1:Array = [];
      
      public function ModToolSanctionComposer(param1:int, param2:int, param3:int)
      {
         super();
         this.UnknownVarFromModToolSanctionComposer_Array_1.push(param1);
         this.UnknownVarFromModToolSanctionComposer_Array_1.push(param2);
         this.UnknownVarFromModToolSanctionComposer_Array_1.push(param3);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromModToolSanctionComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromModToolSanctionComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

