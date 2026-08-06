package com.sulake.habbo.communication.messages.outgoing.competition
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ForwardToRandomCompetitionRoomMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromForwardToRandomCompetitionRoomMessageComposer_Array_1:Array = [];
      
      public function ForwardToRandomCompetitionRoomMessageComposer(param1:String)
      {
         super();
         this.UnknownVarFromForwardToRandomCompetitionRoomMessageComposer_Array_1.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromForwardToRandomCompetitionRoomMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromForwardToRandomCompetitionRoomMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

