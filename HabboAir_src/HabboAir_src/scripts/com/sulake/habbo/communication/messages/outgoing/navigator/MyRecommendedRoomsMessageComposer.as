package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class MyRecommendedRoomsMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromMyRecommendedRoomsMessageComposer_Array_1:Array = [];
      
      public function MyRecommendedRoomsMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromMyRecommendedRoomsMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromMyRecommendedRoomsMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

