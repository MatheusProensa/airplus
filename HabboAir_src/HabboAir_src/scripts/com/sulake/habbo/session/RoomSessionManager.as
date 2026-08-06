package com.sulake.habbo.session
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomVisualizationSettingsEvent;
   import com.sulake.habbo.communication.messages.outgoing.roomdirectory.RoomNetworkOpenConnectionMessageComposer;
   import com.sulake.habbo.freeflowchat.IHabboFreeFlowChat;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.session.handler.AvatarEffectsHandler;
   import com.sulake.habbo.session.handler.BaseHandler;
   import com.sulake.habbo.session.handler.GenericErrorHandler;
   import com.sulake.habbo.session.handler.PetPackageHandler;
   import com.sulake.habbo.session.handler.PollHandler;
   import com.sulake.habbo.session.handler.PresentHandler;
   import com.sulake.habbo.session.handler.RoomChatHandler;
   import com.sulake.habbo.session.handler.RoomDataHandler;
   import com.sulake.habbo.session.handler.RoomDimmerPresetsHandler;
   import com.sulake.habbo.session.handler.RoomPermissionsHandler;
   import com.sulake.habbo.session.handler.RoomSessionHandler;
   import com.sulake.habbo.session.handler.RoomUsersHandler;
   import com.sulake.habbo.session.handler.WordQuizHandler;
   import com.sulake.habbo.tracking.IHabboTracking;
   import com.sulake.iid.*;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.Vector3d;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.system.System;
   
   public class RoomSessionManager extends Component implements IRoomSessionManager, IRoomHandlerListener
   {
      public static const UnknownConstFromHabboAvatarEditorManager_Uint_3:uint = 2;
      
      public static const SETUP_WITHOUT_TRACKING:uint = 3;
      
      public static const UnknownConstFromRoomSessionManager_Uint_1:uint = 4;
      
      private static const UnknownConstFromRoomSessionManager_Number_1:Number = 0.26;
      
      private var _communication:IHabboCommunicationManager = null;
      
      private var _handlers:Array = null;
      
      private var UnknownVarFromRoomSessionManager_Boolean_1:Boolean = false;
      
      private var UnknownVarFromRoomSessionManager_Map_1:Map = null;
      
      private var UnknownVarFromRoomSessionManager_RoomSession_1:RoomSession;
      
      private var _sessionStarting:Boolean = false;
      
      private var _habboTracking:IHabboTracking;
      
      private var _roomEngine:IRoomEngine;
      
      private var _freeFlowChat:IHabboFreeFlowChat;
      
      private var UnknownVarFromRoomSessionManager_Boolean_2:Boolean;
      
      private var _avatarRenderer:IAvatarRenderManager;
      
      private var _roomViewerMode:Boolean;
      
      private var _pendingResources:Array;
      
      private var UnknownVarFromRoomSessionManager_RoomSession_2:RoomSession;
      
      public function RoomSessionManager(param1:IComponent_2, param2:uint = 0)
      {
         super(param1,param2);
         _roomViewerMode = (param2 & 1) != 0;
         _handlers = [];
         UnknownVarFromRoomSessionManager_Map_1 = new Map();
      }
      
      public function get initialized() : Boolean
      {
         return allRequiredDependenciesInjected && UnknownVarFromRoomSessionManager_Boolean_1;
      }
      
      public function get sessionStarting() : Boolean
      {
         return _sessionStarting;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communication = param1;
         },(flags & 2) == 0),new ComponentDependency(new IIDHabboTracking(),function(param1:IHabboTracking):void
         {
            _habboTracking = param1;
         },(flags & 3) == 0),new ComponentDependency(new IIDHabboFreeFlowChat(),function(param1:IHabboFreeFlowChat):void
         {
            _freeFlowChat = param1;
         },false),new ComponentDependency(new IIDHabboConfigurationManager(),null),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },(flags & 4) == 0,[{
            "type":"REE_ENGINE_INITIALIZED",
            "callback":onRoomEngineInitialized
         }]),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:IAvatarRenderManager):void
         {
            _avatarRenderer = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         createHandlers();
         if(_roomViewerMode && _communication != null)
         {
            _communication.addHabboConnectionMessageEvent(new RoomVisualizationSettingsEvent(onRoomVisualizationSettings));
         }
         executePendingSessionRequest();
      }
      
      override public function dispose() : void
      {
         var _loc4_:String = null;
         var _loc2_:RoomSession = null;
         var _loc3_:int = 0;
         var _loc1_:IComponentInterfaceQueue = null;
         if(disposed)
         {
            return;
         }
         if(UnknownVarFromRoomSessionManager_Map_1)
         {
            while(UnknownVarFromRoomSessionManager_Map_1.length > 0)
            {
               _loc4_ = UnknownVarFromRoomSessionManager_Map_1.getKey(0) as String;
               _loc2_ = UnknownVarFromRoomSessionManager_Map_1.remove(_loc4_) as RoomSession;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
            }
            UnknownVarFromRoomSessionManager_Map_1.dispose();
            UnknownVarFromRoomSessionManager_Map_1 = null;
         }
         if(_handlers)
         {
            _loc3_ = 0;
            while(_loc3_ < _handlers.length)
            {
               _loc1_ = _handlers[_loc3_] as IComponentInterfaceQueue;
               if(_loc1_)
               {
                  _loc1_.dispose();
               }
               _loc3_++;
            }
            _handlers = null;
         }
         super.dispose();
      }
      
      private function onRoomEngineInitialized(param1:RoomEngineEvent) : void
      {
         UnknownVarFromRoomSessionManager_Boolean_1 = true;
         executePendingSessionRequest();
      }
      
      private function createHandlers() : void
      {
         var _loc1_:IConnection = null;
         if(_communication)
         {
            _loc1_ = _communication.connection;
            _handlers.push(new RoomSessionHandler(_loc1_,this));
            _handlers.push(new RoomChatHandler(_loc1_,this));
            _handlers.push(new RoomUsersHandler(_loc1_,this));
            _handlers.push(new RoomPermissionsHandler(_loc1_,this));
            _handlers.push(new AvatarEffectsHandler(_loc1_,this));
            _handlers.push(new RoomDataHandler(_loc1_,this));
            _handlers.push(new PresentHandler(_loc1_,this));
            _handlers.push(new GenericErrorHandler(_loc1_,this));
            _handlers.push(new PollHandler(_loc1_,this));
            _handlers.push(new WordQuizHandler(_loc1_,this));
            _handlers.push(new RoomDimmerPresetsHandler(_loc1_,this));
            _handlers.push(new PetPackageHandler(_loc1_,this));
         }
      }
      
      private function executePendingSessionRequest() : void
      {
         if(initialized && UnknownVarFromRoomSessionManager_RoomSession_1 != null)
         {
            createSession(UnknownVarFromRoomSessionManager_RoomSession_1);
            UnknownVarFromRoomSessionManager_RoomSession_1 = null;
         }
      }
      
      private function onRoomVisualizationSettings(param1:RoomVisualizationSettingsEvent) : void
      {
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:DisplayObject = null;
         var _loc7_:IRoomGeometry = null;
         if(UnknownVarFromRoomSessionManager_Boolean_2 || !_roomViewerMode)
         {
            return;
         }
         UnknownVarFromRoomSessionManager_Boolean_2 = true;
         var _loc5_:IRoomSession = getSession(0);
         if(_loc5_ != null)
         {
            _loc3_ = 1;
            _loc8_ = 2;
            _loc2_ = 2;
            _loc6_ = 1024;
            _loc9_ = 768;
            _loc4_ = _roomEngine.createRoomCanvas(_loc5_.roomId,_loc3_,_loc6_,_loc9_,64);
            if(_loc4_ != null)
            {
               context.displayObjectContainer.addChild(_loc4_);
               context.displayObjectContainer.addEventListener("resize",onResize);
               _roomEngine.setRoomCanvasMask(_loc5_.roomId,_loc3_,true);
               _loc7_ = _roomEngine.getRoomCanvasGeometry(_loc5_.roomId,_loc3_);
               if(_loc7_ != null)
               {
                  _loc7_.adjustLocation(new Vector3d(_loc8_,_loc2_,0),30);
               }
               _roomEngine.setRoomCanvasScreenOffset(_loc5_.roomId,_loc3_,new Point(0,-400));
            }
            if(_freeFlowChat != null && _freeFlowChat.displayObject)
            {
               context.displayObjectContainer.addChild(_freeFlowChat.displayObject);
            }
         }
      }
      
      private function onResize(param1:Event) : void
      {
         if(!_roomViewerMode)
         {
            return;
         }
         var _loc2_:IRoomSession = getSession(0);
         if(_loc2_ == null)
         {
            return;
         }
         _roomEngine.modifyRoomCanvas(_loc2_.roomId,1,context.displayObjectContainer.width,context.displayObjectContainer.height);
      }
      
      public function gotoRoom(param1:int, param2:String = "", param3:String = "", param4:Boolean = false) : Boolean
      {
         var _loc5_:RoomSession = new RoomSession();
         _loc5_.roomId = param1;
         _loc5_.roomPassword = param2;
         _loc5_.roomResources = param3;
         _loc5_.skipOpc = param4;
         _loc5_.habboTracking = _habboTracking;
         return createSession(_loc5_);
      }
      
      public function gotoRoomNetwork(param1:int, param2:int) : Boolean
      {
         var _loc3_:RoomSession = new RoomSession();
         _loc3_.roomId = 1;
         _loc3_.roomPassword = "";
         _loc3_.habboTracking = _habboTracking;
         _loc3_.openConnectionComposer = new RoomNetworkOpenConnectionMessageComposer(param1,param2);
         return createSession(_loc3_);
      }
      
      private function createSession(param1:RoomSession) : Boolean
      {
         if(!initialized)
         {
            Logger.log("[RoomSessionManager] Not initialized, crating pending session for room: " + param1.roomId + ". Room Engine Initialized: " + UnknownVarFromRoomSessionManager_Boolean_1);
            UnknownVarFromRoomSessionManager_RoomSession_1 = param1;
            return false;
         }
         var _loc2_:String = getRoomIdentifier(param1.roomId);
         _sessionStarting = true;
         if(UnknownVarFromRoomSessionManager_Map_1.getValue(_loc2_) != null)
         {
            disposeSession(param1.roomId,false);
         }
         param1.connection = !!_communication ? _communication.connection : null;
         UnknownVarFromRoomSessionManager_Map_1.add(_loc2_,param1);
         events.dispatchEvent(new RoomSessionEvent("RSE_CREATED",param1));
         if(_roomViewerMode)
         {
            _roomEngine.events.addEventListener("RCLE_SUCCESS",onRoomContentLoaded);
            _pendingResources = [];
            UnknownVarFromRoomSessionManager_RoomSession_2 = param1;
            if(_pendingResources.length == 0)
            {
               startSession(param1);
            }
         }
         return true;
      }
      
      private function onRoomContentLoaded(param1:Event) : void
      {
         if(_pendingResources == null || _pendingResources.length == 0)
         {
            return;
         }
         var _loc2_:int = int(_pendingResources.indexOf(param1["contentType"]));
         if(_loc2_ != -1)
         {
            _pendingResources.splice(_loc2_,1);
         }
         if(_pendingResources.length == 0)
         {
            startSession(UnknownVarFromRoomSessionManager_RoomSession_2);
         }
      }
      
      public function startSession(param1:IRoomSession) : Boolean
      {
         if(param1.state == "RSE_STARTED")
         {
            return false;
         }
         if(param1.isGameSession)
         {
            return true;
         }
         if(param1.start())
         {
            _sessionStarting = false;
            events.dispatchEvent(new RoomSessionEvent("RSE_STARTED",param1));
            updateHandlers(param1);
            return true;
         }
         disposeSession(param1.roomId);
         _sessionStarting = false;
         return false;
      }
      
      public function startGameSession() : void
      {
         var _loc1_:RoomSession = new RoomSession();
         _loc1_.roomId = 1;
         _loc1_.habboTracking = _habboTracking;
         _loc1_.isGameSession = true;
         _loc1_.connection = _communication.connection;
         UnknownVarFromRoomSessionManager_Map_1.add(getRoomIdentifier(_loc1_.roomId),_loc1_);
         events.dispatchEvent(new RoomSessionEvent("RSE_CREATED",_loc1_));
      }
      
      public function disposeGameSession() : void
      {
         var _loc2_:String = getRoomIdentifier(1);
         var _loc1_:RoomSession = UnknownVarFromRoomSessionManager_Map_1.getValue(_loc2_);
         if(_loc1_ && _loc1_.isGameSession)
         {
            disposeSession(1,false);
         }
      }
      
      public function sessionUpdate(param1:int, param2:String) : void
      {
         var _loc3_:IRoomSession = getSession(param1);
         if(_loc3_ != null)
         {
            switch(param2)
            {
               case "RS_CONNECTED":
               case "RS_READY":
                  break;
               case "RS_DISCONNECTED":
                  disposeSession(param1);
            }
         }
      }
      
      public function sessionReinitialize(param1:int, param2:int) : void
      {
         var _loc5_:String = getRoomIdentifier(param1);
         var _loc3_:RoomSession = UnknownVarFromRoomSessionManager_Map_1.remove(_loc5_) as RoomSession;
         if(_loc3_ == null)
         {
            _loc3_ = new RoomSession();
            _loc3_.roomId = param1;
            _loc3_.skipOpc = true;
            _loc3_.habboTracking = _habboTracking;
            createSession(_loc3_);
         }
         _loc3_.reset(param2);
         _loc5_ = getRoomIdentifier(param2);
         var _loc4_:RoomSession = UnknownVarFromRoomSessionManager_Map_1.remove(_loc5_);
         if(_loc4_ != null)
         {
         }
         UnknownVarFromRoomSessionManager_Map_1.add(_loc5_,_loc3_);
         updateHandlers(_loc3_);
      }
      
      public function getSession(param1:int) : IRoomSession
      {
         var _loc2_:String = getRoomIdentifier(param1);
         return UnknownVarFromRoomSessionManager_Map_1.getValue(_loc2_) as IRoomSession;
      }
      
      public function disposeSession(param1:int, param2:Boolean = true) : void
      {
         var _loc4_:String = getRoomIdentifier(param1);
         var _loc3_:RoomSession = UnknownVarFromRoomSessionManager_Map_1.remove(_loc4_) as RoomSession;
         if(_loc3_ != null)
         {
            events.dispatchEvent(new RoomSessionEvent("RSE_ENDED",_loc3_,param2));
            _loc3_.dispose();
            _roomEngine.purgeRoomContent();
            if(!_avatarRenderer)
            {
            }
            System.pauseForGCIfCollectionImminent(0.26);
         }
      }
      
      private function updateHandlers(param1:IRoomSession) : void
      {
         var _loc3_:int = 0;
         var _loc2_:BaseHandler = null;
         if(param1 != null && _handlers != null)
         {
            _loc3_ = 0;
            while(_loc3_ < _handlers.length)
            {
               _loc2_ = _handlers[_loc3_] as BaseHandler;
               if(_loc2_ != null)
               {
                  _loc2_.UnknownVarFromBaseHandler_Int_1 = param1.roomId;
               }
               _loc3_++;
            }
         }
      }
      
      private function getRoomIdentifier(param1:int) : String
      {
         return "hard_coded_room_id";
      }
   }
}

