package com.sulake.habbo.ui.handler
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.YoutubeControlVideoMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.YoutubeDisplayPlaylistsMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.YoutubeDisplayVideoMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.ControlYoutubeDisplayPlaybackMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.GetYoutubeDisplayStatusMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetYoutubeDisplayPlaylistMessageComposer;
   import com.sulake.habbo.communication.messages.parser.room.furniture.YoutubeControlVideoMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.furniture.YoutubeDisplayPlaylistsMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.furniture.YoutubeDisplayVideoMessageParser;
   import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.furniture.video.YoutubeDisplayWidget;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.room.object.IRoomObject;
   import flash.events.Event;
   
   public class FurnitureYoutubeDisplayWidgetHandler implements IRoomWidgetHandler
   {
      private static const CONTROL_COMMAND_PREVIOUS_VIDEO:int = 0;
      
      private static const CONTROL_COMMAND_NEXT_VIDEO:int = 1;
      
      private static const CONTROL_COMMAND_PAUSE_VIDEO:int = 2;
      
      private static const CONTROL_COMMAND_CONTINUE_VIDEO:int = 3;
      
      private var _container:IRoomWidgetHandlerContainer;
      
      private var UnknownVarFromFurnitureYoutubeDisplayWidgetHandler_YoutubeDisplayWidget_1:YoutubeDisplayWidget;
      
      private var UnknownVarFromFurnitureYoutubeDisplayWidgetHandler_Vector_1:Vector.<IMessageEvent>;
      
      public function FurnitureYoutubeDisplayWidgetHandler()
      {
         super();
      }
      
      public function get type() : String
      {
         return "RWE_YOUTUBE";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
         addMessageEvent(new YoutubeDisplayVideoMessageEvent(onVideo));
         addMessageEvent(new YoutubeDisplayPlaylistsMessageEvent(onPlaylists));
         addMessageEvent(new YoutubeControlVideoMessageEvent(onControlVideo));
      }
      
      private function addMessageEvent(param1:IMessageEvent) : void
      {
         if(UnknownVarFromFurnitureYoutubeDisplayWidgetHandler_Vector_1 == null)
         {
            UnknownVarFromFurnitureYoutubeDisplayWidgetHandler_Vector_1 = new Vector.<IMessageEvent>(0);
         }
         UnknownVarFromFurnitureYoutubeDisplayWidgetHandler_Vector_1.push(param1);
         _container.connection.addMessageEvent(param1);
      }
      
      private function removeEvents() : void
      {
         for each(var _loc1_ in UnknownVarFromFurnitureYoutubeDisplayWidgetHandler_Vector_1)
         {
            _container.connection.removeMessageEvent(_loc1_);
            _loc1_.dispose();
         }
      }
      
      private function onVideo(param1:YoutubeDisplayVideoMessageEvent) : void
      {
         var _loc2_:YoutubeDisplayVideoMessageParser = param1.getParser();
         UnknownVarFromFurnitureYoutubeDisplayWidgetHandler_YoutubeDisplayWidget_1.showVideo(_loc2_.furniId,_loc2_.videoId,_loc2_.startAtSeconds,_loc2_.endAtSeconds,_loc2_.state);
      }
      
      private function onControlVideo(param1:YoutubeControlVideoMessageEvent) : void
      {
         var _loc2_:YoutubeControlVideoMessageParser = param1.getParser();
         UnknownVarFromFurnitureYoutubeDisplayWidgetHandler_YoutubeDisplayWidget_1.controlVideo(_loc2_.furniId,_loc2_.commandId);
      }
      
      private function onPlaylists(param1:YoutubeDisplayPlaylistsMessageEvent) : void
      {
         var _loc2_:YoutubeDisplayPlaylistsMessageParser = param1.getParser();
         UnknownVarFromFurnitureYoutubeDisplayWidgetHandler_YoutubeDisplayWidget_1.populatePlaylists(_loc2_.furniId,_loc2_.playlists,_loc2_.selectedPlaylistId);
      }
      
      public function set widget(param1:YoutubeDisplayWidget) : void
      {
         UnknownVarFromFurnitureYoutubeDisplayWidgetHandler_YoutubeDisplayWidget_1 = param1;
      }
      
      public function getWidgetMessages() : Array
      {
         return null;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return [];
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc3_:Boolean = false;
         if(_container.roomEngine == null)
         {
            return;
         }
         var _loc4_:RoomEngineToWidgetEvent = param1 as RoomEngineToWidgetEvent;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc2_:IRoomObject = _container.roomEngine.getRoomObject(_loc4_.roomId,_loc4_.objectId,_loc4_.category);
         switch(param1.type)
         {
            case "RETWE_OPEN_WIDGET":
               if(_loc2_ != null)
               {
                  _loc3_ = _container.isOwnerOfFurniture(_loc2_) || _container.sessionDataManager.hasSecurity(4);
                  UnknownVarFromFurnitureYoutubeDisplayWidgetHandler_YoutubeDisplayWidget_1.show(_loc2_,_loc3_);
                  _container.connection.send(new GetYoutubeDisplayStatusMessageComposer(_loc2_.getId()));
               }
               break;
            case "RETWE_CLOSE_WIDGET":
               UnknownVarFromFurnitureYoutubeDisplayWidgetHandler_YoutubeDisplayWidget_1.hide(_loc2_);
         }
      }
      
      public function update() : void
      {
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         removeEvents();
         _container = null;
      }
      
      public function get disposed() : Boolean
      {
         return _container == null;
      }
      
      public function selectPlaylist(param1:int, param2:String) : void
      {
         _container.connection.send(new SetYoutubeDisplayPlaylistMessageComposer(param1,param2));
      }
      
      public function switchToPreviousVideo(param1:int) : void
      {
         _container.connection.send(new ControlYoutubeDisplayPlaybackMessageComposer(param1,0));
      }
      
      public function switchToNextVideo(param1:int) : void
      {
         _container.connection.send(new ControlYoutubeDisplayPlaybackMessageComposer(param1,1));
      }
      
      public function pauseVideo(param1:int) : void
      {
         _container.connection.send(new ControlYoutubeDisplayPlaybackMessageComposer(param1,2));
      }
      
      public function continueVideo(param1:int) : void
      {
         _container.connection.send(new ControlYoutubeDisplayPlaybackMessageComposer(param1,3));
      }
   }
}

