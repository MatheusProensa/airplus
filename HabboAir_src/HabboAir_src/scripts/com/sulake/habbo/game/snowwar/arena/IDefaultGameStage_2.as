package com.sulake.habbo.game.snowwar.arena
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   public interface IDefaultGameStage_2 extends IComponentInterfaceQueue
   {
      function createGameStage() : IDefaultGameStage_1;
      
      function set gameArena(param1:SynchronizedGameArena) : void;
      
      function pulse() : void;
      
      function getPulseInterval() : int;
      
      function getNumberOfSubTurns() : int;
   }
}

