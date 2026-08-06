package com.sulake.habbo.communication.messages.outgoing.moderator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class ReleaseIssuesMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromReleaseIssuesMessageComposer_Array_1:Array;
      
      public function ReleaseIssuesMessageComposer(param1:Array)
      {
         var _loc2_:int = 0;
         UnknownVarFromReleaseIssuesMessageComposer_Array_1 = [];
         super();
         this.UnknownVarFromReleaseIssuesMessageComposer_Array_1.push(param1.length);
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            this.UnknownVarFromReleaseIssuesMessageComposer_Array_1.push(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromReleaseIssuesMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromReleaseIssuesMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

