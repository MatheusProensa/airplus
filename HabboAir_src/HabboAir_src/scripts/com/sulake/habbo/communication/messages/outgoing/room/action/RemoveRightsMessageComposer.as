package com.sulake.habbo.communication.messages.outgoing.room.action
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class RemoveRightsMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromRemoveRightsMessageComposer_Array_1:Array;
      
      public function RemoveRightsMessageComposer(param1:Array)
      {
         var _loc2_:int = 0;
         UnknownVarFromRemoveRightsMessageComposer_Array_1 = [];
         super();
         this.UnknownVarFromRemoveRightsMessageComposer_Array_1.push(param1.length);
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            this.UnknownVarFromRemoveRightsMessageComposer_Array_1.push(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromRemoveRightsMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromRemoveRightsMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

