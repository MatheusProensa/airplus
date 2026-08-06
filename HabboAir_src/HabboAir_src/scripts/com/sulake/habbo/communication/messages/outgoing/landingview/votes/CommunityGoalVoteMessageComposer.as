package com.sulake.habbo.communication.messages.outgoing.landingview.votes
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class CommunityGoalVoteMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromCommunityGoalVoteMessageComposer_Int_1:int;
      
      public function CommunityGoalVoteMessageComposer(param1:int)
      {
         super();
         this.UnknownVarFromCommunityGoalVoteMessageComposer_Int_1 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromCommunityGoalVoteMessageComposer_Int_1];
      }
   }
}

