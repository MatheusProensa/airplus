package com.sulake.habbo.game.snowwar.gameobjects
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.object.HumanGameObjectData;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.SnowWarGameArena;
   import com.sulake.habbo.game.snowwar.SnowWarGameStage;
   import com.sulake.habbo.game.snowwar.Tile;
   import com.sulake.habbo.game.snowwar.arena.SynchronizedGameArena;
   import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;
   import com.sulake.habbo.game.snowwar.utils.Direction360;
   import com.sulake.habbo.game.snowwar.utils.Direction8;
   import com.sulake.habbo.game.snowwar.utils.Location3D;
   import com.sulake.habbo.game.snowwar.utils.UnknownHabboGameSnowwarUtils1;
   
   public class HumanGameObject extends SnowWarGameObject
   {
      public static const UnknownConstFromHumanGameObject_Int_1:int = 534;
      
      public static const INITIAL_SNOWBALL_COUNT:int = 5;
      
      public static const MAXIMUM_SNOWBALL_COUNT:int = 5;
      
      public static const INITIAL_HIT_POINTS:int = 5;
      
      public static const SNOWBALL_CREATE_TIME:int = 20;
      
      public static const STUN_TIME:int = 100;
      
      public static const INVINCIBLE_AFTER_STUN_TIME:int = 60;
      
      public static const ACTIVITY_STATE_NORMAL:int = 0;
      
      public static const ACTIVITY_STATE_MAKING_SNOWBALL:int = 1;
      
      public static const ACTIVITY_STATE_STUNNED:int = 2;
      
      public static const ACTIVITY_STATE_INVINCIBLE_AFTER_STUN:int = 3;
      
      public static const SNOWBALL_THROW_INTERVAL:int = 5;
      
      public static const PLAYER_HEIGHT:int = 5000;
      
      private static const SCORE_ON_KNOCK_DOWN:int = 5;
      
      private static const SCORE_ON_HIT:int = 1;
      
      public static const BOUNDING_DATA:Array = [1600];
      
      private var UnknownVarFromHumanGameObject_Tile_1:Tile;
      
      private var UnknownVarFromHumanGameObject_Tile_2:Tile;
      
      private var UnknownVarFromHumanGameObject_Boolean_1:Boolean;
      
      private var _location3D:Location3D = new Location3D(0,0,0);
      
      private var UnknownVarFromHumanGameObject_Location3D_1:Location3D = new Location3D(0,0,0);
      
      private var UnknownVarFromHumanGameObject_Direction8_1:Direction8 = Direction8.SE;
      
      private var _hitPoints:int;
      
      private var _snowballs:int;
      
      protected var UnknownVarFromHumanGameObject_Int_1:int;
      
      private var UnknownVarFromHumanGameObject_Int_2:int;
      
      private var UnknownVarFromHumanGameObject_Int_3:int;
      
      private var _score:int;
      
      private var _team:int;
      
      private var UnknownVarFromHumanGameObject_Int_4:int;
      
      private var _name:String;
      
      private var _mission:String;
      
      private var _figure:String;
      
      private var _sex:String;
      
      private var UnknownVarFromHumanGameObject_Int_5:int;
      
      private var _visualizationMode:int = 0;
      
      private var UnknownVarFromHumanGameObject_SnowWarEngine_1:SnowWarEngine;
      
      private var UnknownVarFromHumanGameObject_Map_1:Map;
      
      public function HumanGameObject(param1:SnowWarGameStage, param2:HumanGameObjectData, param3:Boolean, param4:SnowWarEngine)
      {
         super(param2.id,param3);
         _sex = param2.sex;
         _name = param2.name;
         _mission = param2.mission;
         _figure = param2.figure;
         _team = param2.team;
         UnknownVarFromHumanGameObject_Int_5 = param2.userId;
         UnknownVarFromHumanGameObject_Int_3 = param2.activityState;
         UnknownVarFromHumanGameObject_Int_2 = param2.activityTimer;
         _location3D.change2DLocation(param2.currentLocationX,param2.currentLocationY);
         UnknownVarFromHumanGameObject_Direction8_1 = Direction8.getDirection8(param2.bodyDirection);
         _hitPoints = param2.hitPoints;
         UnknownVarFromHumanGameObject_Location3D_1.change2DLocation(param2.moveTargetX,param2.moveTargetY);
         _snowballs = param2.snowBallCount;
         _score = param2.score;
         UnknownVarFromHumanGameObject_Tile_1 = param1.getTileAt(param2.currentTileX,param2.currentTileY);
         UnknownVarFromHumanGameObject_Tile_1.addGameObject(this);
         var _loc5_:Tile = param1.getTileAt(param2.nextTileX,param2.nextTileY);
         if(_loc5_ != UnknownVarFromHumanGameObject_Tile_1)
         {
            UnknownVarFromHumanGameObject_Tile_2 = _loc5_;
            UnknownVarFromHumanGameObject_Tile_2.addGameObject(this);
            UnknownVarFromHumanGameObject_Tile_1.removeOccupyingHuman();
            UnknownVarFromHumanGameObject_Boolean_1 = true;
         }
         UnknownVarFromHumanGameObject_SnowWarEngine_1 = param4;
         UnknownVarFromHumanGameObject_Map_1 = new Map();
      }
      
      public function get visualizationMode() : int
      {
         return _visualizationMode;
      }
      
      public function set visualizationMode(param1:int) : void
      {
         _visualizationMode = param1;
      }
      
      public function get invincible() : Boolean
      {
         return UnknownVarFromHumanGameObject_Int_3 == 3;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _sex = "";
         _name = "";
         _mission = "";
         _figure = "";
         _team = 0;
         UnknownVarFromHumanGameObject_Int_5 = 0;
         _location3D = null;
         UnknownVarFromHumanGameObject_Direction8_1 = null;
         UnknownVarFromHumanGameObject_Location3D_1 = null;
         _snowballs = 0;
         _score = 0;
         UnknownVarFromHumanGameObject_Boolean_1 = false;
         UnknownVarFromHumanGameObject_SnowWarEngine_1 = null;
         UnknownVarFromHumanGameObject_Map_1 = null;
      }
      
      override public function get numberOfVariables() : int
      {
         return 19;
      }
      
      override public function getVariable(param1:int) : int
      {
         switch(param1)
         {
            case 0:
               return 5;
            case 1:
               return _gameObjectId;
            case 2:
               return _location3D.x;
            case 3:
               return _location3D.y;
            case 4:
               return UnknownVarFromHumanGameObject_Tile_1.fuseLocation[0];
            case 5:
               return UnknownVarFromHumanGameObject_Tile_1.fuseLocation[1];
            case 6:
               return UnknownVarFromHumanGameObject_Direction8_1.intValue();
            case 7:
               return _hitPoints;
            case 8:
               return _snowballs;
            case 9:
               return UnknownVarFromHumanGameObject_Int_1;
            case 10:
               return UnknownVarFromHumanGameObject_Int_2;
            case 11:
               return UnknownVarFromHumanGameObject_Int_3;
            case 12:
               return UnknownVarFromHumanGameObject_Tile_2 != null ? UnknownVarFromHumanGameObject_Tile_2.fuseLocation[0] : UnknownVarFromHumanGameObject_Tile_1.fuseLocation[0];
            case 13:
               return UnknownVarFromHumanGameObject_Tile_2 != null ? UnknownVarFromHumanGameObject_Tile_2.fuseLocation[1] : UnknownVarFromHumanGameObject_Tile_1.fuseLocation[1];
            case 14:
               return UnknownVarFromHumanGameObject_Location3D_1.x;
            case 15:
               return UnknownVarFromHumanGameObject_Location3D_1.y;
            case 16:
               return _score;
            case 17:
               return _team;
            case 18:
               return UnknownVarFromHumanGameObject_Int_5;
            default:
               throw new Exception("No such variable:" + param1);
         }
      }
      
      public function reinitGhost(param1:HumanGameObject) : void
      {
         _location3D.change2DLocation(param1._location3D.x,param1._location3D.y);
         UnknownVarFromHumanGameObject_Tile_1 = param1.UnknownVarFromHumanGameObject_Tile_1;
         UnknownVarFromHumanGameObject_Direction8_1 = param1.UnknownVarFromHumanGameObject_Direction8_1;
         _hitPoints = param1._hitPoints;
         _snowballs = param1._snowballs;
         UnknownVarFromHumanGameObject_Int_1 = param1.UnknownVarFromHumanGameObject_Int_1;
         UnknownVarFromHumanGameObject_Int_2 = param1.UnknownVarFromHumanGameObject_Int_2;
         UnknownVarFromHumanGameObject_Int_3 = param1.UnknownVarFromHumanGameObject_Int_3;
         UnknownVarFromHumanGameObject_Tile_2 = param1.UnknownVarFromHumanGameObject_Tile_2;
         UnknownVarFromHumanGameObject_Location3D_1.change2DLocation(param1.UnknownVarFromHumanGameObject_Location3D_1.x,param1.UnknownVarFromHumanGameObject_Location3D_1.y);
         _score = param1._score;
         _team = param1._team;
         UnknownVarFromHumanGameObject_Int_5 = param1.UnknownVarFromHumanGameObject_Int_5;
      }
      
      public function isInGhostDistance(param1:int, param2:Location3D) : Boolean
      {
         var _loc3_:Location3D = UnknownVarFromHumanGameObject_Map_1[param1];
         if(_loc3_)
         {
            return _loc3_.isInDistance(param2,Tile.TILE_ONEANDHALFWIDTH);
         }
         return false;
      }
      
      public function addGhostLocation(param1:int) : void
      {
         var _loc2_:Location3D = new Location3D(0,0,0);
         _loc2_.change2DLocation(_location3D.x,_location3D.y);
         UnknownVarFromHumanGameObject_Map_1[param1] = _loc2_;
      }
      
      public function removeGhostLocation(param1:int) : void
      {
         UnknownVarFromHumanGameObject_Map_1.remove(param1);
      }
      
      public function setBodyDirection(param1:Direction8) : void
      {
         UnknownVarFromHumanGameObject_Direction8_1 = param1;
      }
      
      override public function get boundingType() : int
      {
         return 2;
      }
      
      override public function get boundingData() : Array
      {
         return BOUNDING_DATA;
      }
      
      override public function get location3D() : Location3D
      {
         return _location3D;
      }
      
      override public function get direction360() : Direction360
      {
         return null;
      }
      
      override public function onRemove() : void
      {
         if(UnknownVarFromHumanGameObject_Tile_1 && UnknownVarFromHumanGameObject_Tile_1.occupyingHuman == this)
         {
            UnknownVarFromHumanGameObject_Tile_1.removeOccupyingHuman();
         }
         if(UnknownVarFromHumanGameObject_Tile_2 && UnknownVarFromHumanGameObject_Tile_2.occupyingHuman == this)
         {
            UnknownVarFromHumanGameObject_Tile_2.removeOccupyingHuman();
         }
         UnknownVarFromHumanGameObject_Boolean_1 = false;
      }
      
      public function activityTimerTriggered() : void
      {
         if(UnknownVarFromHumanGameObject_Int_3 == 2)
         {
            _hitPoints = 5;
            UnknownVarFromHumanGameObject_Int_3 = 3;
            UnknownVarFromHumanGameObject_Int_2 = 60;
            return;
         }
         if(UnknownVarFromHumanGameObject_Int_3 == 1)
         {
            _snowballs++;
         }
         UnknownVarFromHumanGameObject_Int_3 = 0;
         UnknownVarFromHumanGameObject_SnowWarEngine_1.stopWaitingForSnowball(gameObjectId);
      }
      
      override public function subturn(param1:SynchronizedGameStage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Direction8 = null;
         var _loc4_:SnowWarGameStage = param1 as SnowWarGameStage;
         if(UnknownVarFromHumanGameObject_Int_2 > 0)
         {
            if(UnknownVarFromHumanGameObject_Int_2 == 1)
            {
               activityTimerTriggered();
            }
            UnknownVarFromHumanGameObject_Int_2--;
         }
         if(UnknownVarFromHumanGameObject_Int_4 > 0)
         {
            UnknownVarFromHumanGameObject_Int_4--;
         }
         if(HabboGamesCom.logEnabled)
         {
            HabboGamesCom.log(gameObjectId + " currentTile:" + UnknownVarFromHumanGameObject_Tile_1 + " nextTile:" + UnknownVarFromHumanGameObject_Tile_2);
         }
         if(canMove() && UnknownVarFromHumanGameObject_Tile_1 != null)
         {
            if(UnknownVarFromHumanGameObject_Tile_2 != null)
            {
               if(HabboGamesCom.logEnabled)
               {
                  HabboGamesCom.log(gameObjectId + " Moving towards next tile:" + UnknownVarFromHumanGameObject_Tile_2 + " _currentLocation:" + _location3D);
               }
               moveTowardsNextTile();
            }
            else if(!UnknownVarFromHumanGameObject_Tile_1.locationIsInTileRange(UnknownVarFromHumanGameObject_Location3D_1))
            {
               _loc2_ = Direction360.getAngleFromComponents(UnknownVarFromHumanGameObject_Location3D_1.x - UnknownVarFromHumanGameObject_Tile_1.location.x,UnknownVarFromHumanGameObject_Location3D_1.y - UnknownVarFromHumanGameObject_Tile_1.location.y);
               _loc3_ = Direction360.direction360ValueToDirection8(_loc2_);
               UnknownVarFromHumanGameObject_Tile_2 = UnknownVarFromHumanGameObject_Tile_1.getTileInDirection(_loc3_);
               if(UnknownVarFromHumanGameObject_Tile_2 == null || !UnknownVarFromHumanGameObject_Tile_2.canMoveTo(this))
               {
                  if(UnknownVarFromHumanGameObject_Tile_2 != null && !UnknownVarFromHumanGameObject_Tile_2.canMoveTo(this))
                  {
                     if(UnknownVarFromHumanGameObject_Location3D_1.equals(UnknownVarFromHumanGameObject_Tile_2.location))
                     {
                        UnknownVarFromHumanGameObject_Tile_2 = null;
                        stopMovement();
                        return;
                     }
                  }
                  _loc3_ = _loc3_.rotateDirection(-1);
                  UnknownVarFromHumanGameObject_Tile_2 = UnknownVarFromHumanGameObject_Tile_1.getTileInDirection(_loc3_);
                  if(UnknownVarFromHumanGameObject_Tile_2 == null || !UnknownVarFromHumanGameObject_Tile_2.canMoveTo(this))
                  {
                     _loc3_ = _loc3_.rotateDirection(2);
                     UnknownVarFromHumanGameObject_Tile_2 = UnknownVarFromHumanGameObject_Tile_1.getTileInDirection(_loc3_);
                     if(UnknownVarFromHumanGameObject_Tile_2 != null && !UnknownVarFromHumanGameObject_Tile_2.canMoveTo(this))
                     {
                        UnknownVarFromHumanGameObject_Tile_2 = null;
                     }
                  }
               }
               if(UnknownVarFromHumanGameObject_Tile_2 != null)
               {
                  if(!isGhost)
                  {
                     UnknownVarFromHumanGameObject_Tile_1.removeOccupyingHuman();
                     UnknownVarFromHumanGameObject_Tile_2.addGameObject(this);
                  }
                  setBodyDirection(_loc3_);
                  moveTowardsNextTile();
               }
               else
               {
                  UnknownVarFromHumanGameObject_Boolean_1 = false;
               }
               if(HabboGamesCom.logEnabled)
               {
                  HabboGamesCom.log(gameObjectId + " Starting to move to next tile in direction360:" + _loc2_ + ", nextTile is now " + UnknownVarFromHumanGameObject_Tile_2 + "_currentLocationn:" + _location3D + ", moveTarget:" + UnknownVarFromHumanGameObject_Location3D_1);
               }
            }
            else
            {
               UnknownVarFromHumanGameObject_Boolean_1 = false;
            }
         }
         else
         {
            UnknownVarFromHumanGameObject_Boolean_1 = false;
         }
      }
      
      private function moveTowardsNextTile() : void
      {
         if(HabboGamesCom.logEnabled)
         {
            HabboGamesCom.log(gameObjectId + " [MoveTowardsNextTile], currentX: " + _location3D.x + " currentY: " + _location3D.y);
         }
         var _loc5_:int = UnknownVarFromHumanGameObject_Tile_2.location.x;
         var _loc1_:* = _location3D.x;
         var _loc2_:int = _loc1_ - _loc5_;
         if(_loc2_ != 0)
         {
            if(_loc2_ < 0)
            {
               if(_loc2_ > -534)
               {
                  _loc1_ = _loc5_;
               }
               else
               {
                  _loc1_ += 534;
               }
            }
            else if(_loc2_ < 534)
            {
               _loc1_ = _loc5_;
            }
            else
            {
               _loc1_ -= 534;
            }
         }
         var _loc3_:int = UnknownVarFromHumanGameObject_Tile_2.location.y;
         var _loc6_:* = _location3D.y;
         var _loc4_:int = _loc6_ - _loc3_;
         if(_loc4_ != 0)
         {
            if(_loc4_ < 0)
            {
               if(_loc4_ > -534)
               {
                  _loc6_ = _loc3_;
               }
               else
               {
                  _loc6_ += 534;
               }
            }
            else if(_loc4_ < 534)
            {
               _loc6_ = _loc3_;
            }
            else
            {
               _loc6_ -= 534;
            }
         }
         if(HabboGamesCom.logEnabled)
         {
            HabboGamesCom.log(gameObjectId + " [MoveTowardsNextTile], nextX: " + _loc1_ + " nextY: " + _loc6_);
         }
         _location3D.change2DLocation(_loc1_,_loc6_);
         if(_location3D.distanceTo(UnknownVarFromHumanGameObject_Tile_2.location) < UnknownHabboGameSnowwarUtils1.javaDiv(534 / 2))
         {
            UnknownVarFromHumanGameObject_Tile_1 = UnknownVarFromHumanGameObject_Tile_2;
            UnknownVarFromHumanGameObject_Tile_2 = null;
         }
         UnknownVarFromHumanGameObject_Boolean_1 = true;
      }
      
      public function changeMoveTarget(param1:int, param2:int) : void
      {
         if(UnknownVarFromHumanGameObject_Int_3 == 1)
         {
            UnknownVarFromHumanGameObject_Int_3 = 0;
            UnknownVarFromHumanGameObject_Int_2 = 0;
            UnknownVarFromHumanGameObject_SnowWarEngine_1.stopWaitingForSnowball(gameObjectId);
         }
         if(UnknownVarFromHumanGameObject_Int_3 == 0 || UnknownVarFromHumanGameObject_Int_3 == 3)
         {
            UnknownVarFromHumanGameObject_Location3D_1.change2DLocation(param1,param2);
         }
      }
      
      public function get currentLocation() : Location3D
      {
         return _location3D;
      }
      
      public function playerIsHitBySnowball(param1:SnowWarGameStage, param2:HumanGameObject, param3:int) : void
      {
         if(_isGhost)
         {
            return;
         }
         if(_team == param2.team)
         {
            return;
         }
         if(_hitPoints > 0)
         {
            if(_hitPoints == 1)
            {
               playerFallsDown(param3);
               param2.onKnockDownHuman(param1,this);
               SnowWarEngine.playSound("HBSTG_snowwar_hit3");
            }
            _hitPoints--;
            UnknownVarFromHumanGameObject_SnowWarEngine_1.registerHit(this,param2);
         }
      }
      
      public function onHitHuman(param1:SnowWarGameStage, param2:HumanGameObject) : void
      {
         if(!param2.isGhost && (team != param2.team || Boolean(SnowWarGameArena(param1.gameArena.getExtension()).isDeathMatch())))
         {
            addScore(param1.gameArena,1);
         }
      }
      
      public function onKnockDownHuman(param1:SnowWarGameStage, param2:HumanGameObject) : void
      {
         if(!param2.isGhost && (team != param2.team || Boolean(SnowWarGameArena(param1.gameArena.getExtension()).isDeathMatch())))
         {
            addScore(param1.gameArena,5);
         }
      }
      
      public function addScore(param1:SynchronizedGameArena, param2:int) : void
      {
         _score += param2;
         param1.addTeamScore(team,param2);
      }
      
      public function playerFallsDown(param1:int) : void
      {
         UnknownVarFromHumanGameObject_Int_3 = 2;
         UnknownVarFromHumanGameObject_Int_2 = 100;
         setBodyDirection(Direction360.direction360ValueToDirection8(param1).oppositeDirection());
         stopMovement();
         UnknownVarFromHumanGameObject_SnowWarEngine_1.stopWaitingForSnowball(gameObjectId);
      }
      
      public function stopMovement() : void
      {
         if(UnknownVarFromHumanGameObject_Tile_2 == null)
         {
            UnknownVarFromHumanGameObject_Location3D_1.changeLocationToLocation(UnknownVarFromHumanGameObject_Tile_1.location);
            _location3D.changeLocationToLocation(UnknownVarFromHumanGameObject_Tile_1.location);
         }
         else
         {
            UnknownVarFromHumanGameObject_Tile_1 = UnknownVarFromHumanGameObject_Tile_2;
            _location3D.changeLocationToLocation(UnknownVarFromHumanGameObject_Tile_2.location);
            UnknownVarFromHumanGameObject_Location3D_1.changeLocationToLocation(UnknownVarFromHumanGameObject_Tile_2.location);
            UnknownVarFromHumanGameObject_Tile_2 = null;
         }
         UnknownVarFromHumanGameObject_Boolean_1 = false;
         if(HabboGamesCom.logEnabled)
         {
            HabboGamesCom.log("Stopped. dir:" + UnknownVarFromHumanGameObject_Direction8_1 + "_currentTilee:" + UnknownVarFromHumanGameObject_Tile_1 + "_nextTilee:" + UnknownVarFromHumanGameObject_Tile_2 + "_currentLocationn:" + _location3D + "_moveTargett:" + UnknownVarFromHumanGameObject_Location3D_1);
         }
      }
      
      public function getBodyDirection() : int
      {
         return UnknownVarFromHumanGameObject_Direction8_1.intValue();
      }
      
      public function canThrowSnowballs() : Boolean
      {
         return _snowballs > 0 && UnknownVarFromHumanGameObject_Int_4 < 1 && (UnknownVarFromHumanGameObject_Int_3 == 0 || UnknownVarFromHumanGameObject_Int_3 == 3);
      }
      
      public function startThrowTimer() : void
      {
         UnknownVarFromHumanGameObject_Int_4 = 5;
      }
      
      public function throwSnowball(param1:int, param2:int) : Boolean
      {
         if(_snowballs < 1)
         {
            return false;
         }
         stopMovement();
         var _loc4_:int = Direction360.getAngleFromComponents(param1 - _location3D.x,param2 - _location3D.y);
         var _loc3_:int = Direction360.direction360ValueToDirection8(_loc4_).intValue();
         setBodyDirection(Direction8.getDirection8(_loc3_));
         if(HabboGamesCom.logEnabled)
         {
            HabboGamesCom.log("Turning to:" + _loc3_ + " 360 value:" + _loc4_ + " target:" + param1 + "," + param2 + " location:" + _location3D.x + "," + _location3D.y);
         }
         _snowballs--;
         return true;
      }
      
      public function canMove() : Boolean
      {
         return UnknownVarFromHumanGameObject_Int_3 == 0 || UnknownVarFromHumanGameObject_Int_3 == 3;
      }
      
      public function canMakeSnowballs() : Boolean
      {
         return (UnknownVarFromHumanGameObject_Int_3 == 0 || UnknownVarFromHumanGameObject_Int_3 == 3) && (_snowballs < 5 || isGhost);
      }
      
      public function startMakingSnowball() : void
      {
         if(canMakeSnowballs())
         {
            UnknownVarFromHumanGameObject_Int_3 = 1;
            UnknownVarFromHumanGameObject_Int_2 = 20;
            stopMovement();
         }
      }
      
      public function getRemainingSnowballCapacity() : int
      {
         return 5 - _snowballs;
      }
      
      public function addSnowballs(param1:int) : void
      {
         _snowballs += param1;
      }
      
      public function isStunned() : Boolean
      {
         return UnknownVarFromHumanGameObject_Int_3 == 2;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get mission() : String
      {
         return _mission;
      }
      
      public function get figure() : String
      {
         return _figure;
      }
      
      public function get sex() : String
      {
         return _sex;
      }
      
      public function get score() : int
      {
         return _score;
      }
      
      public function get team() : int
      {
         return _team;
      }
      
      public function get snowballs() : int
      {
         return _snowballs;
      }
      
      public function get hitPoints() : int
      {
         return _hitPoints;
      }
      
      public function get posture() : String
      {
         if(UnknownVarFromHumanGameObject_Int_4 > 0)
         {
            return "swthrow";
         }
         switch(UnknownVarFromHumanGameObject_Int_3 - 1)
         {
            case 0:
               return "swpick";
            case 1:
               return "swdieback";
            default:
               if(UnknownVarFromHumanGameObject_Boolean_1)
               {
                  return "swrun";
               }
               return "std";
         }
      }
      
      public function get action() : String
      {
         switch(UnknownVarFromHumanGameObject_Int_3 - 3)
         {
            case 0:
               return "figure_dance";
            default:
               return "figure_dance";
         }
      }
      
      public function get parameter() : int
      {
         if(UnknownVarFromHumanGameObject_Int_4 > 1)
         {
            return 1;
         }
         if(UnknownVarFromHumanGameObject_Int_4 == 1)
         {
            return 0;
         }
         switch(UnknownVarFromHumanGameObject_Int_3 - 3)
         {
            case 0:
               return 1;
            default:
               return 0;
         }
      }
      
      override public function testSnowBallCollision(param1:SnowBallGameObject) : Boolean
      {
         if(!_isGhost && UnknownVarFromHumanGameObject_Int_3 != 2 && UnknownVarFromHumanGameObject_Int_3 != 3 && param1.throwingHuman != this && super.testSnowBallCollision(param1))
         {
            return true;
         }
         return false;
      }
      
      override public function onSnowBallHit(param1:SnowWarGameStage, param2:SnowBallGameObject) : void
      {
         var _loc3_:HumanGameObject = param2.throwingHuman;
         playerIsHitBySnowball(param1,_loc3_,param2.direction360.intValue());
         _loc3_.onHitHuman(param1,this);
         SnowWarEngine.playSound("HBSTG_snowwar_hit1");
      }
      
      override public function get collisionHeight() : int
      {
         return 5000;
      }
      
      public function toString() : String
      {
         return " ref:" + _gameObjectId + "_name:" + _name;
      }
   }
}

