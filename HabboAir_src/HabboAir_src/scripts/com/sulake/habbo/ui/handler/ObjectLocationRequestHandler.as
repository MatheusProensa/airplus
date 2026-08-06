package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.IUserData;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserLocationUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetGetObjectLocationMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ObjectLocationRequestHandler implements IRoomWidgetHandler
   {
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      public function ObjectLocationRequestHandler()
      {
         super();
      }
      
      public function dispose() : void
      {
         _disposed = true;
         _container = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get type() : String
      {
         return null;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function getWidgetMessages() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push("RWGOI_MESSAGE_GET_OBJECT_LOCATION");
         _loc1_.push("RWGOI_MESSAGE_GET_GAME_OBJECT_LOCATION");
         return _loc1_;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:Rectangle = null;
         var _loc7_:Point = null;
         var _loc5_:Rectangle = null;
         var _loc3_:IUserData = null;
         if(!param1 || !_container)
         {
            return null;
         }
         var _loc4_:RoomWidgetGetObjectLocationMessage = param1 as RoomWidgetGetObjectLocationMessage;
         if(!_loc4_)
         {
            return null;
         }
         var _loc6_:IRoomSession = _container.roomSession;
         switch(param1.type)
         {
            case "RWGOI_MESSAGE_GET_OBJECT_LOCATION":
               if(!_loc6_ || !_loc6_.userDataManager)
               {
                  return null;
               }
               _loc3_ = _loc6_.userDataManager.getUserDataByType(_loc4_.objectId,_loc4_.objectType);
               if(_loc3_)
               {
                  _loc2_ = _container.roomEngine.getRoomObjectBoundingRectangle(_loc6_.roomId,_loc3_.roomObjectId,100,_container.getFirstCanvasId());
                  _loc7_ = _container.roomEngine.getRoomObjectScreenLocation(_loc6_.roomId,_loc3_.roomObjectId,100,_container.getFirstCanvasId());
                  _loc5_ = _container.getRoomViewRect();
                  if(_loc2_ && _loc5_ && _loc7_)
                  {
                     _loc2_.offset(_loc5_.x,_loc5_.y);
                     _loc7_.offset(_loc5_.x,_loc5_.y);
                  }
               }
               return new RoomWidgetUserLocationUpdateEvent(_loc4_.objectId,_loc2_,_loc7_);
               break;
            case "RWGOI_MESSAGE_GET_GAME_OBJECT_LOCATION":
               _loc2_ = _container.roomEngine.getRoomObjectBoundingRectangle(_loc6_.roomId,_loc4_.objectId,100,_container.getFirstCanvasId());
               _loc7_ = _container.roomEngine.getRoomObjectScreenLocation(_loc6_.roomId,_loc4_.objectId,100,_container.getFirstCanvasId());
               _loc5_ = _container.getRoomViewRect();
               if(_loc2_ && _loc5_ && _loc7_)
               {
                  _loc2_.offset(_loc5_.x,_loc5_.y);
                  _loc7_.offset(_loc5_.x,_loc5_.y);
               }
               return new RoomWidgetUserLocationUpdateEvent(_loc4_.objectId,_loc2_,_loc7_);
            default:
               return null;
         }
      }
      
      public function getProcessedEvents() : Array
      {
         return [];
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function update() : void
      {
      }
   }
}

