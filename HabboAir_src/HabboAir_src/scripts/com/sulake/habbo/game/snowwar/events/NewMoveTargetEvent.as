package com.sulake.habbo.game.snowwar.events
{
   import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   
   public class NewMoveTargetEvent extends SnowWarGameEvent
   {
      private var _humanGameObject:HumanGameObject;
      
      private var _x:int;
      
      private var _y:int;
      
      public function NewMoveTargetEvent(param1:HumanGameObject, param2:int, param3:int)
      {
         super();
         this._humanGameObject = param1;
         this._x = param2;
         this._y = param3;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _humanGameObject = null;
      }
      
      override public function apply(param1:SynchronizedGameStage) : void
      {
         _humanGameObject.changeMoveTarget(_x,_y);
      }
      
      public function get humanGameObject() : HumanGameObject
      {
         return _humanGameObject;
      }
      
      public function get x() : int
      {
         return _x;
      }
      
      public function get y() : int
      {
         return _y;
      }
   }
}

