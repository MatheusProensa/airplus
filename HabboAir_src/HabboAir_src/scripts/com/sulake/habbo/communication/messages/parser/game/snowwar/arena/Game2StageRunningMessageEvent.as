package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class Game2StageRunningMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function Game2StageRunningMessageEvent(param1:Function)
      {
         super(param1,Game2StageRunningMessageParser);
      }
      
      public function getParser() : Game2StageRunningMessageParser
      {
         return this._parser as Game2StageRunningMessageParser;
      }
   }
}

