package com.sulake.habbo.session
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.communication.messages.incoming.users.BlockListMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.BlockUserUpdateMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.BlockListInitComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.BlockUserMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.UnblockUserMessageComposer;
   import flash.utils.Dictionary;
   
   public class BlockedUsersManager implements IComponentInterfaceQueue
   {
      private var _sessionDataManager:SessionDataManager;
      
      private var UnknownVarFromBlockedUsersManager_IMessageEvent_1:IMessageEvent;
      
      private var UnknownVarFromBlockedUsersManager_IMessageEvent_2:IMessageEvent;
      
      private var UnknownVarFromBlockedUsersManager_Dictionary_1:Dictionary;
      
      public function BlockedUsersManager(param1:SessionDataManager)
      {
         super();
         _sessionDataManager = param1;
         UnknownVarFromBlockedUsersManager_Dictionary_1 = new Dictionary();
         if(_sessionDataManager.communication)
         {
            UnknownVarFromBlockedUsersManager_IMessageEvent_1 = _sessionDataManager.communication.addHabboConnectionMessageEvent(new BlockUserUpdateMessageEvent(onBlockUpdate));
            UnknownVarFromBlockedUsersManager_IMessageEvent_2 = _sessionDataManager.communication.addHabboConnectionMessageEvent(new BlockListMessageEvent(onBlockList));
         }
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(_sessionDataManager.communication)
         {
            _sessionDataManager.communication.removeHabboConnectionMessageEvent(UnknownVarFromBlockedUsersManager_IMessageEvent_1);
            _sessionDataManager.communication.removeHabboConnectionMessageEvent(UnknownVarFromBlockedUsersManager_IMessageEvent_2);
         }
         UnknownVarFromBlockedUsersManager_IMessageEvent_1 = null;
         UnknownVarFromBlockedUsersManager_IMessageEvent_2 = null;
         _sessionDataManager = null;
         UnknownVarFromBlockedUsersManager_Dictionary_1 = null;
      }
      
      public function initBlockList() : void
      {
         _sessionDataManager.send(new BlockListInitComposer());
      }
      
      private function onBlockList(param1:BlockListMessageEvent) : void
      {
         UnknownVarFromBlockedUsersManager_Dictionary_1 = new Dictionary();
         var _loc2_:Array = param1.blockedUserIds;
         for each(var _loc3_ in _loc2_)
         {
            UnknownVarFromBlockedUsersManager_Dictionary_1[_loc3_] = true;
         }
      }
      
      private function onBlockUpdate(param1:BlockUserUpdateMessageEvent) : void
      {
         var _loc2_:int = param1.userId;
         switch(param1.result)
         {
            case 0:
               removeUserFromBlockList(_loc2_);
               _sessionDataManager.notifications.addItem("${notification.unblocked_player}","info");
               break;
            case 1:
               addUserToBlockList(_loc2_);
               _sessionDataManager.notifications.addItem("${notification.blocked_player}","info");
         }
      }
      
      private function addUserToBlockList(param1:int) : void
      {
         UnknownVarFromBlockedUsersManager_Dictionary_1[param1] = true;
      }
      
      private function removeUserFromBlockList(param1:int) : void
      {
         delete UnknownVarFromBlockedUsersManager_Dictionary_1[param1];
      }
      
      public function blockUser(param1:int) : void
      {
         _sessionDataManager.send(new BlockUserMessageComposer(param1));
      }
      
      public function unblockUser(param1:int) : void
      {
         _sessionDataManager.send(new UnblockUserMessageComposer(param1));
      }
      
      public function isBlocked(param1:int) : Boolean
      {
         return UnknownVarFromBlockedUsersManager_Dictionary_1 && UnknownVarFromBlockedUsersManager_Dictionary_1[param1];
      }
      
      public function get disposed() : Boolean
      {
         return _sessionDataManager == null;
      }
   }
}

