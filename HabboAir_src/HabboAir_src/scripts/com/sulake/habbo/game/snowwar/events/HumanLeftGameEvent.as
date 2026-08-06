package com.sulake.habbo.game.snowwar.events
{
   import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   
   public class HumanLeftGameEvent extends SnowWarGameEvent
   {
      private var UnknownVarFromHumanLeftGameEvent_HumanGameObject_1:HumanGameObject;
      
      public function HumanLeftGameEvent(param1:HumanGameObject)
      {
         super();
         UnknownVarFromHumanLeftGameEvent_HumanGameObject_1 = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         UnknownVarFromHumanLeftGameEvent_HumanGameObject_1 = null;
      }
      
      override public function apply(param1:SynchronizedGameStage) : void
      {
         param1.putGameObjectOnDeleteList(UnknownVarFromHumanLeftGameEvent_HumanGameObject_1);
         UnknownVarFromHumanLeftGameEvent_HumanGameObject_1.onRemove();
      }
   }
}

