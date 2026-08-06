package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class Game2EnterArenaFailedMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function Game2EnterArenaFailedMessageEvent(param1:Function)
      {
         super(param1,Game2EnterArenaFailedMessageParser);
      }
      
      public function getParser() : Game2EnterArenaFailedMessageParser
      {
         return this._parser as Game2EnterArenaFailedMessageParser;
      }
   }
}

