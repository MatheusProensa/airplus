package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.ConditionDefinition;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.IDefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.UnknownIHabboRoomeventsWired_Setup1;
   import com.sulake.habbo.roomevents.wired_setup.conditions.chests.ChestHasAmount;
   import com.sulake.habbo.roomevents.wired_setup.conditions.chests.ChestHasItemTypes;
   
   public class ConditionTypes implements UnknownIHabboRoomeventsWired_Setup1
   {
      private var _types:Array = [];
      
      public function ConditionTypes()
      {
         super();
         this._types.push(new TriggererIsOnFurni());
         this._types.push(new FurnisHaveAvatars());
         this._types.push(new FurnisHaveNoAvatars());
         this._types.push(new StatesMatch());
         this._types.push(new TimeElapsedMore());
         this._types.push(new TimeElapsedLess());
         this._types.push(new UserCountIn());
         this._types.push(new ActorIsInTeam());
         this._types.push(new HasStackedFurnis());
         this._types.push(new StuffTypeMatches());
         this._types.push(new ActorIsGroupMember());
         this._types.push(new ActorIsWearingBadge());
         this._types.push(new ActorIsWearingEffect());
         this._types.push(new DontHaveStackedFurnis());
         this._types.push(new DateRangeActive());
         this._types.push(new ActorHasHandItem());
         this._types.push(new TriggererMatches());
         this._types.push(new TimeMatches());
         this._types.push(new DateMatches());
         this._types.push(new TeamIsWinning());
         this._types.push(new ActorIsPerformingAction());
         this._types.push(new TeamHasScore());
         this._types.push(new ClockTimeMatches());
         this._types.push(new FurniHasAltitude());
         this._types.push(new ActorFacingDirection());
         this._types.push(new InputSourceQuantity());
         this._types.push(new CanPerformMove());
         this._types.push(new HasVariable());
         this._types.push(new VariableValue());
         this._types.push(new VariableAge());
         this._types.push(new LevelMatches());
         this._types.push(new ChestHasAmount());
         this._types.push(new ChestHasItemTypes());
      }
      
      public function get types() : Array
      {
         return _types;
      }
      
      public function getByCode(param1:int) : UnknownIHabboRoomeventsWired_SetupConditions1
      {
         for each(var _loc2_ in _types)
         {
            if(_loc2_.code == param1)
            {
               return _loc2_;
            }
            if(_loc2_.negativeCode == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getElementByCode(param1:int) : IDefaultElement
      {
         return getByCode(param1);
      }
      
      public function acceptTriggerable(param1:Triggerable) : Boolean
      {
         return param1 as ConditionDefinition != null;
      }
      
      public function getKey() : String
      {
         return "condition";
      }
   }
}

