package com.sulake.habbo.game.snowwar.events
{
   import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   
   public class HumanStartsToMakeASnowballEvent extends SnowWarGameEvent
   {
      private var _human:HumanGameObject;
      
      public function HumanStartsToMakeASnowballEvent(param1:HumanGameObject)
      {
         super();
         _human = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _human = null;
      }
      
      override public function apply(param1:SynchronizedGameStage) : void
      {
         _human.startMakingSnowball();
      }
      
      public function get human() : HumanGameObject
      {
         return _human;
      }
   }
}

