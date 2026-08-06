package com.sulake.habbo.communication.messages.outgoing.moderator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class PickIssuesMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromPickIssuesMessageComposer_Array_1:Array;
      
      public function PickIssuesMessageComposer(param1:Array, param2:Boolean, param3:int, param4:String)
      {
         var _loc5_:int = 0;
         UnknownVarFromPickIssuesMessageComposer_Array_1 = [];
         super();
         this.UnknownVarFromPickIssuesMessageComposer_Array_1.push(param1.length);
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            this.UnknownVarFromPickIssuesMessageComposer_Array_1.push(param1[_loc5_]);
            _loc5_++;
         }
         this.UnknownVarFromPickIssuesMessageComposer_Array_1.push(param2);
         this.UnknownVarFromPickIssuesMessageComposer_Array_1.push(param3);
         this.UnknownVarFromPickIssuesMessageComposer_Array_1.push(param4);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromPickIssuesMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromPickIssuesMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

