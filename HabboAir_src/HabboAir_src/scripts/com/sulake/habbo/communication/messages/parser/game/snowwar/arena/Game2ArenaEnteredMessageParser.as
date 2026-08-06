package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2PlayerData;
   
   [SecureSWF(rename="true")]
   public class Game2ArenaEnteredMessageParser implements IMessageParser
   {
      private var _player:Game2PlayerData;
      
      public function Game2ArenaEnteredMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         if(_player)
         {
            _player.dispose();
            _player = null;
         }
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _player = new Game2PlayerData();
         _player.parse(param1);
         return true;
      }
      
      public function get player() : Game2PlayerData
      {
         return _player;
      }
   }
}

