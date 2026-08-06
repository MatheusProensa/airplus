package com.sulake.habbo.communication.messages.outgoing.game.score
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class GetWeeklyGameRewardWinnersComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function GetWeeklyGameRewardWinnersComposer(param1:int)
      {
         super();
         _messageArray.push(param1);
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

