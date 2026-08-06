package com.sulake.habbo.communication.messages.outgoing.game.score
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class Game2GetWeeklyFriendsLeaderboardComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function Game2GetWeeklyFriendsLeaderboardComposer(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int)
      {
         super();
         _messageArray.push(param1);
         _messageArray.push(param2);
         _messageArray.push(param3);
         _messageArray.push(param4);
         _messageArray.push(param5);
         _messageArray.push(param6);
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

