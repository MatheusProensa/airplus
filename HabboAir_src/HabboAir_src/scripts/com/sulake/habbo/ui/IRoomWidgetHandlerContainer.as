package com.sulake.habbo.ui
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.avatar.IHabboAvatarEditorManager;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.freeflowchat.IHabboFreeFlowChat;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.game.IHabboGameManager;
   import com.sulake.habbo.groups.IHabboGroupsManager;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.inventory.IHabboInventory;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.messenger.IHabboMessenger;
   import com.sulake.habbo.moderation.IHabboModeration;
   import com.sulake.habbo.navigator.IHabboNavigator_1;
   import com.sulake.habbo.quest.IHabboQuestEngine;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.sound.IHabboSoundManagerFlash10;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.room.object.IRoomObject;
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   
   public interface IRoomWidgetHandlerContainer
   {
      function get habboTracking() : IHabboTracking;
      
      function get roomSession() : IRoomSession;
      
      function get sessionDataManager() : ISessionDataManager;
      
      function get events() : IEventDispatcher;
      
      function get roomEngine() : IRoomEngine;
      
      function get friendList() : IHabboFriendList;
      
      function get avatarRenderManager() : IAvatarRenderManager;
      
      function get inventory() : IHabboInventory;
      
      function get toolbar() : IHabboToolbar;
      
      function get navigator() : IHabboNavigator_1;
      
      function get habboGroupsManager() : IHabboGroupsManager;
      
      function get roomWidgetFactory() : IRoomWidgetFactory;
      
      function get roomSessionManager() : IRoomSessionManager;
      
      function get avatarEditor() : IHabboAvatarEditorManager;
      
      function get catalog() : IHabboCatalog;
      
      function get localization() : IHabboLocalizationManager;
      
      function get habboHelp() : IHabboHelp;
      
      function get config() : IComponent_1;
      
      function get soundManager() : IHabboSoundManagerFlash10;
      
      function get messenger() : IHabboMessenger;
      
      function get moderation() : IHabboModeration;
      
      function get windowManager() : IHabboWindowManagerComponent;
      
      function get userDefinedRoomEvents() : IHabboUserDefinedRoomEvents;
      
      function get connection() : IConnection;
      
      function get gameManager() : IHabboGameManager;
      
      function get questEngine() : IHabboQuestEngine;
      
      function get freeFlowChat() : IHabboFreeFlowChat;
      
      function get layoutManager() : DesktopLayoutManager;
      
      function setRoomViewColor(param1:uint, param2:int) : void;
      
      function getFirstCanvasId() : int;
      
      function getRoomViewRect() : Rectangle;
      
      function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent;
      
      function addUpdateListener(param1:IRoomWidgetHandler) : void;
      
      function removeUpdateListener(param1:IRoomWidgetHandler) : void;
      
      function isOwnerOfFurniture(param1:IRoomObject) : Boolean;
      
      function getFurnitureOwnerId(param1:IRoomObject) : int;
      
      function isOwnerOfPet(param1:IUserData) : Boolean;
      
      function setRoomBackgroundColor(param1:int, param2:int, param3:int) : void;
   }
}

