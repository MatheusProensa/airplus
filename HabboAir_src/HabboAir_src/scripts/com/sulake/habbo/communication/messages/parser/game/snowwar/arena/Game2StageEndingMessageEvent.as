package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class Game2StageEndingMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function Game2StageEndingMessageEvent(param1:Function)
      {
         super(param1,Game2StageEndingMessageParser);
      }
      
      public function getParser() : Game2StageEndingMessageParser
      {
         return this._parser as Game2StageEndingMessageParser;
      }
   }
}

