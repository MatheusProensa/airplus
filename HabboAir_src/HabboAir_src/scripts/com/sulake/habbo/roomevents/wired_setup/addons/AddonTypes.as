package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.AddonDefinition;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.IDefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.UnknownIHabboRoomeventsWired_Setup1;
   import com.sulake.habbo.roomevents.wired_setup.addons.chests.ChestItemTypeScanner;
   import com.sulake.habbo.roomevents.wired_setup.addons.chests.CustomContract;
   
   public class AddonTypes implements UnknownIHabboRoomeventsWired_Setup1
   {
      private var _types:Array = [];
      
      public function AddonTypes()
      {
         super();
         this._types.push(new ConditionEvaluation());
         this._types.push(new PickOneRandomlyPropagation());
         this._types.push(new UnknownHabboRoomeventsWired_SetupAddons1());
         this._types.push(new ExceedExecutions());
         this._types.push(new NoMoveAnimation());
         this._types.push(new MovePhysics());
         this._types.push(new CarryUsers());
         this._types.push(new AnimationTime());
         this._types.push(new FurniSelectorFilter());
         this._types.push(new UserSelectorFilter());
         this._types.push(new FurniVariableFilter());
         this._types.push(new UserVariableFilter());
         this._types.push(new UsernamePlaceholderAddon());
         this._types.push(new VariablePlaceholderAddon());
         this._types.push(new VariableCapturerAddon());
         this._types.push(new ExecuteInOrder());
         this._types.push(new ChestItemTypeScanner());
         this._types.push(new FurniNamePlaceholderAddon());
         this._types.push(new CustomContract());
         this._types.push(new ProjectileAddon());
         this._types.push(new JumpStrengthAddon());
         this._types.push(new VariableTextConnectorAddon());
         this._types.push(new VariableLvlUpAddon());
         this._types.push(new VariableTimeUtilAddon());
         this._types.push(new GlobalPlaceholderAddon());
         this._types.push(new AchievementEnablerAddon());
      }
      
      public function getElementByCode(param1:int) : IDefaultElement
      {
         for each(var _loc2_ in _types)
         {
            if(_loc2_.code == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getKey() : String
      {
         return "addon";
      }
      
      public function acceptTriggerable(param1:Triggerable) : Boolean
      {
         return param1 as AddonDefinition != null;
      }
   }
}

