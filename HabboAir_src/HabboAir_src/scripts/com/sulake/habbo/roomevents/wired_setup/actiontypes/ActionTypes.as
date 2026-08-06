package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.ActionDefinition;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.IDefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.UnknownIHabboRoomeventsWired_Setup1;
   import com.sulake.habbo.roomevents.wired_setup.actiontypes.chests.CancelTransaction;
   import com.sulake.habbo.roomevents.wired_setup.actiontypes.chests.GiveCurrencyFromChest;
   import com.sulake.habbo.roomevents.wired_setup.actiontypes.chests.GiveItemsFromChest;
   import com.sulake.habbo.roomevents.wired_setup.actiontypes.chests.InitiateTransaction;
   
   public class ActionTypes implements UnknownIHabboRoomeventsWired_Setup1
   {
      private var _types:Array = [];
      
      public function ActionTypes()
      {
         super();
         this._types.push(new ToggleFurniState());
         this._types.push(new Reset());
         this._types.push(new SetFurniStateTo());
         this._types.push(new MoveFurni());
         this._types.push(new GiveScore());
         this._types.push(new Chat());
         this._types.push(new Teleport());
         this._types.push(new JoinTeam());
         this._types.push(new LeaveTeam());
         this._types.push(new Chase());
         this._types.push(new Flee());
         this._types.push(new MoveToDirection());
         this._types.push(new GiveScoreToPredefinedTeam());
         this._types.push(new ToggleToRandomState());
         this._types.push(new MoveFurniTo());
         this._types.push(new GiveReward());
         this._types.push(new CallAnotherStack());
         this._types.push(new KickFromRoom());
         this._types.push(new MuteUser());
         this._types.push(new BotTeleport());
         this._types.push(new BotMove());
         this._types.push(new BotTalk());
         this._types.push(new BotGiveHandItem());
         this._types.push(new BotFollowAvatar());
         this._types.push(new BotChangeFigure());
         this._types.push(new BotTalkDirectToAvatar());
         this._types.push(new ControlClock());
         this._types.push(new SetFurniAltitude());
         this._types.push(new SendSignal());
         this._types.push(new FreezeUser());
         this._types.push(new UnfreezeUser());
         this._types.push(new RelativeFurniMove());
         this._types.push(new MoveFurniToFurni());
         this._types.push(new MoveFurniToUser());
         this._types.push(new AdjustClock());
         this._types.push(new GiveVariable());
         this._types.push(new RemoveVariable());
         this._types.push(new ChangeVariable());
         this._types.push(new MoveUser());
         this._types.push(new MoveUserToFurni());
         this._types.push(new TeleportToRoom());
         this._types.push(new GiveCurrencyFromChest());
         this._types.push(new GiveItemsFromChest());
         this._types.push(new InitiateTransaction());
         this._types.push(new CancelTransaction());
         this._types.push(new WriteToLogs());
         this._types.push(new ProgressAchievement());
         this._types.push(new GiveEffect());
         this._types.push(new OverrideHeight());
         this._types.push(new SetClickSettings());
         this._types.push(new PlaceFurni());
         this._types.push(new RemoveFurni());
         this._types.push(new MoveAsGroup());
         this._types.push(new ProgressRewardTrack());
         this._types.push(new ResetRewardTrack());
      }
      
      public function get types() : Array
      {
         return _types;
      }
      
      public function getByCode(param1:int) : ActionType
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
         return param1 as ActionDefinition != null;
      }
      
      public function getKey() : String
      {
         return "action";
      }
   }
}

