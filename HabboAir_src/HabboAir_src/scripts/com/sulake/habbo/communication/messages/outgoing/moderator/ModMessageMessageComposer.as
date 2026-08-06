package com.sulake.habbo.communication.messages.outgoing.moderator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class ModMessageMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromModMessageMessageComposer_Array_1:Array = [];
      
      public function ModMessageMessageComposer(param1:int, param2:String, param3:int, param4:int)
      {
         super();
         this.UnknownVarFromModMessageMessageComposer_Array_1.push(param1);
         this.UnknownVarFromModMessageMessageComposer_Array_1.push(param2);
         this.UnknownVarFromModMessageMessageComposer_Array_1.push("");
         this.UnknownVarFromModMessageMessageComposer_Array_1.push("");
         this.UnknownVarFromModMessageMessageComposer_Array_1.push(param3);
         if(param4 != -1)
         {
            this.UnknownVarFromModMessageMessageComposer_Array_1.push(param4);
         }
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromModMessageMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromModMessageMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

