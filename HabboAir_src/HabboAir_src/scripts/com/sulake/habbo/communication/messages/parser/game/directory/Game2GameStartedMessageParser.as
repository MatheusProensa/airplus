package com.sulake.habbo.communication.messages.parser.game.directory
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyData;
   
   [SecureSWF(rename="true")]
   public class Game2GameStartedMessageParser implements IMessageParser
   {
      private var _lobbyData:GameLobbyData;
      
      public function Game2GameStartedMessageParser()
      {
         super();
      }
      
      public function get lobbyData() : GameLobbyData
      {
         return _lobbyData;
      }
      
      public function flush() : Boolean
      {
         _lobbyData = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _lobbyData = new GameLobbyData(param1);
         return true;
      }
   }
}

