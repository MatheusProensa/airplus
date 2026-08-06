package com.sulake.habbo.communication.messages.outgoing.friendlist
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class AcceptFriendMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromAcceptFriendMessageComposer_Array_1:Array = [];
      
      public function AcceptFriendMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         _loc1_.push(this.UnknownVarFromAcceptFriendMessageComposer_Array_1.length);
         _loc2_ = 0;
         while(_loc2_ < this.UnknownVarFromAcceptFriendMessageComposer_Array_1.length)
         {
            _loc1_.push(this.UnknownVarFromAcceptFriendMessageComposer_Array_1[_loc2_]);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function addAcceptedRequest(param1:int) : void
      {
         this.UnknownVarFromAcceptFriendMessageComposer_Array_1.push(param1);
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromAcceptFriendMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

