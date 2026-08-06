package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class AddFavouriteRoomMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromAddFavouriteRoomMessageComposer_Array_1:Array = [];
      
      public function AddFavouriteRoomMessageComposer(param1:int)
      {
         super();
         this.UnknownVarFromAddFavouriteRoomMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromAddFavouriteRoomMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromAddFavouriteRoomMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

