package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class Game2StageLoadMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function Game2StageLoadMessageEvent(param1:Function)
      {
         super(param1,Game2StageLoadMessageParser);
      }
      
      public function getParser() : Game2StageLoadMessageParser
      {
         return this._parser as Game2StageLoadMessageParser;
      }
   }
}

