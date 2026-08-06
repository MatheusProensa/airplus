package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class Game2ArenaEnteredMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function Game2ArenaEnteredMessageEvent(param1:Function)
      {
         super(param1,Game2ArenaEnteredMessageParser);
      }
      
      public function getParser() : Game2ArenaEnteredMessageParser
      {
         return this._parser as Game2ArenaEnteredMessageParser;
      }
   }
}

