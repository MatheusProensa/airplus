package com.sulake.habbo.communication.messages.outgoing.navigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class CompetitionRoomsSearchMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var UnknownVarFromCompetitionRoomsSearchMessageComposer_Array_1:Array = [];
      
      public function CompetitionRoomsSearchMessageComposer(param1:int, param2:int)
      {
         super();
         this.UnknownVarFromCompetitionRoomsSearchMessageComposer_Array_1.push(param1);
         this.UnknownVarFromCompetitionRoomsSearchMessageComposer_Array_1.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromCompetitionRoomsSearchMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromCompetitionRoomsSearchMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

