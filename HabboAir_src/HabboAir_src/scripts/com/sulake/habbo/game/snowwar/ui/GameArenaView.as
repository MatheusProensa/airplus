package com.sulake.habbo.game.snowwar.ui
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.avatar.IAvatarFigureContainer;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.FuseObjectData;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLevelData;
   import com.sulake.habbo.game.snowwar.KeyboardControl;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.SnowWarGameArena;
   import com.sulake.habbo.game.snowwar.SnowWarGameStage;
   import com.sulake.habbo.game.snowwar.Tile;
   import com.sulake.habbo.game.snowwar.arena.IGameObject;
   import com.sulake.habbo.game.snowwar.arena.ISynchronizedGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.SnowBallGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.SnowWarGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.SnowballMachineGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.SnowballPileGameObject;
   import com.sulake.habbo.game.snowwar.gameobjects.TreeGameObject;
   import com.sulake.habbo.game.snowwar.utils.Direction360;
   import com.sulake.habbo.game.snowwar.utils.Direction8;
   import com.sulake.habbo.room.IRoomEngine_2;
   import com.sulake.habbo.room.IRoomEngine_4;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.RoomEngine;
   import com.sulake.habbo.room.object.RoomPlaneParser;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectController;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class GameArenaView implements IComponentInterfaceQueue
   {
      private static const GAME_ROOM_ID:int = 1;
      
      private static const TILE_CURSOR_STATE_TEAM_1:int = 3;
      
      private static const TILE_CURSOR_STATE_TEAM_2:int = 2;
      
      private static const TILE_CURSOR_STATE_TEAM_3:int = 4;
      
      private static const TILE_CURSOR_STATE_TEAM_4:int = 5;
      
      private static const EFFECT_RED_TEAM:int = 95;
      
      private static const EFFECT_BLUE_TEAM:int = 96;
      
      private static const EFFECT_CROSSHAIR:int = 98;
      
      private static const SPLASH_LIFE_SPAN_TIME:int = 500;
      
      private var UnknownVarFromGameArenaView_SnowWarEngine_1:SnowWarEngine;
      
      private var UnknownVarFromGameArenaView_Array_1:Array = [];
      
      private var UnknownVarFromGameArenaView_Array_2:Array = [];
      
      private var UnknownVarFromGameArenaView_Array_3:Array = [];
      
      private var UnknownVarFromGameArenaView_KeyboardControl_1:KeyboardControl;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromGameArenaView_SnowWarUI_1:SnowWarUI;
      
      private var UnknownVarFromGameArenaView_Boolean_1:Boolean;
      
      private var UnknownVarFromGameArenaView_Stage_1:Stage;
      
      private var UnknownVarFromGameArenaView_Boolean_2:Boolean;
      
      public function GameArenaView(param1:SnowWarEngine)
      {
         super();
         UnknownVarFromGameArenaView_SnowWarEngine_1 = param1;
         UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine.addObjectUpdateCategory(202);
      }
      
      public function dispose() : void
      {
         UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine.disposeRoom(1);
         UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine.removeObjectUpdateCategory(202);
         if(UnknownVarFromGameArenaView_KeyboardControl_1)
         {
            UnknownVarFromGameArenaView_KeyboardControl_1.dispose();
            UnknownVarFromGameArenaView_KeyboardControl_1 = null;
         }
         if(UnknownVarFromGameArenaView_Stage_1 != null)
         {
            UnknownVarFromGameArenaView_Stage_1.removeEventListener("mouseMove",onMouseMove);
            UnknownVarFromGameArenaView_Stage_1 = null;
         }
         UnknownVarFromGameArenaView_SnowWarEngine_1 = null;
         UnknownVarFromGameArenaView_Array_1 = null;
         UnknownVarFromGameArenaView_Array_2 = null;
         if(UnknownVarFromGameArenaView_SnowWarUI_1)
         {
            UnknownVarFromGameArenaView_SnowWarUI_1.dispose();
            UnknownVarFromGameArenaView_SnowWarUI_1 = null;
         }
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function init() : void
      {
         var _loc11_:int = 0;
         var _loc10_:int = 0;
         var _loc12_:Number = NaN;
         var _loc1_:Vector3d = null;
         var _loc5_:Vector3d = null;
         var _loc13_:int = 0;
         var _loc9_:IStuffData = null;
         var _loc14_:int = 0;
         var _loc6_:Number = NaN;
         UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine.isGameMode = true;
         var _loc7_:SnowWarGameStage = UnknownVarFromGameArenaView_SnowWarEngine_1.gameArena.getCurrentStage() as SnowWarGameStage;
         var _loc2_:GameLevelData = _loc7_.gameLevelData;
         var _loc8_:Array = _loc7_.getTiles();
         var _loc3_:RoomPlaneParser = new RoomPlaneParser();
         _loc3_.initializeTileMap(_loc2_.width,_loc2_.height);
         _loc11_ = 0;
         while(_loc11_ < _loc2_.height)
         {
            _loc10_ = 0;
            while(_loc10_ < _loc2_.width)
            {
               _loc3_.setTileHeight(_loc10_,_loc11_,_loc8_[_loc11_][_loc10_] == null ? -100 : 0);
               _loc10_++;
            }
            _loc11_++;
         }
         _loc3_.initializeFromTileData();
         UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine.initializeRoom(1,_loc3_.getXML());
         (UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine as IRoomEngine_4).updateObjectRoomVisibilities(1,false);
         _loc3_.dispose();
         for each(var _loc4_ in _loc7_.gameLevelData.fuseObjects)
         {
            _loc12_ = _loc4_.altitude / Tile.TILE_HALFWIDTH;
            _loc1_ = new Vector3d(_loc4_.x,_loc4_.y,_loc12_);
            _loc5_ = new Vector3d(_loc4_.direction * 45);
            _loc13_ = UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine.getFurnitureTypeId(_loc4_.name);
            _loc9_ = _loc4_.stuffData;
            _loc14_ = 0;
            _loc6_ = parseInt(_loc9_.getLegacyString());
            if(!isNaN(_loc6_))
            {
               _loc14_ = _loc6_;
            }
            UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine.addObjectFurniture(1,_loc4_.id,_loc13_,_loc1_,_loc5_,_loc14_,_loc9_);
         }
         UnknownVarFromGameArenaView_SnowWarEngine_1.roomUI.visible = false;
         UnknownVarFromGameArenaView_Stage_1 = UnknownVarFromGameArenaView_SnowWarEngine_1.context.displayObjectContainer.stage;
         UnknownVarFromGameArenaView_Stage_1.addEventListener("mouseMove",onMouseMove);
      }
      
      private function onMouseMove(param1:MouseEvent) : void
      {
         UnknownVarFromGameArenaView_Boolean_2 = param1.altKey || param1.shiftKey;
      }
      
      public function initGameUI(param1:int) : void
      {
         UnknownVarFromGameArenaView_SnowWarUI_1 = new SnowWarUI(UnknownVarFromGameArenaView_SnowWarEngine_1);
         UnknownVarFromGameArenaView_SnowWarUI_1.init();
         initCountDown();
      }
      
      public function removeGameUI() : void
      {
         if(UnknownVarFromGameArenaView_SnowWarUI_1)
         {
            UnknownVarFromGameArenaView_SnowWarUI_1.dispose();
            UnknownVarFromGameArenaView_SnowWarUI_1 = null;
         }
      }
      
      public function update(param1:uint, param2:Boolean = false) : void
      {
         var _loc11_:Direction8 = null;
         var _loc25_:HumanGameObject = null;
         var _loc16_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc9_:int = 0;
         var _loc18_:int = 0;
         var _loc5_:int = 0;
         var _loc17_:IRoomObject = null;
         var _loc22_:IVector3d = null;
         var _loc21_:int = 0;
         var _loc26_:* = undefined;
         var _loc7_:HumanGameObject = null;
         var _loc4_:* = false;
         var _loc19_:int = 0;
         var _loc24_:SnowBallGameObject = null;
         var _loc6_:SnowballMachineGameObject = null;
         var _loc8_:SnowballPileGameObject = null;
         var _loc20_:TreeGameObject = null;
         if(param2 && UnknownVarFromGameArenaView_KeyboardControl_1)
         {
            _loc11_ = UnknownVarFromGameArenaView_KeyboardControl_1.direction;
            if(_loc11_)
            {
               _loc25_ = UnknownVarFromGameArenaView_SnowWarEngine_1.gameArena.getCurrentStage().getGameObject(UnknownVarFromGameArenaView_SnowWarEngine_1.ownId) as HumanGameObject;
               _loc16_ = _loc25_.currentLocation.x / 3200;
               _loc13_ = _loc25_.currentLocation.y / 3200;
               _loc16_ += _loc11_.getUnitVectorXcomponent() * 2;
               _loc13_ += _loc11_.getUnitVectorYcomponent() * 2;
               UnknownVarFromGameArenaView_SnowWarEngine_1.moveOwnAvatarTo(_loc16_,_loc13_);
            }
         }
         var _loc23_:int = getTimer();
         for each(var _loc12_ in UnknownVarFromGameArenaView_SnowWarEngine_1.gameArena.getCurrentStage().resetRemovedGameObjects())
         {
            _loc9_ = int(_loc12_.gameObjectId);
            _loc18_ = int(UnknownVarFromGameArenaView_Array_1.indexOf(_loc9_));
            if(_loc18_ > -1)
            {
               UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine.disposeObjectUser(1,_loc9_);
               UnknownVarFromGameArenaView_Array_1.splice(_loc18_,1);
            }
            _loc5_ = int(UnknownVarFromGameArenaView_Array_2.indexOf(_loc9_));
            if(_loc5_ > -1)
            {
               _loc17_ = UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine.getRoomObject(1,_loc9_,201);
               _loc22_ = _loc17_.getLocation();
               UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine.disposeObjectSnowWar(1,_loc9_,201);
               UnknownVarFromGameArenaView_Array_2.splice(_loc5_,1);
               if(!ISynchronizedGameObject(_loc12_).isActive)
               {
                  UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine.addObjectSnowWar(1,_loc9_,_loc22_,202);
                  UnknownVarFromGameArenaView_Array_3.push({
                     "id":_loc9_,
                     "time":_loc23_,
                     "category":202
                  });
               }
            }
         }
         _loc21_ = UnknownVarFromGameArenaView_Array_3.length - 1;
         while(_loc21_ > -1)
         {
            _loc26_ = UnknownVarFromGameArenaView_Array_3[_loc21_];
            if(_loc23_ - _loc26_.time >= 500)
            {
               UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine.disposeObjectSnowWar(1,_loc26_.id,_loc26_.category);
               UnknownVarFromGameArenaView_Array_3.splice(_loc21_,1);
            }
            _loc21_--;
         }
         var _loc10_:Array = UnknownVarFromGameArenaView_SnowWarEngine_1.gameArena.getCurrentStage().getGameObjects();
         var _loc15_:Boolean = false;
         for each(var _loc3_ in _loc10_)
         {
            _loc7_ = _loc3_ as HumanGameObject;
            if(_loc7_)
            {
               _loc4_ = _loc7_.posture == "swrun";
               _loc15_ ||= _loc4_;
               updateHumanGameObject(_loc7_);
               if(_loc7_.gameObjectId == UnknownVarFromGameArenaView_SnowWarEngine_1.ownId)
               {
                  _loc19_ = (UnknownVarFromGameArenaView_SnowWarEngine_1.gameArena.getExtension() as SnowWarGameArena).getPulseInterval();
                  UnknownVarFromGameArenaView_SnowWarUI_1.timer = UnknownVarFromGameArenaView_SnowWarEngine_1.stageLength - UnknownVarFromGameArenaView_SnowWarEngine_1.currentSubTurn * _loc19_ / 1000;
                  UnknownVarFromGameArenaView_SnowWarUI_1.ownScore = _loc7_.score;
                  UnknownVarFromGameArenaView_SnowWarUI_1.snowballs = _loc7_.snowballs;
                  UnknownVarFromGameArenaView_SnowWarUI_1.hitPoints = _loc7_.hitPoints;
               }
            }
            _loc24_ = _loc3_ as SnowBallGameObject;
            if(_loc24_)
            {
               updateSnowballGameObject(_loc24_);
            }
            _loc6_ = _loc3_ as SnowballMachineGameObject;
            if(_loc6_)
            {
               updateSnowballMachineGameObject(_loc6_);
            }
            _loc8_ = _loc3_ as SnowballPileGameObject;
            if(_loc8_)
            {
               updateSnowballPileGameObject(_loc8_);
            }
            _loc20_ = _loc3_ as TreeGameObject;
            if(_loc20_)
            {
               updateTreeGameObject(_loc20_);
            }
         }
         if(UnknownVarFromGameArenaView_SnowWarUI_1)
         {
            UnknownVarFromGameArenaView_SnowWarUI_1.update(param1);
         }
         if(_loc15_ && !UnknownVarFromGameArenaView_Boolean_1)
         {
            UnknownVarFromGameArenaView_Boolean_1 = true;
            SnowWarEngine.playSound("HBSTG_snowwar_walk",2147483647);
         }
         else if(!_loc15_ && UnknownVarFromGameArenaView_Boolean_1)
         {
            UnknownVarFromGameArenaView_Boolean_1 = false;
            SnowWarEngine.stopSound("HBSTG_snowwar_walk");
         }
         var _loc14_:HumanGameObject = UnknownVarFromGameArenaView_SnowWarEngine_1.getCurrentPlayer();
         UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine.updateObjectUserEffect(1,_loc14_.gameObjectId,_loc14_.team == 1 ? 96 : 95);
      }
      
      private function updateHumanGameObject(param1:HumanGameObject) : void
      {
         var _loc3_:IAvatarFigureContainer = null;
         var _loc9_:Boolean = false;
         var _loc12_:IRoomObjectSpriteVisualization = null;
         var _loc6_:* = false;
         var _loc7_:Number = param1.currentLocation.x / 3200;
         var _loc4_:Number = param1.currentLocation.y / 3200;
         var _loc5_:int = param1.gameObjectId;
         var _loc10_:int = param1.getBodyDirection();
         var _loc8_:int = Direction360.direction8ToDirection360Value(Direction8.getDirection8(_loc10_));
         var _loc2_:IVector3d = new Vector3d(_loc8_,0,0);
         if(UnknownVarFromGameArenaView_Array_1.indexOf(_loc5_) == -1)
         {
            _loc3_ = UnknownVarFromGameArenaView_SnowWarEngine_1.avatarManager.createFigureContainer(param1.figure);
            switch(param1.team - 1)
            {
               case 0:
                  _loc3_.updatePart("ch",20000,[1]);
                  break;
               case 1:
                  _loc3_.updatePart("ch",20001,[1]);
                  break;
               default:
                  _loc3_.updatePart("ch",20000,[1]);
            }
            _loc3_.removePart("cc");
            UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine.addObjectUser(1,_loc5_,new Vector3d(_loc7_,_loc4_,0),_loc2_,_loc8_,1,_loc3_.getFigureString());
            UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine.updateObjectUserPosture(1,_loc5_,"std");
            UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine.updateObjectUserAction(1,_loc5_,"figure_is_playing_game",1);
            UnknownVarFromGameArenaView_Array_1.push(_loc5_);
            switch(param1.visualizationMode - 1)
            {
               case 0:
                  visualizeAsGhost(getRoomUserObject(_loc5_));
                  break;
               case 1:
                  hideVisualization(getRoomUserObject(_loc5_));
            }
         }
         else
         {
            UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine.updateObjectUser(1,_loc5_,new Vector3d(_loc7_,_loc4_,0),new Vector3d(_loc7_,_loc4_,0),false,0,_loc2_,_loc8_);
            UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine.updateObjectUserPosture(1,_loc5_,param1.posture);
            _loc9_ = param1.posture != "swdieback" && param1.posture != "swdiefront";
            UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine.updateObjectUserAction(1,_loc5_,"figure_is_playing_game",int(_loc9_));
         }
         var _loc11_:IRoomObject = getRoomUserObject(_loc5_);
         if(_loc11_ != null)
         {
            _loc12_ = _loc11_.getVisualization() as IRoomObjectSpriteVisualization;
            _loc12_.getSprite(0).alpha = param1.invincible ? 100 : 255;
            _loc6_ = param1.team != UnknownVarFromGameArenaView_SnowWarEngine_1.getCurrentPlayer().team;
            if(_loc6_)
            {
               if((UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine as IRoomEngine_2).playerUnderCursor == _loc5_ && !param1.invincible && !param1.isStunned())
               {
                  UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine.updateObjectUserEffect(1,_loc5_,98);
               }
               else
               {
                  UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine.updateObjectUserEffect(1,_loc5_,0);
               }
            }
         }
      }
      
      private function updateSnowballGameObject(param1:SnowBallGameObject) : void
      {
         var _loc5_:Number = param1.location3D.x / 3200;
         var _loc3_:Number = param1.location3D.y / 3200;
         var _loc4_:Number = param1.location3D.z / Tile.TILE_HALFWIDTH;
         var _loc2_:Vector3d = new Vector3d(_loc5_,_loc3_,_loc4_);
         var _loc6_:int = param1.gameObjectId;
         if(UnknownVarFromGameArenaView_Array_2.indexOf(_loc6_) == -1)
         {
            UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine.addObjectSnowWar(1,_loc6_,_loc2_,201);
            UnknownVarFromGameArenaView_Array_2.push(_loc6_);
         }
         else
         {
            UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine.updateObjectSnowWar(1,_loc6_,_loc2_,201);
         }
      }
      
      private function updateSnowballMachineGameObject(param1:SnowballMachineGameObject) : void
      {
         var _loc3_:RoomEngine = UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine as RoomEngine;
         var _loc2_:IRoomObjectController = _loc3_.getRoomObject(1,param1.fuseObjectId,10) as IRoomObjectController;
         if(_loc2_.getState(0) != param1.snowballCount)
         {
            _loc3_.updateObjectFurniture(1,param1.fuseObjectId,null,null,param1.snowballCount,null);
            _loc2_.setState(param1.snowballCount,0);
         }
      }
      
      private function updateSnowballPileGameObject(param1:SnowballPileGameObject) : void
      {
         var _loc3_:RoomEngine = UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine as RoomEngine;
         var _loc2_:IRoomObjectController = _loc3_.getRoomObject(1,param1.fuseObjectId,10) as IRoomObjectController;
         var _loc4_:int = param1.maxSnowballs - param1.snowballCount;
         if(_loc2_ && _loc2_.getState(0) != _loc4_)
         {
            _loc3_.updateObjectFurniture(1,param1.fuseObjectId,null,null,_loc4_,null);
            _loc2_.setState(_loc4_,0);
         }
      }
      
      private function updateTreeGameObject(param1:TreeGameObject) : void
      {
         var _loc3_:RoomEngine = UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine as RoomEngine;
         var _loc2_:IRoomObjectController = _loc3_.getRoomObject(1,param1.fuseObjectId,10) as IRoomObjectController;
         if(_loc2_ && _loc2_.getState(0) != param1.hits)
         {
            _loc3_.updateObjectFurniture(1,param1.fuseObjectId,null,null,param1.hits,null);
            _loc2_.setState(param1.hits,0);
         }
      }
      
      private function getRoomUserObject(param1:int) : IRoomObject
      {
         return UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine.getRoomObject(1,param1,100);
      }
      
      private function visualizeAsGhost(param1:IRoomObject) : void
      {
         var _loc2_:IRoomObjectSpriteVisualization = null;
         var _loc4_:int = 0;
         var _loc3_:IRoomObjectSprite = null;
         if(param1)
         {
            _loc2_ = param1.getVisualization() as IRoomObjectSpriteVisualization;
            _loc4_ = 0;
            while(_loc4_ < _loc2_.spriteCount)
            {
               _loc3_ = _loc2_.getSprite(_loc4_);
               _loc3_.blendMode = "hardlight";
               _loc4_++;
            }
         }
      }
      
      private function hideVisualization(param1:IRoomObject) : void
      {
         var _loc2_:IRoomObjectSpriteVisualization = null;
         var _loc4_:int = 0;
         var _loc3_:IRoomObjectSprite = null;
         if(param1)
         {
            _loc2_ = param1.getVisualization() as IRoomObjectSpriteVisualization;
            _loc4_ = 0;
            while(_loc4_ < _loc2_.spriteCount)
            {
               _loc3_ = _loc2_.getSprite(_loc4_);
               _loc3_.visible = false;
               _loc4_++;
            }
         }
      }
      
      public function showChecksumError(param1:uint) : void
      {
         UnknownVarFromGameArenaView_SnowWarUI_1.showChecksumError(param1);
      }
      
      private function initCountDown() : void
      {
         UnknownVarFromGameArenaView_SnowWarUI_1.initCounter();
         UnknownVarFromGameArenaView_SnowWarUI_1.update(1000);
      }
      
      public function updateTileCursor(param1:int) : void
      {
         var _loc2_:int = 0;
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = 3;
               break;
            case 1:
               _loc2_ = 2;
               break;
            case 2:
               _loc2_ = 4;
               break;
            case 3:
               _loc2_ = 5;
               break;
            default:
               _loc2_ = 0;
         }
         UnknownVarFromGameArenaView_SnowWarEngine_1.roomEngine.setTileCursorState(1,_loc2_);
      }
      
      public function stopWaitingForSnowball() : void
      {
         if(UnknownVarFromGameArenaView_SnowWarUI_1)
         {
            UnknownVarFromGameArenaView_SnowWarUI_1.stopWaitingForSnowball();
         }
      }
      
      public function startWaitingForSnowball() : void
      {
         if(UnknownVarFromGameArenaView_SnowWarUI_1)
         {
            UnknownVarFromGameArenaView_SnowWarUI_1.startWaitingForSnowball();
         }
      }
      
      public function flashOwnScore(param1:Boolean) : void
      {
         if(UnknownVarFromGameArenaView_SnowWarUI_1)
         {
            UnknownVarFromGameArenaView_SnowWarUI_1.flashOwnScore(param1);
         }
      }
   }
}

