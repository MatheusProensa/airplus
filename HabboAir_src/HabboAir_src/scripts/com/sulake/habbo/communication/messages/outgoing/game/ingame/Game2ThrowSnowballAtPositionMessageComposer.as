package com.sulake.habbo.communication.messages.outgoing.game.ingame
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class Game2ThrowSnowballAtPositionMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function Game2ThrowSnowballAtPositionMessageComposer(param1:int, param2:int, param3:int, param4:int, param5:int)
      {
         super();
         _messageArray.push(param1);
         _messageArray.push(param2);
         _messageArray.push(param3);
         _messageArray.push(param4);
         _messageArray.push(param5);
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

