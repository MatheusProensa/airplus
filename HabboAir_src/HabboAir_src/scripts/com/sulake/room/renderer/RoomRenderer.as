package com.sulake.room.renderer
{
   import com.sulake.core.runtime.Component;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.utils.Map;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.RoomGeometry;
   import flash.utils.getTimer;
   
   [SecureSWF(rename="true")]
   public class RoomRenderer implements IRoomRenderer, IRoomRenderer_1
   {
      private var UnknownVarFromRoomRenderer_Map_1:Map;
      
      private var _canvases:Map;
      
      private var UnknownVarFromRoomRenderer_Component_1:Component;
      
      private var _disposed:Boolean = false;
      
      private var _roomObjectVariableAccurateZ:String = null;
      
      public function RoomRenderer(param1:Component)
      {
         super();
         UnknownVarFromRoomRenderer_Map_1 = new Map();
         _canvases = new Map();
         if(param1 != null)
         {
            UnknownVarFromRoomRenderer_Component_1 = param1;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get roomObjectVariableAccurateZ() : String
      {
         return _roomObjectVariableAccurateZ;
      }
      
      public function set roomObjectVariableAccurateZ(param1:String) : void
      {
         _roomObjectVariableAccurateZ = param1;
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:RoomSpriteCanvas = null;
         if(disposed)
         {
            return;
         }
         if(_canvases != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _canvases.length)
            {
               _loc1_ = _canvases.getWithIndex(_loc2_) as RoomSpriteCanvas;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            _canvases.dispose();
            _canvases = null;
         }
         if(UnknownVarFromRoomRenderer_Map_1 != null)
         {
            UnknownVarFromRoomRenderer_Map_1.dispose();
            UnknownVarFromRoomRenderer_Map_1 = null;
         }
         if(UnknownVarFromRoomRenderer_Component_1 != null)
         {
            UnknownVarFromRoomRenderer_Component_1 = null;
         }
         _disposed = true;
      }
      
      public function reset() : void
      {
         UnknownVarFromRoomRenderer_Map_1.reset();
      }
      
      public function getRoomObjectIdentifier(param1:IRoomObject) : String
      {
         if(param1 != null)
         {
            return String(param1.getInstanceId());
         }
         return null;
      }
      
      public function feedRoomObject(param1:IRoomObject) : void
      {
         if(param1 == null)
         {
            return;
         }
         UnknownVarFromRoomRenderer_Map_1.add(getRoomObjectIdentifier(param1),param1);
      }
      
      public function removeRoomObject(param1:IRoomObject) : void
      {
         var _loc3_:int = 0;
         var _loc2_:RoomSpriteCanvas = null;
         var _loc4_:String = getRoomObjectIdentifier(param1);
         UnknownVarFromRoomRenderer_Map_1.remove(_loc4_);
         _loc3_ = 0;
         while(_loc3_ < _canvases.length)
         {
            _loc2_ = _canvases.getWithIndex(_loc3_) as RoomSpriteCanvas;
            if(_loc2_ != null)
            {
               _loc2_.roomObjectRemoved(_loc4_);
            }
            _loc3_++;
         }
      }
      
      public function getRoomObject(param1:String) : IRoomObject
      {
         return UnknownVarFromRoomRenderer_Map_1.getValue(param1) as IRoomObject;
      }
      
      public function getRoomObjectWithIndex(param1:int) : IRoomObject
      {
         return UnknownVarFromRoomRenderer_Map_1.getWithIndex(param1) as IRoomObject;
      }
      
      public function getRoomObjectIdWithIndex(param1:int) : String
      {
         return UnknownVarFromRoomRenderer_Map_1.getKey(param1) as String;
      }
      
      public function getRoomObjectCount() : int
      {
         return UnknownVarFromRoomRenderer_Map_1.length;
      }
      
      public function render() : void
      {
         var _loc3_:int = 0;
         var _loc2_:IRoomRenderingCanvas = null;
         var _loc1_:int = getTimer();
         ErrorReportStorage.addDebugData("Canvas count",String(_canvases.length));
         _loc3_ = _canvases.length - 1;
         while(_loc3_ >= 0)
         {
            _loc2_ = _canvases.getWithIndex(_loc3_) as IRoomRenderingCanvas;
            if(_loc2_ != null)
            {
               _loc2_.render(_loc1_);
            }
            _loc3_--;
         }
      }
      
      public function createCanvas(param1:int, param2:int, param3:int, param4:int) : IRoomRenderingCanvas
      {
         var _loc6_:RoomGeometry = null;
         var _loc5_:IRoomRenderingCanvas = _canvases.getValue(String(param1)) as IRoomRenderingCanvas;
         if(_loc5_ != null)
         {
            _loc5_.initialize(param2,param3);
            _loc6_ = _loc5_.geometry as RoomGeometry;
            if(_loc6_)
            {
               _loc6_.scale = param4;
            }
            return _loc5_;
         }
         _loc5_ = createCanvasInstance(param1,param2,param3,param4);
         _canvases.add(String(param1),_loc5_);
         return _loc5_;
      }
      
      protected function createCanvasInstance(param1:int, param2:int, param3:int, param4:int) : IRoomRenderingCanvas
      {
         return new RotatingRoomSpriteCanvas(this,param1,param2,param3,param4);
      }
      
      public function getCanvas(param1:int) : IRoomRenderingCanvas
      {
         return _canvases.getValue(String(param1)) as IRoomRenderingCanvas;
      }
      
      public function disposeCanvas(param1:int) : Boolean
      {
         var _loc2_:RoomSpriteCanvas = _canvases.remove(String(param1)) as RoomSpriteCanvas;
         if(_loc2_ != null)
         {
            _loc2_.dispose();
         }
         return false;
      }
      
      public function update(param1:uint) : void
      {
         var _loc3_:int = 0;
         var _loc2_:RoomSpriteCanvas = null;
         render();
         _loc3_ = _canvases.length - 1;
         while(_loc3_ >= 0)
         {
            _loc2_ = _canvases.getWithIndex(_loc3_) as RoomSpriteCanvas;
            if(_loc2_ != null)
            {
               _loc2_.update();
            }
            _loc3_--;
         }
      }
   }
}

