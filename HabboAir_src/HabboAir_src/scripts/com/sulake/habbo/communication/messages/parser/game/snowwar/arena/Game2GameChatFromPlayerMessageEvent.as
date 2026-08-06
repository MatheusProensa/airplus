package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class Game2GameChatFromPlayerMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function Game2GameChatFromPlayerMessageEvent(param1:Function)
      {
         super(param1,Game2GameChatFromPlayerMessageParser);
      }
      
      public function getParser() : Game2GameChatFromPlayerMessageParser
      {
         return this._parser as Game2GameChatFromPlayerMessageParser;
      }
   }
}

