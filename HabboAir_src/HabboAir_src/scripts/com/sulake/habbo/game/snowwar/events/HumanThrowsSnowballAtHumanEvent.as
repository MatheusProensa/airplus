package com.sulake.habbo.game.snowwar.events
{
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   
   public class HumanThrowsSnowballAtHumanEvent extends SnowWarGameEvent
   {
      private var _human:HumanGameObject;
      
      private var _targetHuman:HumanGameObject;
      
      private var _trajectory:int;
      
      public function HumanThrowsSnowballAtHumanEvent(param1:HumanGameObject, param2:HumanGameObject, param3:int)
      {
         super();
         _human = param1;
         _targetHuman = param2;
         _trajectory = param3;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _human = null;
         _targetHuman = null;
         _trajectory = 0;
      }
      
      override public function apply(param1:SynchronizedGameStage) : void
      {
         human.throwSnowball(_targetHuman.currentLocation.x,_targetHuman.currentLocation.y);
         human.startThrowTimer();
         SnowWarEngine.playSound("HBSTG_snowwar_throw");
      }
      
      public function get human() : HumanGameObject
      {
         return _human;
      }
      
      public function get targetHuman() : HumanGameObject
      {
         return _targetHuman;
      }
      
      public function get trajectory() : int
      {
         return _trajectory;
      }
   }
}

