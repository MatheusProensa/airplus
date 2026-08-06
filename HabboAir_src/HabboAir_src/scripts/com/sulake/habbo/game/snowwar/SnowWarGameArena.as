package com.sulake.habbo.game.snowwar
{
   import com.sulake.habbo.game.snowwar.arena.IDefaultGameStage_1;
   import com.sulake.habbo.game.snowwar.arena.IDefaultGameStage_2;
   import com.sulake.habbo.game.snowwar.arena.SynchronizedGameArena;
   
   public class SnowWarGameArena implements IDefaultGameStage_2
   {
      private var UnknownVarFromSnowWarGameArena_SynchronizedGameArena_1:SynchronizedGameArena;
      
      private var _disposed:Boolean = false;
      
      public function SnowWarGameArena()
      {
         super();
      }
      
      public function dispose() : void
      {
         _disposed = true;
         UnknownVarFromSnowWarGameArena_SynchronizedGameArena_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set gameArena(param1:SynchronizedGameArena) : void
      {
         UnknownVarFromSnowWarGameArena_SynchronizedGameArena_1 = param1;
      }
      
      public function getPulseInterval() : int
      {
         return 50;
      }
      
      public function getNumberOfSubTurns() : int
      {
         return 3;
      }
      
      public function createGameStage() : IDefaultGameStage_1
      {
         return new SnowWarGameStage();
      }
      
      public function pulse() : void
      {
      }
      
      public function isDeathMatch() : Boolean
      {
         return UnknownVarFromSnowWarGameArena_SynchronizedGameArena_1.numberOfTeams == 1;
      }
   }
}

