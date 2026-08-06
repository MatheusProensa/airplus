package com.sulake.room.object
{
   import com.sulake.room.object.logic.IRoomObjectEventHandler;
   import com.sulake.room.object.logic.IRoomObjectMouseHandler;
   import com.sulake.room.object.visualization.IRoomObjectVisualization;
   import com.sulake.room.utils.*;
   
   public class RoomObject implements IRoomObjectController
   {
      private static var UnknownVarFromRoomObject_Int_1:int = 0;
      
      private var _id:int;
      
      private var _type:String = "";
      
      private var UnknownVarFromRoomObject_Vector3d_1:Vector3d;
      
      private var UnknownVarFromRoomObject_Vector3d_2:Vector3d;
      
      private var UnknownVarFromRoomObject_Vector3d_3:Vector3d;
      
      private var UnknownVarFromRoomObject_Vector3d_4:Vector3d;
      
      private var UnknownVarFromRoomObject_Array_1:Array;
      
      private var _model:RoomObjectModel;
      
      private var _visualization:IRoomObjectVisualization;
      
      private var _eventHandler:IRoomObjectEventHandler;
      
      private var _updateID:int;
      
      private var _avatarLibraryAssetName:String;
      
      private var _instanceId:int = 0;
      
      private var _isInitialized:Boolean = false;
      
      public function RoomObject(param1:int, param2:int, param3:String)
      {
         var _loc4_:Number = NaN;
         super();
         _id = param1;
         UnknownVarFromRoomObject_Vector3d_1 = new Vector3d();
         UnknownVarFromRoomObject_Vector3d_2 = new Vector3d();
         UnknownVarFromRoomObject_Vector3d_3 = new Vector3d();
         UnknownVarFromRoomObject_Vector3d_4 = new Vector3d();
         UnknownVarFromRoomObject_Array_1 = new Array(param2);
         _loc4_ = param2 - 1;
         while(_loc4_ >= 0)
         {
            UnknownVarFromRoomObject_Array_1[_loc4_] = 0;
            _loc4_--;
         }
         _type = param3;
         _model = new RoomObjectModel();
         _visualization = null;
         _eventHandler = null;
         _updateID = 0;
         _instanceId = UnknownVarFromRoomObject_Int_1++;
      }
      
      public function dispose() : void
      {
         UnknownVarFromRoomObject_Vector3d_1 = null;
         UnknownVarFromRoomObject_Vector3d_2 = null;
         UnknownVarFromRoomObject_Array_1 = null;
         _avatarLibraryAssetName = null;
         setVisualization(null);
         setEventHandler(null);
         if(_model != null)
         {
            _model.dispose();
            _model = null;
         }
      }
      
      public function setInitialized(param1:Boolean) : void
      {
         _isInitialized = param1;
      }
      
      public function isInitialized() : Boolean
      {
         return _isInitialized;
      }
      
      public function getId() : int
      {
         return _id;
      }
      
      public function getInstanceId() : int
      {
         return _instanceId;
      }
      
      public function getType() : String
      {
         return _type;
      }
      
      public function getLocation() : IVector3d
      {
         UnknownVarFromRoomObject_Vector3d_3.assign(UnknownVarFromRoomObject_Vector3d_1);
         return UnknownVarFromRoomObject_Vector3d_3;
      }
      
      public function getDirection() : IVector3d
      {
         UnknownVarFromRoomObject_Vector3d_4.assign(UnknownVarFromRoomObject_Vector3d_2);
         return UnknownVarFromRoomObject_Vector3d_4;
      }
      
      public function getModel() : IRoomObjectModel
      {
         return _model;
      }
      
      public function getModelController() : IRoomObjectModelController
      {
         return _model;
      }
      
      public function getState(param1:int) : int
      {
         if(param1 >= 0 && param1 < UnknownVarFromRoomObject_Array_1.length)
         {
            return UnknownVarFromRoomObject_Array_1[param1];
         }
         return -1;
      }
      
      public function getVisualization() : IRoomObjectVisualization
      {
         return _visualization;
      }
      
      public function setLocation(param1:IVector3d) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(UnknownVarFromRoomObject_Vector3d_1.x != param1.x || UnknownVarFromRoomObject_Vector3d_1.y != param1.y || UnknownVarFromRoomObject_Vector3d_1.z != param1.z)
         {
            UnknownVarFromRoomObject_Vector3d_1.x = param1.x;
            UnknownVarFromRoomObject_Vector3d_1.y = param1.y;
            UnknownVarFromRoomObject_Vector3d_1.z = param1.z;
            _updateID++;
         }
      }
      
      public function setDirection(param1:IVector3d) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(UnknownVarFromRoomObject_Vector3d_2.x != param1.x || UnknownVarFromRoomObject_Vector3d_2.y != param1.y || UnknownVarFromRoomObject_Vector3d_2.z != param1.z)
         {
            UnknownVarFromRoomObject_Vector3d_2.x = (param1.x % 360 + 360) % 360;
            UnknownVarFromRoomObject_Vector3d_2.y = (param1.y % 360 + 360) % 360;
            UnknownVarFromRoomObject_Vector3d_2.z = (param1.z % 360 + 360) % 360;
            _updateID++;
         }
      }
      
      public function setState(param1:int, param2:int) : Boolean
      {
         if(param2 >= 0 && param2 < UnknownVarFromRoomObject_Array_1.length)
         {
            if(UnknownVarFromRoomObject_Array_1[param2] != param1)
            {
               UnknownVarFromRoomObject_Array_1[param2] = param1;
               _updateID++;
            }
            return true;
         }
         return false;
      }
      
      public function setVisualization(param1:IRoomObjectVisualization) : void
      {
         if(param1 != _visualization)
         {
            if(_visualization != null)
            {
               _visualization.dispose();
            }
            _visualization = param1;
            if(_visualization != null)
            {
               _visualization.object = this;
            }
         }
      }
      
      public function setEventHandler(param1:IRoomObjectEventHandler) : void
      {
         if(param1 == _eventHandler)
         {
            return;
         }
         var _loc2_:IRoomObjectEventHandler = _eventHandler;
         if(_loc2_ != null)
         {
            _eventHandler = null;
            _loc2_.object = null;
         }
         _eventHandler = param1;
         if(_eventHandler != null)
         {
            _eventHandler.object = this;
         }
      }
      
      public function getEventHandler() : IRoomObjectEventHandler
      {
         return _eventHandler;
      }
      
      public function getUpdateID() : int
      {
         return _updateID;
      }
      
      public function getMouseHandler() : IRoomObjectMouseHandler
      {
         return getEventHandler();
      }
      
      public function getAvatarLibraryAssetName() : String
      {
         if(!_avatarLibraryAssetName)
         {
            _avatarLibraryAssetName = "avatar_" + getId();
         }
         return _avatarLibraryAssetName;
      }
      
      public function tearDown() : void
      {
         if(_eventHandler)
         {
            _eventHandler.tearDown();
         }
      }
   }
}

