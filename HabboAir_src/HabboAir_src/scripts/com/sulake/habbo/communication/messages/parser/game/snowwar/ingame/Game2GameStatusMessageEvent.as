package com.sulake.habbo.communication.messages.parser.game.snowwar.ingame
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class Game2GameStatusMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function Game2GameStatusMessageEvent(param1:Function)
      {
         super(param1,Game2GameStatusMessageParser);
      }
      
      public function getParser() : Game2GameStatusMessageParser
      {
         return this._parser as Game2GameStatusMessageParser;
      }
   }
}

