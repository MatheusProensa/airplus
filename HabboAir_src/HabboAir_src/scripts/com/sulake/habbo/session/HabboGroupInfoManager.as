package com.sulake.habbo.session
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.incoming.room.session.RoomReadyMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupBadgesMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupBadgesMessageComposer;
   
   public class HabboGroupInfoManager implements IComponentInterfaceQueue
   {
      private var _sessionDataManager:SessionDataManager;
      
      private var _badges:Map;
      
      private var UnknownVarFromHabboGroupInfoManager_IMessageEvent_1:IMessageEvent;
      
      private var UnknownVarFromHabboGroupInfoManager_IMessageEvent_2:IMessageEvent;
      
      public function HabboGroupInfoManager(param1:SessionDataManager)
      {
         super();
         _sessionDataManager = param1;
         _badges = new Map();
         if(_sessionDataManager.communication)
         {
            UnknownVarFromHabboGroupInfoManager_IMessageEvent_1 = _sessionDataManager.communication.addHabboConnectionMessageEvent(new RoomReadyMessageEvent(onRoomReady));
            UnknownVarFromHabboGroupInfoManager_IMessageEvent_2 = _sessionDataManager.communication.addHabboConnectionMessageEvent(new HabboGroupBadgesMessageEvent(onHabboGroupBadges));
         }
      }
      
      public function get disposed() : Boolean
      {
         return _sessionDataManager == null;
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(_sessionDataManager.communication)
         {
            _sessionDataManager.communication.removeHabboConnectionMessageEvent(UnknownVarFromHabboGroupInfoManager_IMessageEvent_1);
            _sessionDataManager.communication.removeHabboConnectionMessageEvent(UnknownVarFromHabboGroupInfoManager_IMessageEvent_2);
         }
         _badges = null;
         _sessionDataManager = null;
      }
      
      private function onRoomReady(param1:IMessageEvent) : void
      {
         _sessionDataManager.send(new GetHabboGroupBadgesMessageComposer());
      }
      
      private function onHabboGroupBadges(param1:HabboGroupBadgesMessageEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Map = param1.badges;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_.getKey(_loc4_);
            _badges.remove(_loc3_);
            _badges.add(_loc3_,_loc2_.getWithIndex(_loc4_));
            _loc4_++;
         }
      }
      
      public function getBadgeId(param1:int) : String
      {
         return _badges.getValue(param1);
      }
   }
}

