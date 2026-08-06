package com.sulake.habbo.room
{
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.habbo.room.utils.FurniStackingHeightMap;
   import com.sulake.habbo.room.utils.LegacyWallGeometry;
   import com.sulake.habbo.room.utils.TileObjectMap;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.room.IRoomInstance;
   import com.sulake.room.object.IRoomObjectController;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.RoomGeometry;
   
   [SecureSWF(rename="true")]
   public interface IRoomEngine_4 extends IRoomEngine_1
   {
      function initializeRoom(param1:int, param2:XML, param3:IVector3d = null, param4:Vector.<IAreaHideInfo> = null) : void;
      
      function getRoom(param1:int) : IRoomInstance;
      
      function disposeRoom(param1:int) : void;
      
      function setOwnUserId(param1:int, param2:int) : void;
      
      function setWorldType(param1:int, param2:String) : void;
      
      function getObjectRoom(param1:int) : IRoomObjectController;
      
      function setFurniStackingHeightMap(param1:int, param2:FurniStackingHeightMap) : void;
      
      function getFurniStackingHeightMap(param1:int) : FurniStackingHeightMap;
      
      function getLegacyGeometry(param1:int) : LegacyWallGeometry;
      
      function getRoomGeometry(param1:int) : RoomGeometry;
      
      function getTileObjectMap(param1:int) : TileObjectMap;
      
      function getRoomNumberValue(param1:int, param2:String) : Number;
      
      function getRoomStringValue(param1:int, param2:String) : String;
      
      function setIsPlayingGame(param1:int, param2:Boolean) : void;
      
      function leaveSpectate() : void;
      
      function refreshTileObjectMap(param1:int, param2:String) : void;
      
      function get configuration() : IComponent_1;
      
      function get roomSessionManager() : IRoomSessionManager;
      
      function get sessionDataManager() : ISessionDataManager;
      
      function get windowManager() : IHabboWindowManagerComponent;
      
      function setHanditemControlBlocked(param1:int, param2:Boolean) : void;
      
      function setChooserDisabled(param1:int, param2:Boolean) : void;
      
      function setFreeFurniMovementsMode(param1:int, param2:Boolean) : void;
      
      function setInvisibleFurni(param1:int, param2:Boolean) : void;
   }
}

