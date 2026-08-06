package com.sulake.habbo.groups
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils1;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils2;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.FlatCreatedEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.GetGuestRoomResultEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.session.CloseConnectionMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.ExtendedProfileChangedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.ExtendedProfileData;
   import com.sulake.habbo.communication.messages.incoming.users.ExtendedProfileMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GroupDetailsChangedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GroupMembershipRequestedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GuildCreatedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GuildCreationData;
   import com.sulake.habbo.communication.messages.incoming.users.GuildCreationInfoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GuildEditData;
   import com.sulake.habbo.communication.messages.incoming.users.GuildEditFailedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GuildEditInfoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GuildEditorData;
   import com.sulake.habbo.communication.messages.incoming.users.GuildEditorDataMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMemberData;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMemberFurniCountInHQMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMemberMgmtFailedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembersMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipRejectedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.GuildMembershipUpdatedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDeactivatedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsData;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupJoinFailedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.HabboUserBadgesMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.users.MemberData;
   import com.sulake.habbo.communication.messages.incoming.users.RelationshipStatusInfoEvent;
   import com.sulake.habbo.communication.messages.incoming.users.ScrSendUserInfoEvent;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetGuildEditorDataMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetMemberGuildItemCountMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.KickMemberMessageComposer;
   import com.sulake.habbo.communication.messages.parser.handshake.UserObjectMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.FlatCreatedMessageParser;
   import com.sulake.habbo.communication.messages.parser.navigator.GetGuestRoomResultMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
   import com.sulake.habbo.communication.messages.parser.users.ScrSendUserInfoMessageParser;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.groups.badge_leaderboard.BadgeLeaderboardController;
   import com.sulake.habbo.groups.events.HabboGroupsEditorData;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.navigator.IHabboNavigator_1;
   import com.sulake.habbo.navigator.IHabboNewNavigator;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboFriendList;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboNewNavigator;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboTracking;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.display.BitmapData;
   
   public class HabboGroupsManager extends Component implements IHabboGroupsManager, ILinkEventTracker
   {
      public static const GROUPS_TRACKING_CATEGORY:String = "HabboGroups";
      
      private var _communication:IHabboCommunicationManager;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _navigator:IHabboNavigator_1;
      
      private var _newNavigator:IHabboNewNavigator;
      
      private var _friendlist:IHabboFriendList;
      
      private var _catalog:IHabboCatalog;
      
      private var _toolbar:IHabboToolbar;
      
      private var _habboTracking:IHabboTracking;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var UnknownVarFromHabboGroupsManager_DetailsWindowCtrl_1:DetailsWindowCtrl;
      
      private var _guildMembersWindowCtrl:GuildMembersWindowCtrl;
      
      private var _guildManagementWindowCtrl:GuildManagementWindowCtrl;
      
      private var UnknownVarFromHabboGroupsManager_ExtendedProfileWindowCtrl_1:ExtendedProfileWindowCtrl;
      
      private var UnknownVarFromHabboGroupsManager_HcRequiredWindowCtrl_1:HcRequiredWindowCtrl;
      
      private var UnknownVarFromHabboGroupsManager_GroupCreatedWindowCtrl_1:GroupCreatedWindowCtrl;
      
      private var _groupRoomInfoCtrl:GroupRoomInfoCtrl;
      
      private var UnknownVarFromHabboGroupsManager_BadgeLeaderboardController_1:BadgeLeaderboardController;
      
      private var _guildEditorData:GuildEditorData;
      
      private var _avatarId:int;
      
      private var _roomId:int;
      
      private var _hasVip:Boolean;
      
      private var UnknownVarFromHabboGroupsManager_GuildKickData_1:GuildKickData;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      public function HabboGroupsManager(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
         UnknownVarFromHabboGroupsManager_DetailsWindowCtrl_1 = new DetailsWindowCtrl(this);
         _guildMembersWindowCtrl = new GuildMembersWindowCtrl(this);
         _guildManagementWindowCtrl = new GuildManagementWindowCtrl(this);
         UnknownVarFromHabboGroupsManager_ExtendedProfileWindowCtrl_1 = new ExtendedProfileWindowCtrl(this);
         UnknownVarFromHabboGroupsManager_HcRequiredWindowCtrl_1 = new HcRequiredWindowCtrl(this);
         UnknownVarFromHabboGroupsManager_GroupCreatedWindowCtrl_1 = new GroupCreatedWindowCtrl(this);
         _groupRoomInfoCtrl = new GroupRoomInfoCtrl(this);
         UnknownVarFromHabboGroupsManager_BadgeLeaderboardController_1 = new BadgeLeaderboardController(this,param1,0,param3);
         Logger.log("HabboGroupsManager initialized: " + param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboNavigator(),function(param1:IHabboNavigator_1):void
         {
            _navigator = param1;
         }),new ComponentDependency(new IIDHabboNewNavigator(),function(param1:IHabboNewNavigator):void
         {
            _newNavigator = param1;
         }),new ComponentDependency(new IIDHabboFriendList(),function(param1:IHabboFriendList):void
         {
            _friendlist = param1;
         }),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         }),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboTracking(),function(param1:IHabboTracking):void
         {
            _habboTracking = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         _messageEvents = new Vector.<IMessageEvent>(0);
         addMessageEvent(new GuildEditInfoMessageEvent(onGuildEditInfo));
         addMessageEvent(new ExtendedProfileChangedMessageEvent(onExtendedProfileChanged));
         addMessageEvent(new ExtendedProfileMessageEvent(onExtendedProfile));
         addMessageEvent(new GroupDetailsChangedMessageEvent(onGroupDetailsChanged));
         addMessageEvent(new GuildEditorDataMessageEvent(onGuildEditorData));
         addMessageEvent(new GuildCreatedMessageEvent(onGuildCreated));
         addMessageEvent(new GuildMemberFurniCountInHQMessageEvent(onKickConfirmation));
         addMessageEvent(new GuildMembershipRejectedMessageEvent(_guildMembersWindowCtrl.onGuildMembershipRejected));
         addMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
         addMessageEvent(new GuildCreationInfoMessageEvent(onGuildCreationInfo));
         addMessageEvent(new HabboGroupDeactivatedMessageEvent(onGroupDeactivated));
         addMessageEvent(new GuildMemberMgmtFailedMessageEvent(_guildMembersWindowCtrl.onGuildMemberMgmtFailed));
         addMessageEvent(new RelationshipStatusInfoEvent(onRelationshipStatusInfo));
         addMessageEvent(new HabboGroupJoinFailedMessageEvent(onJoinFailed));
         addMessageEvent(new GroupMembershipRequestedMessageEvent(_guildMembersWindowCtrl.onMembershipRequested));
         addMessageEvent(new ScrSendUserInfoEvent(onSubscriptionInfo));
         addMessageEvent(new HabboGroupDetailsMessageEvent(onGroupDetails));
         addMessageEvent(new FlatCreatedEvent(onFlatCreated));
         addMessageEvent(new GetGuestRoomResultEvent(onRoomInfo));
         addMessageEvent(new GuildMembersMessageEvent(_guildMembersWindowCtrl.onGuildMembers));
         addMessageEvent(new GuildEditFailedMessageEvent(onGuildEditFailed));
         addMessageEvent(new CloseConnectionMessageEvent(onRoomLeave));
         addMessageEvent(new GuildMembershipUpdatedMessageEvent(_guildMembersWindowCtrl.onGuildMembershipUpdated));
         addMessageEvent(new UserObjectEvent(onUserObject));
         addMessageEvent(new HabboUserBadgesMessageEvent(onUserBadgesMessage));
         context.addLinkEventTracker(this);
         context.addLinkEventTracker(UnknownVarFromHabboGroupsManager_ExtendedProfileWindowCtrl_1);
         context.addLinkEventTracker(UnknownVarFromHabboGroupsManager_BadgeLeaderboardController_1);
      }
      
      private function addMessageEvent(param1:IMessageEvent) : void
      {
         _messageEvents.push(_communication.addHabboConnectionMessageEvent(param1));
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(_messageEvents != null && _communication != null)
         {
            for each(var _loc1_ in _messageEvents)
            {
               _communication.removeHabboConnectionMessageEvent(_loc1_);
            }
            _messageEvents = null;
         }
         if(UnknownVarFromHabboGroupsManager_DetailsWindowCtrl_1)
         {
            UnknownVarFromHabboGroupsManager_DetailsWindowCtrl_1.dispose();
            UnknownVarFromHabboGroupsManager_DetailsWindowCtrl_1 = null;
         }
         if(_guildMembersWindowCtrl)
         {
            _guildMembersWindowCtrl.dispose();
            _guildMembersWindowCtrl = null;
         }
         if(_guildManagementWindowCtrl)
         {
            _guildManagementWindowCtrl.dispose();
            _guildManagementWindowCtrl = null;
         }
         if(UnknownVarFromHabboGroupsManager_ExtendedProfileWindowCtrl_1)
         {
            UnknownVarFromHabboGroupsManager_ExtendedProfileWindowCtrl_1.dispose();
            UnknownVarFromHabboGroupsManager_ExtendedProfileWindowCtrl_1 = null;
         }
         if(UnknownVarFromHabboGroupsManager_HcRequiredWindowCtrl_1)
         {
            UnknownVarFromHabboGroupsManager_HcRequiredWindowCtrl_1.dispose();
            UnknownVarFromHabboGroupsManager_HcRequiredWindowCtrl_1 = null;
         }
         if(UnknownVarFromHabboGroupsManager_GroupCreatedWindowCtrl_1)
         {
            UnknownVarFromHabboGroupsManager_GroupCreatedWindowCtrl_1.dispose();
            UnknownVarFromHabboGroupsManager_GroupCreatedWindowCtrl_1 = null;
         }
         if(_groupRoomInfoCtrl)
         {
            _groupRoomInfoCtrl.dispose();
            _groupRoomInfoCtrl = null;
         }
         if(UnknownVarFromHabboGroupsManager_BadgeLeaderboardController_1)
         {
            UnknownVarFromHabboGroupsManager_BadgeLeaderboardController_1.dispose();
            UnknownVarFromHabboGroupsManager_BadgeLeaderboardController_1 = null;
         }
         super.dispose();
      }
      
      public function get linkPattern() : String
      {
         return "group/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length != 2)
         {
            return;
         }
         var _loc3_:int = int(_loc2_[1]);
         openGroupInfo(_loc3_);
      }
      
      public function showGroupBadgeInfo(param1:Boolean, param2:int) : void
      {
         openGroupInfo(param2);
         send(new EventLogMessageComposer("HabboGroups","" + param2,"badge clicked"));
      }
      
      public function showBadgeLeaderboard(param1:int, param2:int = -1, param3:int = 0) : void
      {
         if(UnknownVarFromHabboGroupsManager_BadgeLeaderboardController_1 != null)
         {
            UnknownVarFromHabboGroupsManager_BadgeLeaderboardController_1.showBadgeLeaderboard(param1,param2,param3);
         }
      }
      
      public function openGroupInfo(param1:int) : void
      {
         send(new GetHabboGroupDetailsMessageComposer(param1,true));
      }
      
      public function send(param1:IMessageComposer) : void
      {
         _communication.connection.send(param1);
      }
      
      public function getXmlWindow(param1:String) : IWindowModel
      {
         var _loc4_:ISoundAsset = null;
         var _loc2_:XmlAsset = null;
         var _loc3_:IWindowModel = null;
         try
         {
            _loc4_ = assets.getAssetByName(param1);
            _loc2_ = XmlAsset(_loc4_);
            _loc3_ = _windowManager.buildFromXML(XML(_loc2_.content));
         }
         catch(e:Error)
         {
         }
         return _loc3_;
      }
      
      public function getButtonImage(param1:String) : BitmapData
      {
         var _loc3_:* = param1;
         var _loc6_:ISoundAsset = assets.getAssetByName(_loc3_);
         var _loc4_:BitmapDataAsset = BitmapDataAsset(_loc6_);
         var _loc2_:BitmapData = BitmapData(_loc4_.content);
         var _loc5_:BitmapData = new BitmapData(_loc2_.width,_loc2_.height,true,0);
         _loc5_.draw(_loc2_);
         return _loc5_;
      }
      
      public function openGroupForum(param1:int) : void
      {
         context.createLinkEvent("groupforum/" + param1);
      }
      
      private function onGroupDeactivated(param1:IMessageEvent) : void
      {
         var _loc2_:int = int(HabboGroupDeactivatedMessageEvent(param1).groupId);
         UnknownVarFromHabboGroupsManager_DetailsWindowCtrl_1.onGroupDeactivated(_loc2_);
         _groupRoomInfoCtrl.onGroupDeactivated(_loc2_);
      }
      
      private function onGroupDetails(param1:IMessageEvent) : void
      {
         var _loc2_:HabboGroupDetailsData = HabboGroupDetailsMessageEvent(param1).data;
         UnknownVarFromHabboGroupsManager_DetailsWindowCtrl_1.onGroupDetails(_loc2_);
         UnknownVarFromHabboGroupsManager_ExtendedProfileWindowCtrl_1.onGroupDetails(_loc2_);
         _groupRoomInfoCtrl.onGroupDetails(_loc2_);
      }
      
      private function onExtendedProfile(param1:IMessageEvent) : void
      {
         var _loc2_:ExtendedProfileData = ExtendedProfileMessageEvent(param1).data;
         if(_loc2_.openProfileWindow)
         {
            UnknownVarFromHabboGroupsManager_ExtendedProfileWindowCtrl_1.badgeUpdateExpected = true;
            UnknownVarFromHabboGroupsManager_ExtendedProfileWindowCtrl_1.relationshipUpdateExpected = true;
            UnknownVarFromHabboGroupsManager_ExtendedProfileWindowCtrl_1.onProfile(_loc2_);
         }
      }
      
      private function onExtendedProfileChanged(param1:IMessageEvent) : void
      {
         var _loc2_:int = int(ExtendedProfileChangedMessageEvent(param1).userId);
         UnknownVarFromHabboGroupsManager_ExtendedProfileWindowCtrl_1.onProfileChanged(_loc2_);
      }
      
      private function onGroupDetailsChanged(param1:IMessageEvent) : void
      {
         var _loc2_:int = int(GroupDetailsChangedMessageEvent(param1).groupId);
         if(UnknownVarFromHabboGroupsManager_DetailsWindowCtrl_1.isDisplayingGroup(_loc2_) || _groupRoomInfoCtrl.isDisplayingGroup(_loc2_))
         {
            send(new GetHabboGroupDetailsMessageComposer(_loc2_,false));
         }
      }
      
      private function onJoinFailed(param1:IMessageEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc2_:int = int(HabboGroupJoinFailedMessageEvent(param1).reason);
         if(_loc2_ == 4)
         {
            UnknownVarFromHabboGroupsManager_HcRequiredWindowCtrl_1.show(false);
         }
         else
         {
            _loc3_ = "group.joinfail." + _loc2_;
            _loc4_ = _localization.getLocalization(_loc3_,_loc3_);
            _windowManager.alert("${group.joinfail.title}",_loc4_,0,onAlertClose);
         }
      }
      
      private function onGuildCreationInfo(param1:IMessageEvent) : void
      {
         var _loc2_:GuildCreationData = GuildCreationInfoMessageEvent(param1).data;
         _guildManagementWindowCtrl.onGuildCreationInfo(_loc2_);
         requestGuildEditorData();
      }
      
      private function onGuildEditInfo(param1:IMessageEvent) : void
      {
         var _loc2_:GuildEditData = GuildEditInfoMessageEvent(param1).data;
         _guildManagementWindowCtrl.onGuildEditInfo(_loc2_);
         requestGuildEditorData();
      }
      
      private function onRoomLeave(param1:IMessageEvent) : void
      {
         UnknownVarFromHabboGroupsManager_DetailsWindowCtrl_1.close();
         _groupRoomInfoCtrl.close();
      }
      
      private function onRoomEnter(param1:IMessageEvent) : void
      {
         UnknownVarFromHabboGroupsManager_DetailsWindowCtrl_1.close();
         _groupRoomInfoCtrl.close();
         var _loc2_:RoomEntryInfoMessageParser = RoomEntryInfoMessageEvent(param1).getParser();
         _roomId = _loc2_.guestRoomId;
      }
      
      private function onAlertClose(param1:UnknownICoreWindowUtils1, param2:WindowEvent) : void
      {
         param1.dispose();
      }
      
      private function onGuildEditorData(param1:IMessageEvent) : void
      {
         _guildEditorData = GuildEditorDataMessageEvent(param1).data;
         events.dispatchEvent(new HabboGroupsEditorData());
      }
      
      private function onGuildEditFailed(param1:IMessageEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc2_:int = int(GuildEditFailedMessageEvent(param1).reason);
         if(_loc2_ == 2)
         {
            UnknownVarFromHabboGroupsManager_HcRequiredWindowCtrl_1.show(true);
         }
         else
         {
            _loc3_ = "group.edit.fail." + _loc2_;
            _loc4_ = _localization.getLocalization(_loc3_,_loc3_);
            _windowManager.alert("${group.edit.fail.title}",_loc4_,0,onAlertClose);
         }
      }
      
      private function onUserObject(param1:IMessageEvent) : void
      {
         var _loc2_:UserObjectMessageParser = UserObjectEvent(param1).getParser();
         _avatarId = _loc2_.id;
      }
      
      private function onFlatCreated(param1:IMessageEvent) : void
      {
         var _loc2_:FlatCreatedMessageParser = FlatCreatedEvent(param1).getParser();
         _guildManagementWindowCtrl.onFlatCreated(_loc2_.flatId,_loc2_.flatName);
      }
      
      private function onGuildCreated(param1:IMessageEvent) : void
      {
         var _loc2_:GuildCreatedMessageEvent = GuildCreatedMessageEvent(param1);
         UnknownVarFromHabboGroupsManager_GroupCreatedWindowCtrl_1.show(_loc2_.groupId);
         _guildManagementWindowCtrl.close();
         _groupRoomInfoCtrl.expectedGroupId = _loc2_.groupId;
         if(_roomId != _loc2_.baseRoomId)
         {
            _navigator.goToPrivateRoom(_loc2_.baseRoomId);
         }
      }
      
      private function onKickConfirmation(param1:IMessageEvent) : void
      {
         var _loc4_:int = int(GuildMemberFurniCountInHQMessageEvent(param1).userId());
         var _loc6_:int = int(GuildMemberFurniCountInHQMessageEvent(param1).furniCount());
         var _loc5_:MemberData = null;
         var _loc2_:GuildMemberData = _guildMembersWindowCtrl.data;
         var _loc3_:String = UnknownVarFromHabboGroupsManager_GuildKickData_1.targetBlocked ? "group.block" : "group.kick";
         if(_loc6_ > 0)
         {
            if(_loc4_ == _avatarId)
            {
               localization.registerParameter("group.leaveconfirm.desc","amount",_loc6_.toString());
               _windowManager.confirm("${group.leaveconfirm.title}","${group.leaveconfirm.desc}",0,onKickConfirmationClose);
            }
            else
            {
               _loc5_ = _loc2_.getUser(_loc4_);
               localization.registerParameter(_loc3_ + "confirm.desc","amount",_loc6_.toString());
               localization.registerParameter(_loc3_ + "confirm.desc","user",_loc5_.userName);
               _windowManager.confirm("${" + _loc3_ + "confirm.title}","${" + _loc3_ + "confirm.desc}",0,onKickConfirmationClose);
            }
         }
         else if(_loc4_ == _avatarId)
         {
            _windowManager.confirm("${group.leaveconfirm.title}","${group.leaveconfirm_nofurni.desc}",0,onKickConfirmationClose);
         }
         else if(_loc2_)
         {
            _loc5_ = _loc2_.getUser(_loc4_);
            localization.registerParameter(_loc3_ + "confirm_nofurni.desc","user",_loc5_.userName);
            _windowManager.confirm("${" + _loc3_ + "confirm.title}","${" + _loc3_ + "confirm_nofurni.desc}",0,onKickConfirmationClose);
         }
      }
      
      private function onKickConfirmationClose(param1:UnknownICoreWindowUtils2, param2:WindowEvent) : void
      {
         if(param1 == null || Boolean(param1.disposed) || UnknownVarFromHabboGroupsManager_GuildKickData_1 == null)
         {
            UnknownVarFromHabboGroupsManager_GuildKickData_1 = null;
            return;
         }
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            send(new KickMemberMessageComposer(UnknownVarFromHabboGroupsManager_GuildKickData_1.kickGuildId,UnknownVarFromHabboGroupsManager_GuildKickData_1.kickTargetId,UnknownVarFromHabboGroupsManager_GuildKickData_1.targetBlocked));
         }
         UnknownVarFromHabboGroupsManager_GuildKickData_1 = null;
      }
      
      private function onSubscriptionInfo(param1:IMessageEvent) : void
      {
         var _loc2_:ScrSendUserInfoMessageParser = ScrSendUserInfoEvent(param1).getParser();
         _hasVip = _loc2_.isVIP && _loc2_.minutesUntilExpiration > 0;
         _guildManagementWindowCtrl.onSubscriptionChange();
      }
      
      private function onRoomInfo(param1:IMessageEvent) : void
      {
         var _loc2_:GetGuestRoomResultMessageParser = GetGuestRoomResultEvent(param1).getParser();
         if(_loc2_.enterRoom)
         {
            _groupRoomInfoCtrl.onRoomInfo(_loc2_.data);
         }
      }
      
      private function onRelationshipStatusInfo(param1:IMessageEvent) : void
      {
         var _loc2_:RelationshipStatusInfoEvent = RelationshipStatusInfoEvent(param1);
         UnknownVarFromHabboGroupsManager_ExtendedProfileWindowCtrl_1.onRelationshipStatusInfo(_loc2_.userId,_loc2_.relationshipStatusMap);
      }
      
      private function onUserBadgesMessage(param1:HabboUserBadgesMessageEvent) : void
      {
         UnknownVarFromHabboGroupsManager_ExtendedProfileWindowCtrl_1.onUserBadges(param1.userId,param1.selectedBadges);
      }
      
      private function requestGuildEditorData() : void
      {
         if(_guildEditorData == null)
         {
            send(new GetGuildEditorDataMessageComposer());
         }
      }
      
      public function get localization() : IHabboLocalizationManager
      {
         return _localization;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get guildManagementWindowCtrl() : GuildManagementWindowCtrl
      {
         return _guildManagementWindowCtrl;
      }
      
      public function get groupRoomInfoCtrl() : GroupRoomInfoCtrl
      {
         return _groupRoomInfoCtrl;
      }
      
      public function get groupRoomInfoEnabled() : Boolean
      {
         return getBoolean("groupRoomInfo.enabled");
      }
      
      public function get groupDeletionEnabled() : Boolean
      {
         return getBoolean("group.deletion.enabled");
      }
      
      public function get groupRoomInfoBadgeEnabled() : Boolean
      {
         return groupRoomInfoEnabled && getBoolean("groupRoomInfo.badge.enabled");
      }
      
      public function get toolbarAttachEnabled() : Boolean
      {
         return groupRoomInfoEnabled && getBoolean("groupRoomInfo.attach.enabled");
      }
      
      public function get isActivityDisplayEnabled() : Boolean
      {
         return getBoolean("activity.point.display.enabled");
      }
      
      public function get guildEditorData() : GuildEditorData
      {
         return _guildEditorData;
      }
      
      public function get avatarId() : int
      {
         return _avatarId;
      }
      
      public function get navigator() : IHabboNavigator_1
      {
         return _newNavigator.legacyNavigator;
      }
      
      public function get friendlist() : IHabboFriendList
      {
         return _friendlist;
      }
      
      public function get guildMembersWindowCtrl() : GuildMembersWindowCtrl
      {
         return _guildMembersWindowCtrl;
      }
      
      public function get habboTracking() : IHabboTracking
      {
         return _habboTracking;
      }
      
      public function trackGoogle(param1:String, param2:String, param3:int = -1) : void
      {
         if(_habboTracking != null)
         {
            _habboTracking.trackGoogle(param1,param2,param3);
         }
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return _toolbar;
      }
      
      public function updateVisibleExtendedProfile(param1:int) : void
      {
         UnknownVarFromHabboGroupsManager_ExtendedProfileWindowCtrl_1.updateVisibleExtendedProfile(param1);
      }
      
      public function showExtendedProfile(param1:int) : void
      {
         send(new GetExtendedProfileMessageComposer(param1));
      }
      
      public function openCatalog(param1:String) : void
      {
         _catalog.openCatalogPage(param1);
      }
      
      public function openVipPurchase(param1:String) : void
      {
         _catalog.openClubCenter();
      }
      
      public function get hasVip() : Boolean
      {
         return _hasVip;
      }
      
      public function handleUserKick(param1:int, param2:int) : void
      {
         UnknownVarFromHabboGroupsManager_GuildKickData_1 = new GuildKickData(param1,param2);
         send(new GetMemberGuildItemCountMessageComposer(param2,param1));
      }
      
      public function handleUserBlock(param1:int, param2:int) : void
      {
         UnknownVarFromHabboGroupsManager_GuildKickData_1 = new GuildKickData(param1,param2,true);
         send(new GetMemberGuildItemCountMessageComposer(param2,param1));
      }
      
      public function get newNavigator() : IHabboNewNavigator
      {
         return _newNavigator;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
   }
}

