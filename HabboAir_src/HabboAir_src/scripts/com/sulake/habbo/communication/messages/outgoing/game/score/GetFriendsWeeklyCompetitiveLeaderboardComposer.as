package com.sulake.habbo.communication.messages.outgoing.game.score
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class GetFriendsWeeklyCompetitiveLeaderboardComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function GetFriendsWeeklyCompetitiveLeaderboardComposer(param1:int, param2:int)
      {
         super();
         _messageArray.push(param1);
         _messageArray.push(param2);
      }
      
      public function getMessageArray() : Array
      {
         return _messageArray;
      }
      
      public function dispose() : void
      {
         _messageArray = null;
      }
   }
}

