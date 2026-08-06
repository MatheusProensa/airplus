package com.sulake.habbo.game.snowwar.events
{
   import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;
   import com.sulake.habbo.game.snowwar.gameobjects.SnowballMachineGameObject;
   
   public class MachineCreatesSnowballEvent extends SnowWarGameEvent
   {
      private var UnknownVarFromMachineCreatesSnowballEvent_SnowballMachineGameObject_1:SnowballMachineGameObject;
      
      public function MachineCreatesSnowballEvent(param1:SnowballMachineGameObject)
      {
         super();
         UnknownVarFromMachineCreatesSnowballEvent_SnowballMachineGameObject_1 = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         UnknownVarFromMachineCreatesSnowballEvent_SnowballMachineGameObject_1 = null;
      }
      
      override public function apply(param1:SynchronizedGameStage) : void
      {
         if(UnknownVarFromMachineCreatesSnowballEvent_SnowballMachineGameObject_1)
         {
            UnknownVarFromMachineCreatesSnowballEvent_SnowballMachineGameObject_1.createSnowball();
         }
         else
         {
            HabboGamesCom.log("Too early for this stuff..");
         }
      }
   }
}

