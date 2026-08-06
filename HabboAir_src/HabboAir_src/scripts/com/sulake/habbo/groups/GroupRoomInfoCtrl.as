package com.sulake.habbo.groups
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.GuestRoomData;
   import com.sulake.habbo.communication.messages.incoming.users.HabboGroupDetailsData;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetGuildEditInfoMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.GetHabboGroupDetailsMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.users.JoinHabboGroupMessageComposer;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   
   public class GroupRoomInfoCtrl implements IComponentInterfaceQueue
   {
      private static const TOOLBAR_EXTENSION_ID:String = "room_group_info";
      
      private var UnknownVarFromGroupRoomInfoCtrl_HabboGroupsManager_1:HabboGroupsManager;
      
      private var _window:IWindowController_1;
      
      private var _expanded:Boolean = true;
      
      private var _group:HabboGroupDetailsData;
      
      private var UnknownVarFromGroupRoomInfoCtrl_Int_1:int;
      
      public function GroupRoomInfoCtrl(param1:HabboGroupsManager)
      {
         super();
         UnknownVarFromGroupRoomInfoCtrl_HabboGroupsManager_1 = param1;
      }
      
      public function dispose() : void
      {
         if(toolbarAttachAllowed())
         {
            UnknownVarFromGroupRoomInfoCtrl_HabboGroupsManager_1.toolbar.extensionView.detachExtension("room_group_info");
         }
         UnknownVarFromGroupRoomInfoCtrl_HabboGroupsManager_1 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromGroupRoomInfoCtrl_HabboGroupsManager_1 == null;
      }
      
      public function onRoomInfo(param1:GuestRoomData) : void
      {
         if(!UnknownVarFromGroupRoomInfoCtrl_HabboGroupsManager_1.groupRoomInfoEnabled)
         {
            return;
         }
         if(param1.habboGroupId > 0)
         {
            UnknownVarFromGroupRoomInfoCtrl_Int_1 = param1.habboGroupId;
            UnknownVarFromGroupRoomInfoCtrl_HabboGroupsManager_1.send(new GetHabboGroupDetailsMessageComposer(param1.habboGroupId,false));
         }
         else
         {
            UnknownVarFromGroupRoomInfoCtrl_Int_1 = 0;
            close();
         }
      }
      
      public function onGroupDeactivated(param1:int) : void
      {
         if(param1 == _group.groupId || param1 == UnknownVarFromGroupRoomInfoCtrl_Int_1)
         {
            expectedGroupId = 0;
            close();
         }
      }
      
      public function onGroupDetails(param1:HabboGroupDetailsData) : void
      {
         if(!UnknownVarFromGroupRoomInfoCtrl_HabboGroupsManager_1.groupRoomInfoEnabled)
         {
            return;
         }
         if(param1.groupId == UnknownVarFromGroupRoomInfoCtrl_Int_1)
         {
            _expanded = true;
            _group = param1;
            refresh();
         }
      }
      
      public function isDisplayingGroup(param1:int) : Boolean
      {
         return _window != null && _group != null && param1 == _group.groupId;
      }
      
      private function refresh() : void
      {
         if(!_group.isGuild)
         {
            return;
         }
         prepareWindow();
         _window.findChildByName("bg_expanded").visible = _expanded;
         _window.findChildByName("bg_contracted").visible = !_expanded;
         _window.findChildByName("group_name_txt").visible = _expanded;
         _window.findChildByName("join_button").visible = _expanded && _group.joiningAllowed;
         _window.findChildByName("join_button").enable();
         _window.findChildByName("request_membership_button").visible = _expanded && _group.requestMembershipAllowed;
         _window.findChildByName("manage_button").visible = _expanded && _group.isOwner;
         _window.findChildByName("group_logo").visible = _expanded;
         _window.findChildByName("group_name_txt").caption = _group.groupName;
         _window.findChildByName("info_region").visible = _expanded;
         var _loc1_:IBadgeImageWidget = IWidgetWindowController(_window.findChildByName("group_logo")).widget as IBadgeImageWidget;
         _loc1_.badgeId = _group.badgeCode;
         _loc1_.groupId = _group.groupId;
         _window.x = 0;
         _window.y = 0;
         _window.height = _expanded ? _window.findChildByName("bg_expanded").height : int(_window.findChildByName("bg_contracted").height);
         if(toolbarAttachAllowed())
         {
            UnknownVarFromGroupRoomInfoCtrl_HabboGroupsManager_1.toolbar.extensionView.attachExtension("room_group_info",_window,-1,["next_quest_timer","quest_tracker","event_info_window"]);
         }
      }
      
      private function prepareWindow() : void
      {
         if(this._window != null)
         {
            return;
         }
         _window = IWindowController_1(UnknownVarFromGroupRoomInfoCtrl_HabboGroupsManager_1.getXmlWindow("group_room_info"));
         _window.findChildByName("join_button").procedure = onJoin;
         _window.findChildByName("request_membership_button").procedure = onJoin;
         _window.findChildByName("manage_button").procedure = onManage;
         _window.findChildByName("title_region").procedure = onTitleClick;
         _window.findChildByName("info_region").procedure = onInfoClick;
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            if(toolbarAttachAllowed())
            {
               UnknownVarFromGroupRoomInfoCtrl_HabboGroupsManager_1.toolbar.extensionView.detachExtension("room_group_info");
            }
            UnknownVarFromGroupRoomInfoCtrl_Int_1 = 0;
            _group = null;
         }
      }
      
      private function onTitleClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         _expanded = !_expanded;
         refresh();
         UnknownVarFromGroupRoomInfoCtrl_HabboGroupsManager_1.toolbar.events.dispatchEvent(new HabboToolbarEvent("HTE_GROUP_ROOM_INFO_CLICK"));
      }
      
      private function onInfoClick(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            UnknownVarFromGroupRoomInfoCtrl_HabboGroupsManager_1.trackGoogle("groupRoomInfo","groupInfo");
            UnknownVarFromGroupRoomInfoCtrl_HabboGroupsManager_1.send(new GetHabboGroupDetailsMessageComposer(_group.groupId,true));
            UnknownVarFromGroupRoomInfoCtrl_HabboGroupsManager_1.toolbar.events.dispatchEvent(new HabboToolbarEvent("HTE_GROUP_ROOM_INFO_CLICK"));
         }
      }
      
      private function onManage(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            UnknownVarFromGroupRoomInfoCtrl_HabboGroupsManager_1.trackGoogle("groupRoomInfo","manageGroup");
            UnknownVarFromGroupRoomInfoCtrl_HabboGroupsManager_1.send(new GetGuildEditInfoMessageComposer(_group.groupId));
            UnknownVarFromGroupRoomInfoCtrl_HabboGroupsManager_1.toolbar.events.dispatchEvent(new HabboToolbarEvent("HTE_GROUP_ROOM_INFO_CLICK"));
         }
      }
      
      private function onJoin(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(param1.type == "WME_CLICK")
         {
            UnknownVarFromGroupRoomInfoCtrl_HabboGroupsManager_1.trackGoogle("groupRoomInfo","joinGroup");
            _window.findChildByName("join_button").disable();
            UnknownVarFromGroupRoomInfoCtrl_HabboGroupsManager_1.send(new JoinHabboGroupMessageComposer(_group.groupId));
            UnknownVarFromGroupRoomInfoCtrl_HabboGroupsManager_1.send(new EventLogMessageComposer("HabboGroups","" + _group.groupId,"join"));
            UnknownVarFromGroupRoomInfoCtrl_HabboGroupsManager_1.toolbar.events.dispatchEvent(new HabboToolbarEvent("HTE_GROUP_ROOM_INFO_CLICK"));
         }
      }
      
      public function set expectedGroupId(param1:int) : void
      {
         UnknownVarFromGroupRoomInfoCtrl_Int_1 = param1;
      }
      
      private function toolbarAttachAllowed() : Boolean
      {
         return UnknownVarFromGroupRoomInfoCtrl_HabboGroupsManager_1 != null && UnknownVarFromGroupRoomInfoCtrl_HabboGroupsManager_1.toolbar != null && UnknownVarFromGroupRoomInfoCtrl_HabboGroupsManager_1.toolbar.extensionView != null && UnknownVarFromGroupRoomInfoCtrl_HabboGroupsManager_1.toolbarAttachEnabled;
      }
   }
}

