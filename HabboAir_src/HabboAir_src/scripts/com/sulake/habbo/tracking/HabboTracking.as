package com.sulake.habbo.tracking
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.runtime.events.ErrorEvent;
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.habbo.advertisement.events.AdEvent;
   import com.sulake.habbo.catalog.navigation.events.CatalogPageOpenedEvent;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.handshake.AuthenticationOKMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.notifications.HabboAchievementNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomEntryInfoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.tracking.LatencyPingResponseMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementNotificationMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.RoomEntryInfoMessageParser;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.room.events.RoomObjectRoomAdEvent;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.iid.*;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.external.ExternalInterface;
   import flash.system.Capabilities;
   import flash.system.System;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class HabboTracking extends Component implements IHabboTracking, IProfiler_1
   {
      private static const ERROR_DATA_FLAG_COUNT:uint = 11;
      
      private static var UnknownVarFromHabboTracking_HabboTracking_1:HabboTracking;
      
      private var _communication:IHabboCommunicationManager;
      
      private var UnknownVarFromHabboTracking_Array_1:Array;
      
      private var UnknownVarFromHabboTracking_Boolean_1:Boolean = false;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var UnknownVarFromHabboTracking_PerformanceTracker_1:PerformanceTracker = null;
      
      private var UnknownVarFromHabboTracking_FramerateTracker_1:FramerateTracker = null;
      
      private var UnknownVarFromHabboTracking_LatencyTracker_1:LatencyTracker = null;
      
      private var UnknownVarFromHabboTracking_LagWarningLogger_1:LagWarningLogger = null;
      
      private var UnknownVarFromHabboTracking_ToolbarClickTracker_1:ToolbarClickTracker = null;
      
      private var _roomEngine:IRoomEngine = null;
      
      private var UnknownVarFromHabboTracking_Boolean_2:Boolean = false;
      
      private var _currentTime:int = -1;
      
      private var UnknownVarFromHabboTracking_Int_1:int = 0;
      
      private var UnknownVarFromHabboTracking_Int_2:int = 0;
      
      private var UnknownVarFromHabboTracking_Timer_1:Timer;
      
      private var UnknownVarFromHabboTracking_Int_3:int = 0;
      
      private var UnknownVarFromHabboTracking_Int_4:int = -1;
      
      private var onceTrackedEvents:Vector.<String>;
      
      public var WindowManager:HabboWindowManagerComponent;
      
      public function HabboTracking(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         var _loc5_:* = 0;
         onceTrackedEvents = new Vector.<String>(0);
         if(UnknownVarFromHabboTracking_HabboTracking_1 == null)
         {
            UnknownVarFromHabboTracking_HabboTracking_1 = this;
         }
         UnknownVarFromHabboTracking_Array_1 = new Array(11);
         _loc5_ = 0;
         while(_loc5_ < 11)
         {
            UnknownVarFromHabboTracking_Array_1[_loc5_] = 0;
            _loc5_++;
         }
         super(param1,param2,param3);
         var _loc6_:String = "WIN63-202607011411-782849652";
         var _loc4_:IComponent_2 = param1.root;
         if(_loc4_ != null)
         {
            _loc4_.events.addEventListener("COMPONENT_EVENT_ERROR",onError);
            ErrorReportStorage.setParameter("start_time",new Date().getTime().toString());
            ErrorReportStorage.setParameter("agent",_loc6_);
            ErrorReportStorage.setParameter("system",Capabilities.serverString);
            ErrorReportStorage.setParameter("in_room","false");
            ErrorReportStorage.setParameter("last_room","0");
         }
         registerUpdateReceiver(this,1);
      }
      
      public static function getInstance() : HabboTracking
      {
         return UnknownVarFromHabboTracking_HabboTracking_1;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboConfigurationManager(),function(param1:IComponent_1):void
         {
            if(param1 != null)
            {
               setErrorContextFlag(1,0);
            }
         },false,[{
            "type":"complete",
            "callback":onConfigurationComplete
         }]),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            if(param1 != null)
            {
               setErrorContextFlag(1,1);
            }
         },false),new ComponentDependency(new IIDHabboWindowManager(),null,false,[{
            "type":"HABBO_WINDOW_TRACKING_EVENT_INPUT",
            "callback":onWindowTrackingEvent
         },{
            "type":"HABBO_WINDOW_TRACKING_EVENT_RENDER",
            "callback":onWindowTrackingEvent
         },{
            "type":"HABBO_WINDOW_TRACKING_EVENT_SLEEP",
            "callback":onWindowTrackingEvent
         }]),new ComponentDependency(new IIDHabboNavigator(),null,false,[{
            "type":"HABBO_NAVIGATOR_TRACKING_EVENT_CLOSED",
            "callback":onNavigatorTrackingEvent
         },{
            "type":"HABBO_NAVIGATOR_TRACKING_EVENT_EVENTS",
            "callback":onNavigatorTrackingEvent
         },{
            "type":"HABBO_NAVIGATOR_TRACKING_EVENT_ROOMS",
            "callback":onNavigatorTrackingEvent
         },{
            "type":"HABBO_NAVIGATOR_TRACKING_EVENT_ME",
            "callback":onNavigatorTrackingEvent
         },{
            "type":"HABBO_NAVIGATOR_TRACKING_EVENT_SEARCH",
            "callback":onNavigatorTrackingEvent
         },{
            "type":"HABBO_NAVIGATOR_TRACKING_EVENT_OFFICIAL",
            "callback":onNavigatorTrackingEvent
         },{
            "type":"HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FAVOURITES",
            "callback":onNavigatorTrackingEvent
         },{
            "type":"HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FRIENDS_ROOMS",
            "callback":onNavigatorTrackingEvent
         },{
            "type":"HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_HISTORY",
            "callback":onNavigatorTrackingEvent
         },{
            "type":"HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_ROOMS",
            "callback":onNavigatorTrackingEvent
         },{
            "type":"HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_OFFICIALROOMS",
            "callback":onNavigatorTrackingEvent
         },{
            "type":"HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_POPULAR_ROOMS",
            "callback":onNavigatorTrackingEvent
         },{
            "type":"HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WHERE_MY_FRIENDS_ARE",
            "callback":onNavigatorTrackingEvent
         },{
            "type":"HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WITH_HIGHEST_SCORE",
            "callback":onNavigatorTrackingEvent
         },{
            "type":"HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TAG_SEARCH",
            "callback":onNavigatorTrackingEvent
         },{
            "type":"HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TEXT_SEARCH",
            "callback":onNavigatorTrackingEvent
         },{
            "type":"HABBO_ROOM_SETTINGS_TRACKING_EVENT_CLOSED",
            "callback":onRoomSettingsTrackingEvent
         },{
            "type":"HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT",
            "callback":onRoomSettingsTrackingEvent
         },{
            "type":"HABBO_ROOM_SETTINGS_TRACKING_EVENT_ADVANCED",
            "callback":onRoomSettingsTrackingEvent
         },{
            "type":"HABBO_ROOM_SETTINGS_TRACKING_EVENT_THUMBS",
            "callback":onRoomSettingsTrackingEvent
         },{
            "type":"HTIE_ICON_ZOOM",
            "callback":onZoomToggle
         }]),new ComponentDependency(new IIDHabboCatalog(),null,false,[{
            "type":"CATALOG_PAGE_OPENED",
            "callback":onCatalogPageOpened
         },{
            "type":"HABBO_CATALOG_TRACKING_EVENT_OPEN",
            "callback":onCatalogTrackingEvent
         },{
            "type":"HABBO_CATALOG_TRACKING_EVENT_CLOSE",
            "callback":onCatalogTrackingEvent
         },{
            "type":"CATALOG_FURNI_PURCHASE",
            "callback":onCatalogTrackingEvent
         }]),new ComponentDependency(new IIDHabboInventory(),null,false,[{
            "type":"HABBO_INVENTORY_TRACKING_EVENT_CLOSED",
            "callback":onInventoryTrackingEvent
         },{
            "type":"HABBO_INVENTORY_TRACKING_EVENT_FURNI",
            "callback":onInventoryTrackingEvent
         },{
            "type":"HABBO_INVENTORY_TRACKING_EVENT_POSTERS",
            "callback":onInventoryTrackingEvent
         },{
            "type":"HABBO_INVENTORY_TRACKING_EVENT_BADGES",
            "callback":onInventoryTrackingEvent
         },{
            "type":"HABBO_INVENTORY_TRACKING_EVENT_ACHIEVEMENTS",
            "callback":onInventoryTrackingEvent
         },{
            "type":"HABBO_INVENTORY_TRACKING_EVENT_TRADING",
            "callback":onInventoryTrackingEvent
         }]),new ComponentDependency(new IIDHabboFriendList(),null,false,[{
            "type":"HABBO_FRIENDLIST_TRACKING_EVENT_CLOSED",
            "callback":onFriendlistTrackingEvent
         },{
            "type":"HABBO_FRIENDLIST_TRACKING_EVENT_FRIENDS",
            "callback":onFriendlistTrackingEvent
         },{
            "type":"HABBO_FRIENDLIST_TRACKING_EVENT_SEARCH",
            "callback":onFriendlistTrackingEvent
         },{
            "type":"HABBO_FRIENDLIST_TRACKING_EVENT_REQUEST",
            "callback":onFriendlistTrackingEvent
         },{
            "type":"HABBO_FRIENDLIST_TRACKING_EVENT_MINIMZED",
            "callback":onFriendlistTrackingEvent
         }]),new ComponentDependency(new IIDHabboHelp(),null,false,[{
            "type":"HABBO_HELP_TRACKING_EVENT_CLOSED",
            "callback":onHelpTrackingEvent
         },{
            "type":"HABBO_HELP_TRACKING_EVENT_DEFAULT",
            "callback":onHelpTrackingEvent
         }]),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },false,[{
            "type":"RORAE_ROOM_AD_FURNI_CLICK",
            "callback":onRoomAdClick
         },{
            "type":"REE_INITIALIZED",
            "callback":onRoomAction
         },{
            "type":"REE_DISPOSED",
            "callback":onRoomAction
         }]),new ComponentDependency(new IIDHabboAdManager(),null,false,[{
            "type":"AE_ROOM_AD_SHOW",
            "callback":onRoomAdLoad
         }]),new ComponentDependency(new IIDHabboToolbar(),null,false,[{
            "type":"HTE_TOOLBAR_CLICK",
            "callback":onToolbarClick
         }])]);
      }
      
      override protected function initComponent() : void
      {
         UnknownVarFromHabboTracking_LatencyTracker_1 = new LatencyTracker(this);
         UnknownVarFromHabboTracking_PerformanceTracker_1 = new PerformanceTracker(this);
         UnknownVarFromHabboTracking_FramerateTracker_1 = new FramerateTracker(this);
         UnknownVarFromHabboTracking_LagWarningLogger_1 = new LagWarningLogger(this);
         UnknownVarFromHabboTracking_ToolbarClickTracker_1 = new ToolbarClickTracker(this);
         _messageEvents = new Vector.<IMessageEvent>(0);
         addMessageEvent(new AuthenticationOKMessageEvent(onAuthOK));
         addMessageEvent(new RoomEntryInfoMessageEvent(onRoomEnter));
         addMessageEvent(new HabboAchievementNotificationMessageEvent(onAchievementNotification));
         addMessageEvent(new LatencyPingResponseMessageEvent(onPingResponse));
         var _loc1_:IEventDispatcher = Component(context).events;
         _loc1_.addEventListener("HABBO_CONNECTION_EVENT_INIT",onConnectionEvent);
         _loc1_.addEventListener("HABBO_CONNECTION_EVENT_ESTABLISHED",onConnectionEvent);
         _loc1_.addEventListener("HABBO_CONNECTION_EVENT_HANDSHAKING",onConnectionEvent);
         _loc1_.addEventListener("HABBO_CONNECTION_EVENT_HANDSHAKED",onConnectionEvent);
         _loc1_.addEventListener("HABBO_CONNECTION_EVENT_HANDSHAKE_FAIL",onConnectionEvent);
         _loc1_.addEventListener("HABBO_CONNECTION_EVENT_AUTHENTICATED",onConnectionEvent);
         _loc1_.addEventListener("HHVE_START_LOAD",onHotelViewEvent);
         _loc1_.addEventListener("HHVE_ERROR",onHotelViewEvent);
         _loc1_.addEventListener("HHVE_LOADED",onHotelViewEvent);
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
         if(UnknownVarFromHabboTracking_HabboTracking_1 == this)
         {
            UnknownVarFromHabboTracking_HabboTracking_1 = null;
         }
         removeUpdateReceiver(this);
         if(_messageEvents != null && _communication != null)
         {
            for each(var _loc1_ in _messageEvents)
            {
               _communication.removeHabboConnectionMessageEvent(_loc1_);
            }
         }
         UnknownVarFromHabboTracking_PerformanceTracker_1 = null;
         UnknownVarFromHabboTracking_FramerateTracker_1 = null;
         UnknownVarFromHabboTracking_ToolbarClickTracker_1 = null;
         if(UnknownVarFromHabboTracking_LatencyTracker_1 != null)
         {
            UnknownVarFromHabboTracking_LatencyTracker_1.dispose();
            UnknownVarFromHabboTracking_LatencyTracker_1 = null;
         }
         if(UnknownVarFromHabboTracking_Timer_1)
         {
            UnknownVarFromHabboTracking_Timer_1.stop();
            UnknownVarFromHabboTracking_Timer_1.removeEventListener("timer",onRoomActionTimerEvent);
            UnknownVarFromHabboTracking_Timer_1 = null;
         }
         super.dispose();
      }
      
      private function setErrorContextFlag(param1:uint, param2:uint) : void
      {
         UnknownVarFromHabboTracking_Array_1[param2] = param1;
      }
      
      private function onHotelViewEvent(param1:Event) : void
      {
         switch(param1.type)
         {
            case "HHVE_START_LOAD":
               trackLoginStep("client.init.hotelview.start");
               break;
            case "HHVE_LOADED":
               trackLoginStep("client.init.hotelview.ok");
               break;
            case "HHVE_ERROR":
               trackLoginStep("client.init.hotelview.fail");
         }
      }
      
      private function onConnectionEvent(param1:Event) : void
      {
         switch(param1.type)
         {
            case "HABBO_CONNECTION_EVENT_INIT":
               trackLoginStep("client.init.socket.init");
               break;
            case "HABBO_CONNECTION_EVENT_ESTABLISHED":
               trackLoginStep("client.init.socket.ok",String(_communication.port));
               break;
            case "HABBO_CONNECTION_EVENT_HANDSHAKING":
               trackLoginStep("client.init.handshake.start");
               break;
            case "HABBO_CONNECTION_EVENT_HANDSHAKE_FAIL":
               trackLoginStep("client.init.handshake.fail");
               break;
            case "HABBO_CONNECTION_EVENT_HANDSHAKED":
               setErrorContextFlag(2,0);
               trackLoginStep("client.init.handshake.ok");
               break;
            case "HABBO_CONNECTION_EVENT_AUTHENTICATED":
               setErrorContextFlag(3,0);
               loadConversionTrackingFrame();
               trackLoginStep("client.init.auth.ok");
         }
         Component(context).events.removeEventListener(param1.type,onConnectionEvent);
      }
      
      private function onWindowTrackingEvent(param1:Event) : void
      {
         switch(param1.type)
         {
            case "HABBO_WINDOW_TRACKING_EVENT_SLEEP":
               setErrorContextFlag(0,3);
               break;
            case "HABBO_WINDOW_TRACKING_EVENT_RENDER":
               setErrorContextFlag(1,3);
               break;
            case "HABBO_WINDOW_TRACKING_EVENT_INPUT":
               setErrorContextFlag(2,3);
         }
      }
      
      private function onError(param1:ErrorEvent) : void
      {
         storeErrorDetails(param1);
         if(param1.critical)
         {
            UnknownVarFromHabboTracking_Boolean_1 = true;
         }
         logError(context.root.getLastErrorMessage());
      }
      
      private function storeErrorDetails(param1:ErrorEvent) : void
      {
         var _loc3_:String = null;
         ErrorReportStorage.setParameter("is_fatal",param1.critical.toString());
         ErrorReportStorage.setParameter("crash_time",new Date().getTime().toString());
         var _loc4_:String = "";
         for each(var _loc2_ in UnknownVarFromHabboTracking_Array_1)
         {
            _loc4_ += String(_loc2_);
         }
         ErrorReportStorage.setParameter("error_ctx",_loc4_);
         if(UnknownVarFromHabboTracking_PerformanceTracker_1 != null)
         {
            ErrorReportStorage.setParameter("flash_version",UnknownVarFromHabboTracking_PerformanceTracker_1.flashVersion);
            ErrorReportStorage.setParameter("avg_update",String(UnknownVarFromHabboTracking_PerformanceTracker_1.averageUpdateInterval));
         }
         ErrorReportStorage.setParameter("error_desc",param1.message);
         ErrorReportStorage.setParameter("error_cat",String(param1.category));
         if(param1.error != null)
         {
            _loc3_ = Exception.getChainedStackTrace(param1.error);
            if(_loc3_ != null)
            {
               ErrorReportStorage.setParameter("error_data",_loc3_);
            }
         }
         _communication.setMessageQueueErrorDebugData();
         ErrorReportStorage.addDebugData("Flash memory usage","Memory usage: " + Math.round(System.totalMemory / 1048576) + " MB");
      }
      
      private function onNavigatorTrackingEvent(param1:Event) : void
      {
         switch(param1.type)
         {
            case "HABBO_NAVIGATOR_TRACKING_EVENT_CLOSED":
               setErrorContextFlag(0,4);
               break;
            case "HABBO_NAVIGATOR_TRACKING_EVENT_EVENTS":
               setErrorContextFlag(1,4);
               break;
            case "HABBO_NAVIGATOR_TRACKING_EVENT_ROOMS":
               setErrorContextFlag(2,4);
               break;
            case "HABBO_NAVIGATOR_TRACKING_EVENT_ME":
               setErrorContextFlag(3,4);
               break;
            case "HABBO_NAVIGATOR_TRACKING_EVENT_OFFICIAL":
               setErrorContextFlag(4,4);
               break;
            case "HABBO_NAVIGATOR_TRACKING_EVENT_SEARCH":
               setErrorContextFlag(5,4);
               break;
            case "HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FAVOURITES":
               legacyTrackGoogle("navigator","my_favorites");
               break;
            case "HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_FRIENDS_ROOMS":
               legacyTrackGoogle("navigator","my_friends_rooms");
               break;
            case "HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_HISTORY":
               legacyTrackGoogle("navigator","my_history");
               break;
            case "HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_MY_ROOMS":
               legacyTrackGoogle("navigator","my_rooms");
               break;
            case "HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_OFFICIALROOMS":
               legacyTrackGoogle("navigator","official_rooms");
               break;
            case "HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_POPULAR_ROOMS":
               legacyTrackGoogle("navigator","popular_rooms");
               break;
            case "HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WHERE_MY_FRIENDS_ARE":
               legacyTrackGoogle("navigator","rooms_where_my_friends_are");
               break;
            case "HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_ROOMS_WITH_HIGHEST_SCORE":
               legacyTrackGoogle("navigator","highest_score");
               break;
            case "HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TAG_SEARCH":
               legacyTrackGoogle("navigator","tag_search");
               break;
            case "HABBO_NAVIGATOR_TRACKING_EVENT_SEARCHTYPE_TEXT_SEARCH":
               legacyTrackGoogle("navigator","text_search");
         }
      }
      
      private function onRoomSettingsTrackingEvent(param1:Event) : void
      {
         switch(param1.type)
         {
            case "HABBO_ROOM_SETTINGS_TRACKING_EVENT_CLOSED":
               setErrorContextFlag(0,7);
               break;
            case "HABBO_ROOM_SETTINGS_TRACKING_EVENT_DEFAULT":
               setErrorContextFlag(1,7);
               break;
            case "HABBO_ROOM_SETTINGS_TRACKING_EVENT_ADVANCED":
               setErrorContextFlag(2,7);
         }
      }
      
      private function onInventoryTrackingEvent(param1:Event) : void
      {
         switch(param1.type)
         {
            case "HABBO_INVENTORY_TRACKING_EVENT_CLOSED":
               setErrorContextFlag(0,5);
               break;
            case "HABBO_INVENTORY_TRACKING_EVENT_FURNI":
               setErrorContextFlag(1,5);
               break;
            case "HABBO_INVENTORY_TRACKING_EVENT_POSTERS":
               setErrorContextFlag(2,5);
               break;
            case "HABBO_INVENTORY_TRACKING_EVENT_BADGES":
               setErrorContextFlag(3,5);
               break;
            case "HABBO_INVENTORY_TRACKING_EVENT_ACHIEVEMENTS":
               setErrorContextFlag(4,5);
               break;
            case "HABBO_INVENTORY_TRACKING_EVENT_TRADING":
               setErrorContextFlag(5,5);
         }
      }
      
      private function onAchievementNotification(param1:HabboAchievementNotificationMessageEvent) : void
      {
         var _loc2_:HabboAchievementNotificationMessageParser = param1.getParser();
         legacyTrackGoogle("achievement","achievement",[_loc2_.data.badgeCode]);
      }
      
      private function onCatalogPageOpened(param1:CatalogPageOpenedEvent) : void
      {
         legacyTrackGoogle("catalogue","page",[param1.pageLocalization]);
      }
      
      private function onCatalogTrackingEvent(param1:Event) : void
      {
         switch(param1.type)
         {
            case "HABBO_CATALOG_TRACKING_EVENT_OPEN":
               setErrorContextFlag(1,9);
               break;
            case "HABBO_CATALOG_TRACKING_EVENT_CLOSE":
               setErrorContextFlag(0,9);
         }
      }
      
      private function onFriendlistTrackingEvent(param1:Event) : void
      {
         switch(param1.type)
         {
            case "HABBO_FRIENDLIST_TRACKING_EVENT_CLOSED":
               setErrorContextFlag(0,6);
               break;
            case "HABBO_FRIENDLIST_TRACKING_EVENT_FRIENDS":
               setErrorContextFlag(1,6);
               break;
            case "HABBO_FRIENDLIST_TRACKING_EVENT_SEARCH":
               setErrorContextFlag(2,6);
               break;
            case "HABBO_FRIENDLIST_TRACKING_EVENT_REQUEST":
               setErrorContextFlag(3,6);
               break;
            case "HABBO_FRIENDLIST_TRACKING_EVENT_MINIMZED":
               setErrorContextFlag(4,6);
         }
      }
      
      private function onHelpTrackingEvent(param1:Event) : void
      {
         switch(param1.type)
         {
            case "HABBO_HELP_TRACKING_EVENT_CLOSED":
               setErrorContextFlag(0,10);
               break;
            case "HABBO_HELP_TRACKING_EVENT_DEFAULT":
               setErrorContextFlag(1,10);
         }
      }
      
      private function onAuthOK(param1:IMessageEvent) : void
      {
         legacyTrackGoogle("authentication","authok");
      }
      
      private function onPingResponse(param1:LatencyPingResponseMessageEvent) : void
      {
         if(UnknownVarFromHabboTracking_LatencyTracker_1 != null)
         {
            UnknownVarFromHabboTracking_LatencyTracker_1.onPingResponse(param1);
         }
      }
      
      private function onRoomEnter(param1:IMessageEvent) : void
      {
         if(!UnknownVarFromHabboTracking_Boolean_2)
         {
            trackLoginStep("client.init.room.enter");
            UnknownVarFromHabboTracking_Boolean_2 = true;
         }
         var _loc2_:RoomEntryInfoMessageParser = RoomEntryInfoMessageEvent(param1).getParser();
         ErrorReportStorage.setParameter("last_room",String(_loc2_.guestRoomId));
         ErrorReportStorage.setParameter("in_room","true");
         legacyTrackGoogle("navigator","private",[_loc2_.guestRoomId]);
      }
      
      private function onConfigurationComplete(param1:Event) : void
      {
         if(UnknownVarFromHabboTracking_LatencyTracker_1 != null)
         {
            UnknownVarFromHabboTracking_LatencyTracker_1.init();
         }
      }
      
      private function onRoomAdLoad(param1:AdEvent) : void
      {
         legacyTrackGoogle("room_ad","show",[getAliasFromAdTechUrl(param1.clickUrl)]);
      }
      
      private function onRoomAdClick(param1:RoomObjectRoomAdEvent) : void
      {
         legacyTrackGoogle("room_ad","click",[getAliasFromAdTechUrl(param1.clickUrl)]);
      }
      
      private function getAliasFromAdTechUrl(param1:String) : String
      {
         var _loc2_:Array = param1.match(/;alias=([^;]+)/);
         if(_loc2_ != null && _loc2_.length > 1)
         {
            return _loc2_[1];
         }
         return "unknown";
      }
      
      private function onRoomAction(param1:RoomEngineEvent) : void
      {
         if(param1.type == "REE_INITIALIZED")
         {
            if(!UnknownVarFromHabboTracking_Timer_1)
            {
               UnknownVarFromHabboTracking_Int_4 = param1.roomId;
               UnknownVarFromHabboTracking_Timer_1 = new Timer(60000,1);
               UnknownVarFromHabboTracking_Timer_1.addEventListener("timer",onRoomActionTimerEvent);
               UnknownVarFromHabboTracking_Timer_1.start();
            }
         }
         else if(param1.type == "REE_DISPOSED")
         {
            if(UnknownVarFromHabboTracking_Timer_1)
            {
               UnknownVarFromHabboTracking_Timer_1.removeEventListener("timer",onRoomActionTimerEvent);
               UnknownVarFromHabboTracking_Timer_1.stop();
               UnknownVarFromHabboTracking_Timer_1 = null;
               UnknownVarFromHabboTracking_Int_4 = -1;
            }
         }
      }
      
      private function onRoomActionTimerEvent(param1:TimerEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(!disposed && !UnknownVarFromHabboTracking_Boolean_1 && _communication != null && UnknownVarFromHabboTracking_FramerateTracker_1)
         {
            _loc2_ = null;
            if(_roomEngine != null)
            {
               _loc3_ = _roomEngine.getRoomObjectCount(_roomEngine.activeRoomId,100);
               _loc4_ = _roomEngine.getRoomObjectCount(_roomEngine.activeRoomId,10) + _roomEngine.getRoomObjectCount(_roomEngine.activeRoomId,20);
               _loc2_ = "Avatars: " + _loc3_ + ", Objects: " + _loc4_;
            }
            trackEventLog("ClientPerformance",String(UnknownVarFromHabboTracking_FramerateTracker_1.frameRate),"fps",_loc2_,UnknownVarFromHabboTracking_Int_4);
            UnknownVarFromHabboTracking_Int_3++;
         }
      }
      
      private function onToolbarClick(param1:HabboToolbarEvent) : void
      {
         if(UnknownVarFromHabboTracking_ToolbarClickTracker_1)
         {
            UnknownVarFromHabboTracking_ToolbarClickTracker_1.track(param1.iconName);
         }
      }
      
      private function onZoomToggle(param1:HabboToolbarEvent) : void
      {
         if(UnknownVarFromHabboTracking_ToolbarClickTracker_1)
         {
            UnknownVarFromHabboTracking_ToolbarClickTracker_1.track(param1.type);
         }
      }
      
      public function legacyTrackGoogle(param1:String, param2:String, param3:Array = null) : void
      {
         try
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("FlashExternalInterface.legacyTrack",param1,param2,param3 == null ? [] : param3);
            }
            else
            {
               Logger.log("ExternalInterface is not available, tracking is disabled");
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function trackGoogle(param1:String, param2:String, param3:int = -1) : void
      {
         Logger.log("trackGoogle(" + param1 + ", " + param2 + ", " + param3 + ")");
         try
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("FlashExternalInterface.track",param1,param2,param3);
            }
            else
            {
               Logger.log("ExternalInterface is not available, tracking is disabled");
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function loadConversionTrackingFrame() : void
      {
         try
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("FlashExternalInterface.loadConversionTrackingFrame");
            }
            else
            {
               Logger.log("ExternalInterface is not available!");
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function trackLoginStep(param1:String, param2:String = null) : void
      {
         Logger.log("* Track Login Step: " + param1);
         if(!getBoolean("processlog.enabled"))
         {
            return;
         }
         try
         {
            if(ExternalInterface.available)
            {
               if(param2 != null)
               {
                  ExternalInterface.call("FlashExternalInterface.logLoginStep",param1,param2);
               }
               else
               {
                  ExternalInterface.call("FlashExternalInterface.logLoginStep",param1);
               }
            }
            else
            {
               Logger.log("ExternalInterface is not available, tracking is disabled");
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function trackEventLog(param1:String, param2:String, param3:String, param4:String = "", param5:int = 0) : void
      {
         if(_communication != null && _communication.connection != null && _communication.connection.connected)
         {
            _communication.connection.send(new EventLogMessageComposer(param1,param2,param3,param4,param5));
         }
      }
      
      public function trackEventLogOncePerSession(param1:String, param2:String, param3:String, param4:String = "", param5:int = 0) : void
      {
         var _loc7_:* = 0;
         var _loc8_:String = param1 + param2 + param3;
         var _loc6_:Boolean = false;
         _loc7_ = 0;
         while(_loc7_ < onceTrackedEvents.length)
         {
            if(onceTrackedEvents[_loc7_] == _loc8_)
            {
               _loc6_ = true;
               break;
            }
            _loc7_++;
         }
         if(!_loc6_)
         {
            trackEventLog(param1,param2,param3,param4,param5);
            onceTrackedEvents.push(_loc8_);
         }
      }
      
      public function trackTalentTrackOpen(param1:String, param2:String) : void
      {
         trackEventLog("Talent",param1,"talent.open",param2);
      }
      
      public function logError(param1:String) : void
      {
         Logger.log("logError(" + param1 + ")");
         try
         {
            if(ExternalInterface.available)
            {
               ExternalInterface.call("FlashExternalInterface.logError",param1);
            }
            else
            {
               Logger.log("ExternalInterface is not available, tracking is disabled");
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function chatLagDetected(param1:int) : void
      {
         UnknownVarFromHabboTracking_LagWarningLogger_1.chatLagDetected(param1);
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:int = getTimer();
         if(_currentTime > -1 && _loc2_ < _currentTime)
         {
            UnknownVarFromHabboTracking_Int_1++;
            ErrorReportStorage.addDebugData("Invalid time counter","Invalid times: " + UnknownVarFromHabboTracking_Int_1);
         }
         if(_currentTime > -1 && _loc2_ - _currentTime > 15000)
         {
            UnknownVarFromHabboTracking_Int_2++;
            ErrorReportStorage.addDebugData("Time leap counter","Time leaps: " + UnknownVarFromHabboTracking_Int_2);
         }
         _currentTime = _loc2_;
         if(UnknownVarFromHabboTracking_PerformanceTracker_1 != null)
         {
            UnknownVarFromHabboTracking_PerformanceTracker_1.update(param1,_currentTime);
         }
         if(UnknownVarFromHabboTracking_LatencyTracker_1 != null)
         {
            UnknownVarFromHabboTracking_LatencyTracker_1.update(param1,_currentTime);
         }
         if(UnknownVarFromHabboTracking_FramerateTracker_1 != null)
         {
            UnknownVarFromHabboTracking_FramerateTracker_1.trackUpdate(param1,_currentTime);
         }
         if(UnknownVarFromHabboTracking_LagWarningLogger_1 != null)
         {
            UnknownVarFromHabboTracking_LagWarningLogger_1.update(_currentTime);
         }
      }
      
      public function get latencyPingMs() : int
      {
         return UnknownVarFromHabboTracking_LatencyTracker_1 != null ? UnknownVarFromHabboTracking_LatencyTracker_1.latestLatency : -1;
      }
      
      public function get communication() : IHabboCommunicationManager
      {
         return _communication;
      }
      
      public function send(param1:IMessageComposer) : void
      {
         if(_communication != null && _communication.connection != null && _communication.connection.connected)
         {
            _communication.connection.send(param1);
         }
      }
   }
}

