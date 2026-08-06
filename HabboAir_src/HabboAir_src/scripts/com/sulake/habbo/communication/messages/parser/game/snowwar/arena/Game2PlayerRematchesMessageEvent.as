package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class Game2PlayerRematchesMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function Game2PlayerRematchesMessageEvent(param1:Function)
      {
         super(param1,Game2PlayerRematchesMessageParser);
      }
      
      public function getParser() : Game2PlayerRematchesMessageParser
      {
         return this._parser as Game2PlayerRematchesMessageParser;
      }
   }
}

