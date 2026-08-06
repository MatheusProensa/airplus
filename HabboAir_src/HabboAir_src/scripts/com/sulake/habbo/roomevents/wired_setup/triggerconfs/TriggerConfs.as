package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.TriggerDefinition;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.wired_setup.IDefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.UnknownIHabboRoomeventsWired_Setup1;
   
   public class TriggerConfs implements UnknownIHabboRoomeventsWired_Setup1
   {
      private var _confs:Array = [];
      
      public function TriggerConfs()
      {
         super();
         this._confs.push(new AvatarSaysSomething());
         this._confs.push(new UnknownHabboRoomeventsWired_SetupTriggerconfs1());
         this._confs.push(new UnknownHabboRoomeventsWired_SetupTriggerconfs3());
         this._confs.push(new TriggerOnce());
         this._confs.push(new UseStuff());
         this._confs.push(new TriggerPeriodically());
         this._confs.push(new AvatarEntersRoom());
         this._confs.push(new GameStarts());
         this._confs.push(new GameEnds());
         this._confs.push(new ScoreAchieved());
         this._confs.push(new UnknownHabboRoomeventsWired_SetupTriggerconfs4());
         this._confs.push(new UnknownHabboRoomeventsWired_SetupTriggerconfs2());
         this._confs.push(new TriggerPeriodicLong());
         this._confs.push(new BotDestinationReached());
         this._confs.push(new BotAvatarReached());
         this._confs.push(new ClockReachTime());
         this._confs.push(new PerformAction());
         this._confs.push(new ReceiveSignal());
         this._confs.push(new AvatarClicksFurni());
         this._confs.push(new TriggerPeriodicShort());
         this._confs.push(new StateChange());
         this._confs.push(new UnknownHabboRoomeventsWired_SetupTriggerconfs5());
         this._confs.push(new VariableUpdate());
         this._confs.push(new AvatarLeavesRoom());
         this._confs.push(new UserClicksUser());
         this._confs.push(new TransactionCompleted());
         this._confs.push(new TransactionFailed());
      }
      
      public function get confs() : Array
      {
         return _confs;
      }
      
      public function getByCode(param1:int) : UnknownIHabboRoomeventsWired_SetupTriggerconfs1
      {
         for each(var _loc2_ in _confs)
         {
            if(_loc2_.code == param1)
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
         return param1 as TriggerDefinition != null;
      }
      
      public function getKey() : String
      {
         return "trigger";
      }
   }
}

