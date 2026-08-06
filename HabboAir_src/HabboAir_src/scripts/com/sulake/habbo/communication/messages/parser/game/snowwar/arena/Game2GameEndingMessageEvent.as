package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class Game2GameEndingMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function Game2GameEndingMessageEvent(param1:Function)
      {
         super(param1,Game2GameEndingMessageParser);
      }
      
      public function getParser() : Game2GameEndingMessageParser
      {
         return this._parser as Game2GameEndingMessageParser;
      }
   }
}

