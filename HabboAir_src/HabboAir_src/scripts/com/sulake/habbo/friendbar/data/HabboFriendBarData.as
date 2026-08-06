package com.sulake.habbo.friendbar.data
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FindFriendsProcessResultEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendData;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListFragmentMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendListUpdateEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendNotificationEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestData;
   import com.sulake.habbo.communication.messages.incoming.friendlist.FriendRequestsEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.MessengerInitEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.NewConsoleMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.NewFriendRequestEvent;
   import com.sulake.habbo.communication.messages.incoming.friendlist.RoomInviteEvent;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.FindNewFriendsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.friendlist.FollowFriendMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileByNameMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
   import com.sulake.habbo.communication.messages.parser.friendlist.FriendListUpdateMessageParser;
   import com.sulake.habbo.communication.messages.parser.friendlist.FriendNotificationMessageParser;
   import com.sulake.habbo.communication.messages.parser.friendlist.NewConsoleMessageMessageParser;
   import com.sulake.habbo.communication.messages.parser.friendlist.RoomInviteMessageParser;
   import com.sulake.habbo.friendbar.events.ActiveConversationsCountEvent;
   import com.sulake.habbo.friendbar.events.FindFriendsNotificationEvent;
   import com.sulake.habbo.friendbar.events.FriendBarUpdateEvent;
   import com.sulake.habbo.friendbar.events.FriendRequestUpdateEvent;
   import com.sulake.habbo.friendbar.events.NewMessageEvent;
   import com.sulake.habbo.friendbar.events.NotificationEvent;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.friendlist.events.FriendRequestEvent;
   import com.sulake.habbo.messenger.IHabboMessenger;
   import com.sulake.habbo.messenger.events.ActiveConversationEvent;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.utils.WindowToggle;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboFriendList;
   import com.sulake.iid.IIDHabboMessenger;
   import com.sulake.iid.IIDHabboTracking;
   
   public class HabboFriendBarData extends Component implements IHabboFriendBarData
   {
      private static const SHOW_OFFLINE_FRIENDS:Boolean = false;
      
      private static const SORT_ALPHABETICALLY:Boolean = false;
      
      private static const TRACKING_EVENT_CATEGORY:String = "Navigation";
      
      private static const TRACKING_EVENT_TYPE:String = "Friend Bar";
      
      private static const TRACKING_EVENT_ACTION_VISIT:String = "go.friendbar";
      
      private static const TRACKING_EVENT_ACTION_CHAT:String = "chat_btn_click";
      
      private static const TRACKING_EVENT_ACTION_FIND_FRIENDS:String = "find_friends_btn_click";
      
      public static const TRACKING_EVENT_ACTION_PLAY_SNOWSTORM_TAB:String = "play_snowstorm_tab_click";
      
      public static const TRACKING_EVENT_ACTION_PLAY_SNOWSTORM_BUTTON:String = "play_snowstorm_btn_click";
      
      private static const UnknownConstFromHabboFriendBarData_String_1:String = "Toolbar";
      
      private static const UnknownConstFromHabboFriendBarData_String_2:String = "open";
      
      private static const UnknownConstFromHabboFriendBarData_String_3:String = "close";
      
      private static const LEGACY_TRACKING_EVENT_TYPE_FRIENDLIST:String = "FRIENDLIST";
      
      private static const LEGACY_TRACKING_EVENT_TYPE_MESSENGER:String = "MESSENGER";
      
      private var _habboCommunicationManager:IHabboCommunicationManager;
      
      private var _habboFriendListComponent:IHabboFriendList;
      
      private var _habboMessengerComponent:IHabboMessenger;
      
      private var _tracking:IHabboTracking;
      
      private var UnknownVarFromHabboFriendBarData_Array_1:Array;
      
      private var UnknownVarFromHabboFriendBarData_Map_1:Map;
      
      private var _friendRequestList:Array;
      
      private var UnknownVarFromHabboFriendBarData_Int_1:int;
      
      public function HabboFriendBarData(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
         UnknownVarFromHabboFriendBarData_Array_1 = [];
         UnknownVarFromHabboFriendBarData_Map_1 = new Map();
         _friendRequestList = [];
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboConfigurationManager(),null),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _habboCommunicationManager = param1;
         }),new ComponentDependency(new IIDHabboFriendList(),function(param1:IHabboFriendList):void
         {
            _habboFriendListComponent = param1;
         }),new ComponentDependency(new IIDHabboMessenger(),function(param1:IHabboMessenger):void
         {
            _habboMessengerComponent = param1;
         }),new ComponentDependency(new IIDHabboTracking(),function(param1:IHabboTracking):void
         {
            _tracking = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         _habboCommunicationManager.addHabboConnectionMessageEvent(new FriendListUpdateEvent(onFriendListUpdate));
         _habboCommunicationManager.addHabboConnectionMessageEvent(new MessengerInitEvent(onMessengerInitialized));
         _habboCommunicationManager.addHabboConnectionMessageEvent(new FriendListFragmentMessageEvent(onFriendsListFragment));
         _habboCommunicationManager.addHabboConnectionMessageEvent(new NewConsoleMessageEvent(onNewConsoleMessage));
         _habboCommunicationManager.addHabboConnectionMessageEvent(new FriendRequestsEvent(onFriendRequestList));
         _habboCommunicationManager.addHabboConnectionMessageEvent(new RoomInviteEvent(onRoomInvite));
         _habboCommunicationManager.addHabboConnectionMessageEvent(new NewFriendRequestEvent(onNewFriendRequest));
         _habboCommunicationManager.addHabboConnectionMessageEvent(new FindFriendsProcessResultEvent(onFindFriendProcessResult));
         _habboCommunicationManager.addHabboConnectionMessageEvent(new FriendNotificationEvent(onFriendNotification));
         _habboFriendListComponent.events.addEventListener("FRE_ACCEPTED",onFriendRequestEvent);
         _habboFriendListComponent.events.addEventListener("FRE_DECLINED",onFriendRequestEvent);
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(_habboFriendListComponent != null && !_habboFriendListComponent.disposed)
            {
               _habboFriendListComponent.events.removeEventListener("FRE_ACCEPTED",onFriendRequestEvent);
               _habboFriendListComponent.events.removeEventListener("FRE_DECLINED",onFriendRequestEvent);
            }
            UnknownVarFromHabboFriendBarData_Array_1 = null;
            UnknownVarFromHabboFriendBarData_Map_1.dispose();
            UnknownVarFromHabboFriendBarData_Map_1 = null;
            _friendRequestList = null;
            super.dispose();
         }
      }
      
      public function get numFriends() : int
      {
         return UnknownVarFromHabboFriendBarData_Array_1.length;
      }
      
      public function getFriendAt(param1:int) : IFriendEntity
      {
         return UnknownVarFromHabboFriendBarData_Array_1[param1];
      }
      
      public function getFriendByID(param1:int) : IFriendEntity
      {
         return UnknownVarFromHabboFriendBarData_Map_1.getValue(param1);
      }
      
      public function getFriendByName(param1:String) : IFriendEntity
      {
         for each(var _loc2_ in UnknownVarFromHabboFriendBarData_Array_1)
         {
            if(_loc2_.name == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function setFriendAt(param1:IFriendEntity, param2:int) : void
      {
         var _loc3_:int = int(UnknownVarFromHabboFriendBarData_Array_1.indexOf(param1));
         if(_loc3_ > -1 && _loc3_ != param2)
         {
            UnknownVarFromHabboFriendBarData_Array_1.splice(_loc3_,1);
            UnknownVarFromHabboFriendBarData_Array_1.splice(param2,0,param1);
            events.dispatchEvent(new FriendBarUpdateEvent());
         }
      }
      
      public function get numFriendRequests() : int
      {
         return !!_friendRequestList ? _friendRequestList.length : 0;
      }
      
      public function getFriendRequestAt(param1:int) : IFriendRequest
      {
         return !!_friendRequestList ? _friendRequestList[param1] : null;
      }
      
      public function getFriendRequestByID(param1:int) : IFriendRequest
      {
         if(_friendRequestList)
         {
            for each(var _loc2_ in _friendRequestList)
            {
               if(_loc2_.id == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function getFriendRequestByName(param1:String) : IFriendRequest
      {
         if(_friendRequestList)
         {
            for each(var _loc2_ in _friendRequestList)
            {
               if(_loc2_.name == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function getFriendRequestList() : Array
      {
         return _friendRequestList;
      }
      
      public function acceptFriendRequest(param1:int) : void
      {
         removeFriendRequest(param1);
         if(_habboFriendListComponent)
         {
            if(!_habboFriendListComponent.disposed)
            {
               _habboFriendListComponent.acceptFriendRequest(param1);
            }
         }
      }
      
      public function showProfile(param1:int) : void
      {
         if(_habboCommunicationManager)
         {
            if(param1 > 0)
            {
               _habboCommunicationManager.connection.send(new GetExtendedProfileMessageComposer(param1));
            }
            else
            {
               _habboCommunicationManager.connection.send(new GetHabboGroupDetailsMessageComposer(Math.abs(param1),true));
            }
         }
      }
      
      public function showProfileByName(param1:String) : void
      {
         if(_habboCommunicationManager)
         {
            _habboCommunicationManager.connection.send(new GetExtendedProfileByNameMessageComposer(param1));
         }
      }
      
      public function acceptAllFriendRequests() : void
      {
         _friendRequestList = [];
         _habboFriendListComponent.acceptAllFriendRequests();
         events.dispatchEvent(new FriendRequestUpdateEvent());
      }
      
      public function declineFriendRequest(param1:int) : void
      {
         removeFriendRequest(param1);
         if(_habboFriendListComponent)
         {
            if(!_habboFriendListComponent.disposed)
            {
               _habboFriendListComponent.declineFriendRequest(param1);
            }
         }
      }
      
      public function declineAllFriendRequests() : void
      {
         _friendRequestList = [];
         _habboFriendListComponent.declineAllFriendRequests();
         events.dispatchEvent(new FriendRequestUpdateEvent());
      }
      
      private function removeFriendRequest(param1:int) : void
      {
         if(_friendRequestList)
         {
            for each(var _loc2_ in _friendRequestList)
            {
               if(_loc2_.id == param1)
               {
                  _friendRequestList.splice(_friendRequestList.indexOf(_loc2_),1);
                  events.dispatchEvent(new FriendRequestUpdateEvent());
                  return;
               }
            }
         }
      }
      
      public function followToRoom(param1:int) : void
      {
         if(_habboCommunicationManager)
         {
            _habboCommunicationManager.connection.send(new FollowFriendMessageComposer(param1));
            _habboCommunicationManager.connection.send(new EventLogMessageComposer("Navigation","Friend Bar","go.friendbar"));
         }
      }
      
      public function startConversation(param1:int) : void
      {
         if(_habboMessengerComponent)
         {
            _habboMessengerComponent.startConversation(param1);
            events.dispatchEvent(new NewMessageEvent(false,param1));
            if(_habboCommunicationManager)
            {
               _habboCommunicationManager.connection.send(new EventLogMessageComposer("Navigation","Friend Bar","chat_btn_click"));
            }
         }
      }
      
      public function findNewFriends() : void
      {
         if(_habboCommunicationManager)
         {
            _habboCommunicationManager.connection.send(new FindNewFriendsMessageComposer());
            _habboCommunicationManager.connection.send(new EventLogMessageComposer("Navigation","Friend Bar","find_friends_btn_click"));
         }
      }
      
      public function openUserTextSearch() : void
      {
         if(_habboFriendListComponent.currentTabId() != 3)
         {
            _habboFriendListComponent.openFriendSearch();
         }
         else
         {
            _habboFriendListComponent.close();
         }
      }
      
      public function sendGameTabTracking(param1:String) : void
      {
         sendEventLogTracking("play_snowstorm_tab_click",param1);
      }
      
      public function sendGameButtonTracking(param1:String) : void
      {
         sendEventLogTracking("play_snowstorm_btn_click",param1);
      }
      
      private function sendEventLogTracking(param1:String, param2:String) : void
      {
         if(_habboCommunicationManager)
         {
            _habboCommunicationManager.connection.send(new EventLogMessageComposer("Navigation","Friend Bar",param1,param2,numFriends));
         }
      }
      
      public function toggleFriendList() : void
      {
         var _loc1_:IWindowController_1 = null;
         if(_habboFriendListComponent)
         {
            if(!_habboFriendListComponent.disposed)
            {
               if(!_habboFriendListComponent.isOpen())
               {
                  if(_friendRequestList.length > 0)
                  {
                     _habboFriendListComponent.openFriendRequests();
                  }
                  else
                  {
                     _habboFriendListComponent.openFriendList();
                  }
               }
               else
               {
                  _loc1_ = _habboFriendListComponent.mainWindow;
                  if(_loc1_ != null && WindowToggle.isHiddenByOtherWindows(_loc1_))
                  {
                     _loc1_.activate();
                     return;
                  }
                  _habboFriendListComponent.close();
               }
               if(_habboCommunicationManager)
               {
                  _habboCommunicationManager.connection.send(new EventLogMessageComposer("Toolbar","FRIENDLIST",_habboFriendListComponent.isOpen() ? "open" : "close"));
               }
            }
         }
      }
      
      public function toggleMessenger() : void
      {
         if(_habboMessengerComponent)
         {
            if(!_habboMessengerComponent.disposed)
            {
               _habboMessengerComponent.toggleMessenger();
               if(_habboCommunicationManager)
               {
                  _habboCommunicationManager.connection.send(new EventLogMessageComposer("Toolbar","MESSENGER",_habboMessengerComponent.isOpen() ? "open" : "close"));
               }
            }
         }
      }
      
      private function onMessengerInitialized(param1:IMessageEvent) : void
      {
         if(_habboMessengerComponent)
         {
            _habboMessengerComponent.events.addEventListener("ACCE_changed",onUpdateActiveConversationCount);
         }
      }
      
      private function onFriendsListFragment(param1:IMessageEvent) : void
      {
         buildFriendList(FriendListFragmentMessageEvent(param1).getParser().friendFragment);
      }
      
      private function onFriendListUpdate(param1:IMessageEvent) : void
      {
         var _loc2_:FriendEntity = null;
         var _loc6_:* = null;
         var _loc4_:FriendListUpdateMessageParser = FriendListUpdateEvent(param1).getParser();
         var _loc3_:Array = _loc4_.removedFriendIds;
         var _loc8_:Array = _loc4_.updatedFriends;
         var _loc5_:Array = _loc4_.addedFriends;
         for each(var _loc7_ in _loc3_)
         {
            _loc2_ = UnknownVarFromHabboFriendBarData_Map_1.getValue(_loc7_);
            if(_loc2_)
            {
               UnknownVarFromHabboFriendBarData_Map_1.remove(_loc7_);
               UnknownVarFromHabboFriendBarData_Array_1.splice(UnknownVarFromHabboFriendBarData_Array_1.indexOf(_loc2_),1);
               _habboMessengerComponent.closeConversation(_loc7_);
            }
         }
         for each(_loc6_ in _loc8_)
         {
            _loc2_ = UnknownVarFromHabboFriendBarData_Map_1.getValue(_loc6_.id);
            if(_loc2_)
            {
               if(_loc6_.online)
               {
                  _loc2_.name = _loc6_.name;
                  _loc2_.realName = _loc6_.realName;
                  _loc2_.motto = _loc6_.motto;
                  _loc2_.gender = _loc6_.gender;
                  _loc2_.online = _loc6_.online;
                  _loc2_.allowFollow = _loc6_.followingAllowed;
                  _loc2_.figure = _loc6_.figure;
                  _loc2_.categoryId = _loc6_.categoryId;
                  _loc2_.lastAccess = _loc6_.lastAccess;
               }
               else
               {
                  UnknownVarFromHabboFriendBarData_Map_1.remove(_loc6_.id);
                  UnknownVarFromHabboFriendBarData_Array_1.splice(UnknownVarFromHabboFriendBarData_Array_1.indexOf(_loc2_),1);
               }
            }
            else if(_loc6_.online)
            {
               _loc2_ = new FriendEntity(_loc6_.id,_loc6_.name,_loc6_.realName,_loc6_.motto,_loc6_.gender,_loc6_.online,_loc6_.followingAllowed,_loc6_.figure,_loc6_.categoryId,_loc6_.lastAccess);
               UnknownVarFromHabboFriendBarData_Array_1.splice(0,0,_loc2_);
               UnknownVarFromHabboFriendBarData_Map_1.add(_loc2_.id,_loc2_);
            }
         }
         for each(_loc6_ in _loc5_)
         {
            if(_loc6_.online)
            {
               if(UnknownVarFromHabboFriendBarData_Map_1.getValue(_loc6_.id) == null)
               {
                  _loc2_ = new FriendEntity(_loc6_.id,_loc6_.name,_loc6_.realName,_loc6_.motto,_loc6_.gender,_loc6_.online,_loc6_.followingAllowed,_loc6_.figure,_loc6_.categoryId,_loc6_.lastAccess);
                  UnknownVarFromHabboFriendBarData_Array_1.push(_loc2_);
                  UnknownVarFromHabboFriendBarData_Map_1.add(_loc2_.id,_loc2_);
               }
            }
            removeFriendRequest(_loc6_.id);
         }
         if(_loc5_.length > 0 || _loc8_.length > 0)
         {
            UnknownVarFromHabboFriendBarData_Array_1 = sortByName(UnknownVarFromHabboFriendBarData_Array_1);
         }
         events.dispatchEvent(new FriendBarUpdateEvent());
      }
      
      private function onFindFriendProcessResult(param1:FindFriendsProcessResultEvent) : void
      {
         events.dispatchEvent(new FindFriendsNotificationEvent(param1.success));
      }
      
      private function onNewFriendRequest(param1:NewFriendRequestEvent) : void
      {
         var _loc2_:FriendRequestData = null;
         if(showFriendRequests)
         {
            _loc2_ = param1.getParser().req;
            _friendRequestList.push(new FriendRequest(_loc2_.requestId,_loc2_.requesterName,_loc2_.figureString));
            events.dispatchEvent(new FriendRequestUpdateEvent());
         }
      }
      
      private function onFriendRequestList(param1:FriendRequestsEvent) : void
      {
         var _loc3_:Array = null;
         if(showFriendRequests)
         {
            _loc3_ = param1.getParser().reqs;
            for each(var _loc2_ in _loc3_)
            {
               _friendRequestList.push(new FriendRequest(_loc2_.requestId,_loc2_.requesterName,_loc2_.figureString));
            }
            events.dispatchEvent(new FriendRequestUpdateEvent());
         }
      }
      
      private function onFriendRequestEvent(param1:FriendRequestEvent) : void
      {
         removeFriendRequest(param1.requestId);
      }
      
      private function onNewConsoleMessage(param1:NewConsoleMessageEvent) : void
      {
         var _loc2_:NewConsoleMessageMessageParser = param1.getParser();
         UnknownVarFromHabboFriendBarData_Int_1 = _loc2_.chatId;
         var _loc3_:Boolean = true;
         if(_habboMessengerComponent)
         {
            if(_habboMessengerComponent.isOpen())
            {
               _loc3_ = false;
            }
         }
         if(_habboFriendListComponent.hasfriendsListInitialized)
         {
            events.dispatchEvent(new NewMessageEvent(_loc3_,UnknownVarFromHabboFriendBarData_Int_1));
         }
         if(_loc3_)
         {
            makeNotification(String(UnknownVarFromHabboFriendBarData_Int_1),-1,null,false,false);
         }
      }
      
      private function onUpdateActiveConversationCount(param1:ActiveConversationEvent) : void
      {
         events.dispatchEvent(new ActiveConversationsCountEvent(param1.activeConversationsCount,param1.hasUnread));
      }
      
      private function onRoomInvite(param1:RoomInviteEvent) : void
      {
         var _loc2_:RoomInviteMessageParser = param1.getParser();
         UnknownVarFromHabboFriendBarData_Int_1 = _loc2_.senderId;
         if(_habboMessengerComponent && !_habboMessengerComponent.isOpen())
         {
            events.dispatchEvent(new NewMessageEvent(true,UnknownVarFromHabboFriendBarData_Int_1));
            makeNotification(String(UnknownVarFromHabboFriendBarData_Int_1),-1,null,true,false);
         }
      }
      
      private function onFriendNotification(param1:FriendNotificationEvent) : void
      {
         var _loc4_:FriendNotificationMessageParser = param1.getParser();
         var _loc2_:* = _loc4_.typeCode != 3;
         var _loc5_:* = _loc4_.typeCode != 4;
         var _loc3_:* = _loc4_.typeCode != 3;
         makeNotification(_loc4_.avatarId,_loc4_.typeCode,_loc4_.message,_loc2_,_loc5_,_loc3_);
      }
      
      private function makeNotification(param1:String, param2:int, param3:String, param4:Boolean, param5:Boolean, param6:Boolean = true) : void
      {
         var _loc7_:IFriendEntity = null;
         var _loc8_:FriendNotification = null;
         var _loc9_:* = undefined;
         if(showFriendNotifications)
         {
            _loc7_ = getFriendByID(parseInt(param1));
            if(_loc7_)
            {
               _loc9_ = _loc7_.notifications;
               for each(_loc8_ in _loc9_)
               {
                  if(_loc8_.typeCode == param2)
                  {
                     _loc8_.message = param3;
                     _loc8_.viewOnce = param4;
                     break;
                  }
                  _loc8_ = null;
               }
               if(!_loc8_)
               {
                  _loc8_ = new FriendNotification(param2,param3,param4);
                  _loc9_.push(_loc8_);
               }
               else if(!param6)
               {
                  return;
               }
               events.dispatchEvent(new NotificationEvent(_loc7_.id,_loc8_));
               if(param5)
               {
                  setFriendAt(_loc7_,0);
               }
               if(_loc7_.logEventId < 0)
               {
                  _loc7_.logEventId = _loc7_.getNextLogEventId();
               }
               if(_tracking)
               {
                  _tracking.trackEventLog("FriendBar",FriendNotification.typeCodeToString(param2),"notified","",_loc7_.logEventId > 0 ? _loc7_.logEventId : 0);
               }
            }
         }
      }
      
      private function buildFriendList(param1:Array) : void
      {
         var _loc2_:FriendEntity = null;
         for each(var _loc3_ in param1)
         {
            if(_loc3_.online)
            {
               _loc2_ = new FriendEntity(_loc3_.id,_loc3_.name,_loc3_.realName,_loc3_.motto,_loc3_.gender,_loc3_.online,_loc3_.followingAllowed,_loc3_.figure,_loc3_.categoryId,_loc3_.lastAccess);
               UnknownVarFromHabboFriendBarData_Array_1.push(_loc2_);
               UnknownVarFromHabboFriendBarData_Map_1.add(_loc2_.id,_loc2_);
            }
         }
         UnknownVarFromHabboFriendBarData_Array_1 = sortByName(UnknownVarFromHabboFriendBarData_Array_1);
         events.dispatchEvent(new FriendBarUpdateEvent());
      }
      
      private function sortByName(param1:Array) : Array
      {
         return param1;
      }
      
      private function sortByNameAndOnlineStatus(param1:Array) : Array
      {
         var _loc5_:FriendEntity = null;
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         var _loc4_:int = int(param1.length);
         while(_loc4_-- > 0)
         {
            _loc5_ = param1[_loc4_];
            if(_loc5_.online)
            {
               _loc2_.push(_loc5_);
            }
            else
            {
               _loc3_.push(_loc5_);
            }
         }
         _loc4_ = int(_loc3_.length);
         while(_loc4_-- > 0)
         {
            _loc2_.push(_loc3_.pop());
         }
         return _loc2_;
      }
      
      public function get showFriendNotifications() : Boolean
      {
         return getBoolean("friendbar.notifications.enabled");
      }
      
      public function get showFriendRequests() : Boolean
      {
         return getBoolean("friendbar.requests.enabled");
      }
   }
}

