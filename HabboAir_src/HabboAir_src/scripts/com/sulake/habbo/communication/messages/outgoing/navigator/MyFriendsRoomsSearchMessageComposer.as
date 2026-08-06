package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class MyFriendsRoomsSearchMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromMyFriendsRoomsSearchMessageComposer_Array_1:Array = [];
      
      public function MyFriendsRoomsSearchMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromMyFriendsRoomsSearchMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromMyFriendsRoomsSearchMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

