package com.sulake.habbo.game.snowwar.arena
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   public interface IGameObject extends IComponentInterfaceQueue
   {
      function get gameObjectId() : int;
      
      function get isGhost() : Boolean;
      
      function get ghostObjectId() : int;
   }
}

