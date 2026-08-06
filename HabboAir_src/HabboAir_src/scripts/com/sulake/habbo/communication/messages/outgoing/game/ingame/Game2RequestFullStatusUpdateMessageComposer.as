package com.sulake.habbo.communication.messages.outgoing.game.ingame
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class Game2RequestFullStatusUpdateMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function Game2RequestFullStatusUpdateMessageComposer(param1:int)
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
         _messageArray = [];
      }
   }
}

