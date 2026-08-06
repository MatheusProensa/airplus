package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class Game2StageStartingMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function Game2StageStartingMessageEvent(param1:Function)
      {
         super(param1,Game2StageStartingMessageParser);
      }
      
      public function getParser() : Game2StageStartingMessageParser
      {
         return this._parser as Game2StageStartingMessageParser;
      }
   }
}

