package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class Game2GameRejoinMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function Game2GameRejoinMessageEvent(param1:Function)
      {
         super(param1,Game2GameRejoinMessageParser);
      }
      
      public function getParser() : Game2GameRejoinMessageParser
      {
         return this._parser as Game2GameRejoinMessageParser;
      }
   }
}

