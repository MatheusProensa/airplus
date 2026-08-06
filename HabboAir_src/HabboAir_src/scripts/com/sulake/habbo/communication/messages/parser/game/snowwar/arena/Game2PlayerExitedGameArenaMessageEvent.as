package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class Game2PlayerExitedGameArenaMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function Game2PlayerExitedGameArenaMessageEvent(param1:Function)
      {
         super(param1,Game2PlayerExitedGameArenaMessageParser);
      }
      
      public function getParser() : Game2PlayerExitedGameArenaMessageParser
      {
         return this._parser as Game2PlayerExitedGameArenaMessageParser;
      }
   }
}

