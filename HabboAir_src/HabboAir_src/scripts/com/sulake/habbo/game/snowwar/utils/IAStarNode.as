package com.sulake.habbo.game.snowwar.utils
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.game.snowwar.arena.IGameObject;
   
   public interface IAStarNode extends IComponentInterfaceQueue
   {
      function distanceTo(param1:IAStarNode) : int;
      
      function directionTo(param1:IAStarNode) : Direction8;
      
      function getNodeAt(param1:Direction8) : IAStarNode;
      
      function directionIsBlocked(param1:Direction8, param2:IGameObject) : Boolean;
      
      function getPathCost(param1:Direction8, param2:IGameObject) : int;
      
      function set nodeDirection(param1:Direction8) : void;
      
      function get nodeDirection() : Direction8;
      
      function set parentNode(param1:IAStarNode) : void;
      
      function get parentNode() : IAStarNode;
      
      function set nodeCostFromStart(param1:int) : void;
      
      function get nodeCostFromStart() : int;
      
      function set nodeCostToGoal(param1:int) : void;
      
      function get nodeCostToGoal() : int;
   }
}

