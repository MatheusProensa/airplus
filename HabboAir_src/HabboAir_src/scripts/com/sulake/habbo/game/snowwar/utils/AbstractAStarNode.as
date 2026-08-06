package com.sulake.habbo.game.snowwar.utils
{
   import com.sulake.habbo.game.snowwar.arena.IGameObject;
   
   public class AbstractAStarNode implements IAStarNode
   {
      private var _referenceNumber:int = -1;
      
      private var _nodeDirection8:Direction8;
      
      private var _parentNode:IAStarNode;
      
      private var _nodeCostToGoal:int;
      
      private var _nodeCostFromStart:int;
      
      private var _disposed:Boolean = false;
      
      public function AbstractAStarNode()
      {
         super();
      }
      
      public function dispose() : void
      {
         _nodeDirection8 = null;
         _parentNode = null;
         _nodeCostToGoal = 0;
         _nodeCostFromStart = 0;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get nodeDirection() : Direction8
      {
         return _nodeDirection8;
      }
      
      public function set nodeDirection(param1:Direction8) : void
      {
         _nodeDirection8 = param1;
      }
      
      public function get parentNode() : IAStarNode
      {
         return _parentNode;
      }
      
      public function set parentNode(param1:IAStarNode) : void
      {
         this._parentNode = param1;
      }
      
      public function get nodeCostToGoal() : int
      {
         return _nodeCostToGoal;
      }
      
      public function set nodeCostToGoal(param1:int) : void
      {
         this._nodeCostToGoal = param1;
      }
      
      public function get nodeCostFromStart() : int
      {
         return _nodeCostFromStart;
      }
      
      public function set nodeCostFromStart(param1:int) : void
      {
         this._nodeCostFromStart = param1;
      }
      
      public function compareTo(param1:AbstractAStarNode) : int
      {
         var _loc3_:int = _nodeCostFromStart + _nodeCostToGoal;
         var _loc2_:int = param1._nodeCostFromStart + param1._nodeCostToGoal;
         if(_loc3_ < _loc2_)
         {
            return -1;
         }
         if(_loc3_ > _loc2_)
         {
            return 1;
         }
         return 0;
      }
      
      public function distanceTo(param1:IAStarNode) : int
      {
         return 0;
      }
      
      public function directionTo(param1:IAStarNode) : Direction8
      {
         return null;
      }
      
      public function getNodeAt(param1:Direction8) : IAStarNode
      {
         return null;
      }
      
      public function directionIsBlocked(param1:Direction8, param2:IGameObject) : Boolean
      {
         return false;
      }
      
      public function getPathCost(param1:Direction8, param2:IGameObject) : int
      {
         return 0;
      }
   }
}

