package com.sulake.habbo.communication.messages.outgoing.game.arena
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class Game2PlayAgainMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function Game2PlayAgainMessageComposer()
      {
         super();
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

