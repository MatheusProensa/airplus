package com.sulake.habbo.communication.messages.parser.game.snowwar.ingame
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class Game2FullGameStatusMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function Game2FullGameStatusMessageEvent(param1:Function)
      {
         super(param1,Game2FullGameStatusMessageParser);
      }
      
      public function getParser() : Game2FullGameStatusMessageParser
      {
         return this._parser as Game2FullGameStatusMessageParser;
      }
   }
}

