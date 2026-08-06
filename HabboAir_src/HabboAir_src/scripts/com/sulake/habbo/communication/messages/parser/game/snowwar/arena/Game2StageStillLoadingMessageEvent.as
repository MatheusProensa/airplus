package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class Game2StageStillLoadingMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function Game2StageStillLoadingMessageEvent(param1:Function)
      {
         super(param1,Game2StageStillLoadingMessageParser);
      }
      
      public function getParser() : Game2StageStillLoadingMessageParser
      {
         return this._parser as Game2StageStillLoadingMessageParser;
      }
   }
}

