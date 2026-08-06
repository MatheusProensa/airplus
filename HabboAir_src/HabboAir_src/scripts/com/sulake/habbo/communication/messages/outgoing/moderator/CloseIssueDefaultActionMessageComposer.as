package com.sulake.habbo.communication.messages.outgoing.moderator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class CloseIssueDefaultActionMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromCloseIssueDefaultActionMessageComposer_Array_1:Array;
      
      public function CloseIssueDefaultActionMessageComposer(param1:int, param2:Array, param3:int)
      {
         var _loc4_:int = 0;
         UnknownVarFromCloseIssueDefaultActionMessageComposer_Array_1 = [];
         super();
         this.UnknownVarFromCloseIssueDefaultActionMessageComposer_Array_1.push(param1);
         this.UnknownVarFromCloseIssueDefaultActionMessageComposer_Array_1.push(param2.length);
         _loc4_ = 0;
         while(_loc4_ < param2.length)
         {
            this.UnknownVarFromCloseIssueDefaultActionMessageComposer_Array_1.push(param2[_loc4_]);
            _loc4_++;
         }
         this.UnknownVarFromCloseIssueDefaultActionMessageComposer_Array_1.push(param3);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromCloseIssueDefaultActionMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromCloseIssueDefaultActionMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

