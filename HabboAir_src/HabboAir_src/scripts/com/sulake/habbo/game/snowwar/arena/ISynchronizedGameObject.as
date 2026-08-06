package com.sulake.habbo.game.snowwar.arena
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   public interface ISynchronizedGameObject extends IGameObject, IComponentInterfaceQueue
   {
      function get isActive() : Boolean;
      
      function set isActive(param1:Boolean) : void;
      
      function get numberOfVariables() : int;
      
      function getVariable(param1:int) : int;
      
      function subturn(param1:SynchronizedGameStage) : void;
      
      function onRemove() : void;
   }
}

