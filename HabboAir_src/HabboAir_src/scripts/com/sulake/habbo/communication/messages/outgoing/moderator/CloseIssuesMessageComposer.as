package com.sulake.habbo.communication.messages.outgoing.moderator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class CloseIssuesMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromCloseIssuesMessageComposer_Array_1:Array;
      
      public function CloseIssuesMessageComposer(param1:Array, param2:int)
      {
         var _loc3_:int = 0;
         UnknownVarFromCloseIssuesMessageComposer_Array_1 = [];
         super();
         this.UnknownVarFromCloseIssuesMessageComposer_Array_1.push(param2);
         this.UnknownVarFromCloseIssuesMessageComposer_Array_1.push(param1.length);
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            this.UnknownVarFromCloseIssuesMessageComposer_Array_1.push(param1[_loc3_]);
            _loc3_++;
         }
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromCloseIssuesMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromCloseIssuesMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

