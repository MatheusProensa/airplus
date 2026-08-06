package com.sulake.room.object.logic
{
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.IRoomObjectController;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.events.IEventDispatcher;
   
   public class ObjectLogicBase implements IRoomObjectEventHandler
   {
      private var _eventDispatcher:IEventDispatcher;
      
      private var _object:IRoomObjectController;
      
      public function ObjectLogicBase()
      {
         super();
      }
      
      public function get eventDispatcher() : IEventDispatcher
      {
         return _eventDispatcher;
      }
      
      public function set eventDispatcher(param1:IEventDispatcher) : void
      {
         _eventDispatcher = param1;
      }
      
      public function getEventTypes() : Array
      {
         return [];
      }
      
      protected function getAllEventTypes(param1:Array, param2:Array) : Array
      {
         var _loc3_:Array = param1.concat();
         for each(var _loc4_ in param2)
         {
            if(_loc3_.indexOf(_loc4_) < 0)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      public function dispose() : void
      {
         _object = null;
      }
      
      public function set object(param1:IRoomObjectController) : void
      {
         if(_object == param1)
         {
            return;
         }
         if(_object != null)
         {
            _object.setEventHandler(null);
         }
         if(param1 == null)
         {
            dispose();
            _object = null;
         }
         else
         {
            _object = param1;
            _object.setEventHandler(this);
         }
      }
      
      public function get object() : IRoomObjectController
      {
         return _object;
      }
      
      public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
      }
      
      public function initialize(param1:XML) : void
      {
      }
      
      public function update(param1:int) : void
      {
      }
      
      public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         if(param1 != null)
         {
            if(_object != null)
            {
               _object.setLocation(param1.loc);
               _object.setDirection(param1.dir);
            }
         }
      }
      
      public function useObject() : void
      {
      }
      
      public function tearDown() : void
      {
      }
      
      public function get widget() : String
      {
         return null;
      }
      
      public function get contextMenu() : String
      {
         return null;
      }
   }
}

