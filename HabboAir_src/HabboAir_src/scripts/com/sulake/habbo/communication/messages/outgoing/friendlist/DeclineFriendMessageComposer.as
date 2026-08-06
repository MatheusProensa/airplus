package com.sulake.habbo.communication.messages.outgoing.friendlist
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class DeclineFriendMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromDeclineFriendMessageComposer_Array_1:Array = [];
      
      public function DeclineFriendMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         if(this.UnknownVarFromDeclineFriendMessageComposer_Array_1.length == 0)
         {
            _loc1_.push(true);
            _loc1_.push(0);
         }
         else
         {
            _loc1_.push(false);
            _loc1_.push(this.UnknownVarFromDeclineFriendMessageComposer_Array_1.length);
            _loc2_ = 0;
            while(_loc2_ < this.UnknownVarFromDeclineFriendMessageComposer_Array_1.length)
            {
               _loc1_.push(this.UnknownVarFromDeclineFriendMessageComposer_Array_1[_loc2_]);
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      public function addDeclinedRequest(param1:int) : void
      {
         this.UnknownVarFromDeclineFriendMessageComposer_Array_1.push(param1);
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromDeclineFriendMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

