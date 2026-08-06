package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class Game2EnterArenaMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function Game2EnterArenaMessageEvent(param1:Function)
      {
         super(param1,Game2EnterArenaMessageParser);
      }
      
      public function getParser() : Game2EnterArenaMessageParser
      {
         return this._parser as Game2EnterArenaMessageParser;
      }
   }
}

