package com.sulake.habbo.session
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.communication.messages.incoming.users.IgnoreResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.IgnoredUsersMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.users.GetIgnoredUsersMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.IgnoreUserMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.UnignoreUserMessageComposer;
   
   public class IgnoredUsersManager implements IComponentInterfaceQueue
   {
      private var _sessionDataManager:SessionDataManager;
      
      private var UnknownVarFromIgnoredUsersManager_IMessageEvent_1:IMessageEvent;
      
      private var UnknownVarFromIgnoredUsersManager_IMessageEvent_2:IMessageEvent;
      
      private var UnknownVarFromIgnoredUsersManager_Array_1:Array = [];
      
      public function IgnoredUsersManager(param1:SessionDataManager)
      {
         super();
         _sessionDataManager = param1;
         if(_sessionDataManager.communication)
         {
            UnknownVarFromIgnoredUsersManager_IMessageEvent_1 = _sessionDataManager.communication.addHabboConnectionMessageEvent(new IgnoreResultMessageEvent(onIgnoreResult));
            UnknownVarFromIgnoredUsersManager_IMessageEvent_2 = _sessionDataManager.communication.addHabboConnectionMessageEvent(new IgnoredUsersMessageEvent(onIgnoreList));
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
            _sessionDataManager.communication.removeHabboConnectionMessageEvent(UnknownVarFromIgnoredUsersManager_IMessageEvent_1);
            _sessionDataManager.communication.removeHabboConnectionMessageEvent(UnknownVarFromIgnoredUsersManager_IMessageEvent_2);
         }
         UnknownVarFromIgnoredUsersManager_IMessageEvent_1 = null;
         UnknownVarFromIgnoredUsersManager_IMessageEvent_2 = null;
         _sessionDataManager = null;
      }
      
      public function initIgnoreList() : void
      {
         _sessionDataManager.send(new GetIgnoredUsersMessageComposer());
      }
      
      private function onIgnoreList(param1:IgnoredUsersMessageEvent) : void
      {
         UnknownVarFromIgnoredUsersManager_Array_1 = param1.ignoredUserIds;
      }
      
      private function onIgnoreResult(param1:IgnoreResultMessageEvent) : void
      {
         var _loc2_:int = param1.userId;
         switch(param1.result)
         {
            case 0:
               break;
            case 1:
               addUserToIgnoreList(_loc2_);
               break;
            case 2:
               addUserToIgnoreList(_loc2_);
               UnknownVarFromIgnoredUsersManager_Array_1.shift();
               break;
            case 3:
               removeUserFromIgnoreList(_loc2_);
         }
      }
      
      private function addUserToIgnoreList(param1:int) : void
      {
         if(UnknownVarFromIgnoredUsersManager_Array_1.indexOf(param1) < 0)
         {
            UnknownVarFromIgnoredUsersManager_Array_1.push(param1);
         }
      }
      
      private function removeUserFromIgnoreList(param1:int) : void
      {
         var _loc2_:int = int(UnknownVarFromIgnoredUsersManager_Array_1.indexOf(param1));
         if(_loc2_ >= 0)
         {
            UnknownVarFromIgnoredUsersManager_Array_1.splice(_loc2_,1);
         }
      }
      
      public function ignoreUser(param1:int) : void
      {
         _sessionDataManager.send(new IgnoreUserMessageComposer(param1));
      }
      
      public function unignoreUser(param1:int) : void
      {
         _sessionDataManager.send(new UnignoreUserMessageComposer(param1));
      }
      
      public function isIgnored(param1:int) : Boolean
      {
         return UnknownVarFromIgnoredUsersManager_Array_1.indexOf(param1) >= 0;
      }
      
      public function get disposed() : Boolean
      {
         return _sessionDataManager == null;
      }
   }
}

