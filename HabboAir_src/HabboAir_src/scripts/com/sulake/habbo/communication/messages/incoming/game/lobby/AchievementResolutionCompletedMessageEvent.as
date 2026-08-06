package com.sulake.habbo.communication.messages.incoming.game.lobby
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.lobby.AchievementResolutionCompletedMessageParser;
   
   [SecureSWF(rename="true")]
   public class AchievementResolutionCompletedMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function AchievementResolutionCompletedMessageEvent(param1:Function)
      {
         super(param1,AchievementResolutionCompletedMessageParser);
      }
      
      public function getParser() : AchievementResolutionCompletedMessageParser
      {
         return this._parser as AchievementResolutionCompletedMessageParser;
      }
   }
}

