package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.room.object.data.HighScoreStuffData;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.furniture.highscore.HighScoreDisplayWidget;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class HighScoreFurniWidgetHandler implements IRoomWidgetHandler
   {
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var UnknownVarFromHighScoreFurniWidgetHandler_HighScoreDisplayWidget_1:HighScoreDisplayWidget = null;
      
      private var UnknownVarFromHighScoreFurniWidgetHandler_RoomEngineObjectEvent_1:RoomEngineObjectEvent = null;
      
      public function HighScoreFurniWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get type() : String
      {
         return "RWE_HIGH_SCORE_DISPLAY";
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function set widget(param1:HighScoreDisplayWidget) : void
      {
         UnknownVarFromHighScoreFurniWidgetHandler_HighScoreDisplayWidget_1 = param1;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
         _container.addUpdateListener(this);
      }
      
      public function dispose() : void
      {
         if(_container)
         {
            _container.removeUpdateListener(this);
         }
         _disposed = true;
         _container = null;
         UnknownVarFromHighScoreFurniWidgetHandler_HighScoreDisplayWidget_1 = null;
      }
      
      public function getProcessedEvents() : Array
      {
         return ["RETWE_REQUEST_HIGH_SCORE_DISPLAY","RETWE_REQUEST_HIDE_HIGH_SCORE_DISPLAY"];
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc4_:RoomEngineObjectEvent = null;
         var _loc2_:IRoomObject = null;
         var _loc5_:IRoomObjectModel = null;
         var _loc3_:HighScoreStuffData = null;
         if(disposed || param1 == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "RETWE_REQUEST_HIGH_SCORE_DISPLAY":
               _loc4_ = RoomEngineObjectEvent(param1);
               _loc2_ = _container.roomEngine.getRoomObject(_loc4_.roomId,_loc4_.objectId,_loc4_.category);
               if(_loc2_ != null)
               {
                  _loc5_ = _loc2_.getModel();
                  if(_loc5_ != null)
                  {
                     _loc3_ = new HighScoreStuffData();
                     _loc3_.initializeFromRoomObjectModel(_loc5_);
                     UnknownVarFromHighScoreFurniWidgetHandler_HighScoreDisplayWidget_1.open(_loc4_.objectId,_loc4_.roomId,_loc3_);
                  }
                  UnknownVarFromHighScoreFurniWidgetHandler_RoomEngineObjectEvent_1 = _loc4_;
               }
               break;
            case "RETWE_REQUEST_HIDE_HIGH_SCORE_DISPLAY":
               _loc4_ = RoomEngineObjectEvent(param1);
               if(_loc4_.roomId == UnknownVarFromHighScoreFurniWidgetHandler_HighScoreDisplayWidget_1.roomId && _loc4_.objectId == UnknownVarFromHighScoreFurniWidgetHandler_HighScoreDisplayWidget_1.roomObjId)
               {
                  UnknownVarFromHighScoreFurniWidgetHandler_HighScoreDisplayWidget_1.close();
               }
         }
      }
      
      public function getWidgetMessages() : Array
      {
         return null;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         return null;
      }
      
      public function update() : void
      {
         var _loc1_:IRoomObject = null;
         var _loc2_:Point = null;
         if(UnknownVarFromHighScoreFurniWidgetHandler_RoomEngineObjectEvent_1 && UnknownVarFromHighScoreFurniWidgetHandler_HighScoreDisplayWidget_1.isOpen && UnknownVarFromHighScoreFurniWidgetHandler_HighScoreDisplayWidget_1.roomId == UnknownVarFromHighScoreFurniWidgetHandler_RoomEngineObjectEvent_1.roomId && UnknownVarFromHighScoreFurniWidgetHandler_HighScoreDisplayWidget_1.roomObjId == UnknownVarFromHighScoreFurniWidgetHandler_RoomEngineObjectEvent_1.objectId)
         {
            _loc1_ = _container.roomEngine.getRoomObject(UnknownVarFromHighScoreFurniWidgetHandler_RoomEngineObjectEvent_1.roomId,UnknownVarFromHighScoreFurniWidgetHandler_RoomEngineObjectEvent_1.objectId,UnknownVarFromHighScoreFurniWidgetHandler_RoomEngineObjectEvent_1.category);
            if(_loc1_ != null)
            {
               _loc2_ = _container.roomEngine.getRoomObjectScreenLocation(UnknownVarFromHighScoreFurniWidgetHandler_RoomEngineObjectEvent_1.roomId,UnknownVarFromHighScoreFurniWidgetHandler_RoomEngineObjectEvent_1.objectId,UnknownVarFromHighScoreFurniWidgetHandler_RoomEngineObjectEvent_1.category);
               if(_loc2_ != null)
               {
                  UnknownVarFromHighScoreFurniWidgetHandler_HighScoreDisplayWidget_1.setRelativePositionToRoomObjectAt(_loc2_.x,_loc2_.y);
               }
            }
         }
      }
   }
}

