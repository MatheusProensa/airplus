package com.sulake.habbo.communication.messages.outgoing.game.lobby
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class GetUserGameAchievementsMessageComposer implements IMessageComposer
   {
      private var UnknownVarFromGetUserGameAchievementsMessageComposer_Int_1:int;
      
      public function GetUserGameAchievementsMessageComposer(param1:int)
      {
         super();
         UnknownVarFromGetUserGameAchievementsMessageComposer_Int_1 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromGetUserGameAchievementsMessageComposer_Int_1];
      }
      
      public function dispose() : void
      {
      }
   }
}

