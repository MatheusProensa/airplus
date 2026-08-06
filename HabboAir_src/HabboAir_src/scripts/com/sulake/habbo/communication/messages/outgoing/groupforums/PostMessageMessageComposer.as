package com.sulake.habbo.communication.messages.outgoing.groupforums
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class PostMessageMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromPostMessageMessageComposer_Array_1:Array;
      
      public function PostMessageMessageComposer(param1:int, param2:int, param3:String, param4:String)
      {
         super();
         this.UnknownVarFromPostMessageMessageComposer_Array_1 = [param1,param2,param3,param4];
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromPostMessageMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromPostMessageMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

