package com.sulake.habbo.game.snowwar.arena
{
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLevelData;
   
   public class DefaultGameStage implements IDefaultGameStage_1
   {
      protected var _gameArena:SynchronizedGameArena;
      
      protected var _gameLevelData:GameLevelData;
      
      private var _disposed:Boolean = false;
      
      public function DefaultGameStage()
      {
         super();
      }
      
      public function dispose() : void
      {
         _disposed = true;
         _gameArena = null;
         _gameLevelData = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function initialize(param1:SynchronizedGameArena, param2:GameLevelData) : void
      {
         _gameArena = param1;
         _gameLevelData = param2;
      }
      
      public function get gameArena() : SynchronizedGameArena
      {
         return _gameArena;
      }
      
      public function get gameLevelData() : GameLevelData
      {
         return _gameLevelData;
      }
      
      public function get roomType() : String
      {
         return "";
      }
   }
}

