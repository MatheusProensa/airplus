package com.sulake.habbo.communication.messages.outgoing.competition
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ForwardToACompetitionRoomMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromForwardToACompetitionRoomMessageComposer_Array_1:Array = [];
      
      public function ForwardToACompetitionRoomMessageComposer(param1:String, param2:int)
      {
         super();
         this.UnknownVarFromForwardToACompetitionRoomMessageComposer_Array_1.push(param1);
         this.UnknownVarFromForwardToACompetitionRoomMessageComposer_Array_1.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return this.UnknownVarFromForwardToACompetitionRoomMessageComposer_Array_1;
      }
      
      public function dispose() : void
      {
         this.UnknownVarFromForwardToACompetitionRoomMessageComposer_Array_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

