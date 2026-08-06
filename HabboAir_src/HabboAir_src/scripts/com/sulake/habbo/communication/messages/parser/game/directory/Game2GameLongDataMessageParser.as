package com.sulake.habbo.communication.messages.parser.game.directory
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyData;
   
   [SecureSWF(rename="true")]
   public class Game2GameLongDataMessageParser implements IMessageParser
   {
      private var _gameLobbyData:GameLobbyData;
      
      public function Game2GameLongDataMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return false;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _gameLobbyData = new GameLobbyData(param1);
         return true;
      }
      
      public function get gameLobbyData() : GameLobbyData
      {
         return _gameLobbyData;
      }
   }
}

