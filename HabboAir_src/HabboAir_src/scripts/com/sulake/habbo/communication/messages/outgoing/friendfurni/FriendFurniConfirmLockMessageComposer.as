package com.sulake.habbo.communication.messages.outgoing.friendfurni
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class FriendFurniConfirmLockMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromFriendFurniConfirmLockMessageComposer_Array_1:Array = [];
      
      public function FriendFurniConfirmLockMessageComposer(param1:int, param2:Boolean)
      {
         super();
         UnknownVarFromFriendFurniConfirmLockMessageComposer_Array_1.push(param1);
         UnknownVarFromFriendFurniConfirmLockMessageComposer_Array_1.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromFriendFurniConfirmLockMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromFriendFurniConfirmLockMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

