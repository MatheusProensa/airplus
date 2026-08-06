package com.sulake.habbo.game.snowwar.events
{
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   
   public class HumanThrowsSnowballAtPositionEvent extends SnowWarGameEvent
   {
      private var _human:HumanGameObject;
      
      private var _targetX:int;
      
      private var _targetY:int;
      
      private var _trajectory:int;
      
      public function HumanThrowsSnowballAtPositionEvent(param1:HumanGameObject, param2:int, param3:int, param4:int)
      {
         super();
         this._human = param1;
         this._targetX = param2;
         this._targetY = param3;
         this._trajectory = param4;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _human = null;
      }
      
      override public function apply(param1:SynchronizedGameStage) : void
      {
         human.throwSnowball(targetX,targetY);
         human.startThrowTimer();
         SnowWarEngine.playSound("HBSTG_snowwar_throw");
      }
      
      public function get human() : HumanGameObject
      {
         return _human;
      }
      
      public function get targetX() : int
      {
         return _targetX;
      }
      
      public function get targetY() : int
      {
         return _targetY;
      }
      
      public function get trajectory() : int
      {
         return _trajectory;
      }
   }
}

