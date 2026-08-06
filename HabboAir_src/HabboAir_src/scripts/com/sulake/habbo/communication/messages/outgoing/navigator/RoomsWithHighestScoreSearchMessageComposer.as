package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class RoomsWithHighestScoreSearchMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromRoomsWithHighestScoreSearchMessageComposer_Array_1:Array = [];
      
      public function RoomsWithHighestScoreSearchMessageComposer(param1:int)
      {
         super();
         this.UnknownVarFromRoomsWithHighestScoreSearchMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromRoomsWithHighestScoreSearchMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromRoomsWithHighestScoreSearchMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

