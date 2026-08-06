package com.sulake.habbo.communication.messages.outgoing.groupforums
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class UpdateThreadMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromUpdateThreadMessageComposer_Array_1:Array = [];
      
      public function UpdateThreadMessageComposer(param1:int, param2:int, param3:Boolean, param4:Boolean)
      {
         super();
         this.UnknownVarFromUpdateThreadMessageComposer_Array_1 = [param1,param2,param4,param3];
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromUpdateThreadMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromUpdateThreadMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function unwatch(param1:String) : void
      {
         super.unwatch(param1);
      }
   }
}

