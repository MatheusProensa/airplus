package com.sulake.habbo.game.snowwar.events
{
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.SnowballGivingGameObject;
   
   public class HumanGetsSnowballsFromMachineEvent extends SnowWarGameEvent
   {
      private var _human:HumanGameObject;
      
      private var UnknownVarFromHumanGetsSnowballsFromMachineEvent_SnowballGivingGameObject_1:SnowballGivingGameObject;
      
      public function HumanGetsSnowballsFromMachineEvent(param1:HumanGameObject, param2:SnowballGivingGameObject)
      {
         super();
         _human = param1;
         UnknownVarFromHumanGetsSnowballsFromMachineEvent_SnowballGivingGameObject_1 = param2;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _human = null;
         UnknownVarFromHumanGetsSnowballsFromMachineEvent_SnowballGivingGameObject_1 = null;
      }
      
      override public function apply(param1:SynchronizedGameStage) : void
      {
         var _loc3_:int = 0;
         var _loc2_:HumanGameObject = null;
         var _loc4_:int = _human.getRemainingSnowballCapacity();
         if(_loc4_ > 0)
         {
            _loc3_ = UnknownVarFromHumanGetsSnowballsFromMachineEvent_SnowballGivingGameObject_1.pickupSnowballs(1);
            if(_loc3_ > 0)
            {
               _human.addSnowballs(_loc3_);
               _loc2_ = param1.getGameObject(_human.ghostObjectId) as HumanGameObject;
               if(_loc2_)
               {
                  _loc2_.addSnowballs(_loc3_);
               }
               SnowWarEngine.playSound("HBSTG_snowwar_get_snowball");
            }
         }
      }
      
      public function get human() : HumanGameObject
      {
         return _human;
      }
   }
}

