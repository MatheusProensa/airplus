package com.sulake.habbo.room.utils
{
   import com.sulake.core.utils.Map;
   
   [SecureSWF(rename="true")]
   public class RoomInstanceData
   {
      private var _roomId:int = 0;
      
      private var _furniStackingHeightMap:FurniStackingHeightMap = null;
      
      private var _legacyGeometry:LegacyWallGeometry = null;
      
      private var _tileObjectMap:TileObjectMap = null;
      
      private var _roomCamera:RoomCamera = null;
      
      private var _selectedObject:SelectedRoomObjectData = null;
      
      private var _placedObject:SelectedRoomObjectData = null;
      
      private var _worldType:String = null;
      
      private var UnknownVarFromRoomInstanceData_Map_1:Map = new Map();
      
      private var UnknownVarFromRoomInstanceData_Map_2:Map = new Map();
      
      private var _mouseButtonCursorOwners:Array = [];
      
      public function RoomInstanceData(param1:int)
      {
         super();
         _roomId = param1;
         _legacyGeometry = new LegacyWallGeometry();
         _roomCamera = new RoomCamera();
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get furniStackingHeightMap() : FurniStackingHeightMap
      {
         return _furniStackingHeightMap;
      }
      
      public function set furniStackingHeightMap(param1:FurniStackingHeightMap) : void
      {
         if(_furniStackingHeightMap != null)
         {
            _furniStackingHeightMap.dispose();
         }
         _furniStackingHeightMap = param1;
         if(_tileObjectMap)
         {
            _tileObjectMap.dispose();
         }
         if(_furniStackingHeightMap)
         {
            _tileObjectMap = new TileObjectMap(_furniStackingHeightMap.width,_furniStackingHeightMap.height);
         }
      }
      
      public function get legacyGeometry() : LegacyWallGeometry
      {
         return _legacyGeometry;
      }
      
      public function get tileObjectMap() : TileObjectMap
      {
         return _tileObjectMap;
      }
      
      public function get roomCamera() : RoomCamera
      {
         return _roomCamera;
      }
      
      public function get worldType() : String
      {
         return _worldType;
      }
      
      public function set worldType(param1:String) : void
      {
         _worldType = param1;
      }
      
      public function get selectedObject() : SelectedRoomObjectData
      {
         return _selectedObject;
      }
      
      public function set selectedObject(param1:SelectedRoomObjectData) : void
      {
         if(_selectedObject != null)
         {
            _selectedObject.dispose();
         }
         _selectedObject = param1;
      }
      
      public function get placedObject() : SelectedRoomObjectData
      {
         return _placedObject;
      }
      
      public function set placedObject(param1:SelectedRoomObjectData) : void
      {
         if(_placedObject != null)
         {
            _placedObject.dispose();
         }
         _placedObject = param1;
      }
      
      public function dispose() : void
      {
         if(_furniStackingHeightMap != null)
         {
            _furniStackingHeightMap.dispose();
            _furniStackingHeightMap = null;
         }
         if(_legacyGeometry != null)
         {
            _legacyGeometry.dispose();
            _legacyGeometry = null;
         }
         if(_roomCamera != null)
         {
            _roomCamera.dispose();
            _roomCamera = null;
         }
         if(_selectedObject != null)
         {
            _selectedObject.dispose();
            _selectedObject = null;
         }
         if(_placedObject != null)
         {
            _placedObject.dispose();
            _placedObject = null;
         }
         if(UnknownVarFromRoomInstanceData_Map_1 != null)
         {
            UnknownVarFromRoomInstanceData_Map_1.dispose();
            UnknownVarFromRoomInstanceData_Map_1 = null;
         }
         if(UnknownVarFromRoomInstanceData_Map_2 != null)
         {
            UnknownVarFromRoomInstanceData_Map_2.dispose();
            UnknownVarFromRoomInstanceData_Map_2 = null;
         }
         if(_tileObjectMap != null)
         {
            _tileObjectMap.dispose();
            _tileObjectMap = null;
         }
      }
      
      public function addFurnitureData(param1:FurnitureData) : void
      {
         if(param1 != null)
         {
            UnknownVarFromRoomInstanceData_Map_1.remove(param1.id);
            UnknownVarFromRoomInstanceData_Map_1.add(param1.id,param1);
         }
      }
      
      public function getFurnitureData() : FurnitureData
      {
         if(UnknownVarFromRoomInstanceData_Map_1.length > 0)
         {
            return getFurnitureDataWithId(UnknownVarFromRoomInstanceData_Map_1.getKey(0));
         }
         return null;
      }
      
      public function getFurnitureDataWithId(param1:int) : FurnitureData
      {
         return UnknownVarFromRoomInstanceData_Map_1.remove(param1);
      }
      
      public function addWallItemData(param1:FurnitureData) : void
      {
         if(param1 != null)
         {
            UnknownVarFromRoomInstanceData_Map_2.remove(param1.id);
            UnknownVarFromRoomInstanceData_Map_2.add(param1.id,param1);
         }
      }
      
      public function getWallItemData() : FurnitureData
      {
         if(UnknownVarFromRoomInstanceData_Map_2.length > 0)
         {
            return getWallItemDataWithId(UnknownVarFromRoomInstanceData_Map_2.getKey(0));
         }
         return null;
      }
      
      public function getWallItemDataWithId(param1:int) : FurnitureData
      {
         return UnknownVarFromRoomInstanceData_Map_2.remove(param1);
      }
      
      public function addButtonMouseCursorOwner(param1:String) : Boolean
      {
         var _loc2_:int = int(_mouseButtonCursorOwners.indexOf(param1));
         if(_loc2_ == -1)
         {
            _mouseButtonCursorOwners.push(param1);
            return true;
         }
         return false;
      }
      
      public function removeButtonMouseCursorOwner(param1:String) : Boolean
      {
         var _loc2_:int = int(_mouseButtonCursorOwners.indexOf(param1));
         if(_loc2_ > -1)
         {
            _mouseButtonCursorOwners.splice(_loc2_,1);
            return true;
         }
         return false;
      }
      
      public function hasButtonMouseCursorOwners() : Boolean
      {
         return _mouseButtonCursorOwners.length > 0;
      }
      
      public function get mouseButtonCursorOwners() : Array
      {
         return _mouseButtonCursorOwners;
      }
   }
}

