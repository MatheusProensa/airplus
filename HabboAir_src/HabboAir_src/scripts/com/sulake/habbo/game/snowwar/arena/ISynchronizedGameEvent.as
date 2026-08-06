package com.sulake.habbo.game.snowwar.arena
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   public interface ISynchronizedGameEvent extends IComponentInterfaceQueue
   {
      function apply(param1:SynchronizedGameStage) : void;
   }
}

