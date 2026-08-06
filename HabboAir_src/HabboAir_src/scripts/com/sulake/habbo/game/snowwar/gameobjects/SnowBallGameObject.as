package com.sulake.habbo.game.snowwar.gameobjects
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.object.SnowballGameObjectData;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.SnowWarGameStage;
   import com.sulake.habbo.game.snowwar.Tile;
   import com.sulake.habbo.game.snowwar.arena.SynchronizedGameStage;
   import com.sulake.habbo.game.snowwar.utils.Direction360;
   import com.sulake.habbo.game.snowwar.utils.Direction8;
   import com.sulake.habbo.game.snowwar.utils.Location3D;
   import com.sulake.habbo.game.snowwar.utils.SquareRoot;
   import com.sulake.habbo.game.snowwar.utils.UnknownHabboGameSnowwarUtils1;
   
   public class SnowBallGameObject extends SnowWarGameObject
   {
      public static const TRAJECTORY_QUICK_THROW:int = 0;
      
      public static const TRAJECTORY_SHORT_LOB:int = 1;
      
      public static const TRAJECTORY_LONG_LOB:int = 2;
      
      public static const TRAJECTORY_DEFAULT_THROW:int = 3;
      
      public static const THROW_VELOCITY:int = 2000;
      
      public static const INITIAL_HEIGHT:int = 3000;
      
      public static const UnknownConstFromSnowBallGameObject_Number_1:Number = 0.0007072135785007072;
      
      public static const SHORT_LOB_TIME_TO_TARGET_COEF:Number = 0.000559;
      
      public static const QUICK_THROW_MAX_RANGE:int = 20000;
      
      public static const SHORT_LOB_MAX_RANGE:int = 60000;
      
      public static const LONG_LOB_MAX_RANGE:int = 100000;
      
      public static const DEFAULT_THROW_TO_LOB_CUTOFF_RANGE:int = 42000;
      
      public static const UnknownConstFromSnowBallGameObject_Int_1:int = 10;
      
      public static const SHORT_LOB_HEIGHT_SCALING_FACTOR:int = 25;
      
      public static const UnknownConstFromSnowBallGameObject_Int_2:int = 50;
      
      public static const UnknownConstFromSnowBallGameObject_Int_3:int = 3;
      
      public static const GRAVITY:int = 15;
      
      public static var BOUNDING_DATA:Array = [400];
      
      private var _location3D:Location3D = new Location3D(0,0,0);
      
      private var _movementDirection360:Direction360 = new Direction360(0);
      
      private var UnknownVarFromSnowBallGameObject_Int_1:int;
      
      private var UnknownVarFromSnowBallGameObject_Int_2:int;
      
      private var UnknownVarFromSnowBallGameObject_Int_3:int;
      
      private var _throwingHuman:HumanGameObject;
      
      private var UnknownVarFromSnowBallGameObject_Int_4:int;
      
      public function SnowBallGameObject(param1:int)
      {
         super(param1,false);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _location3D.dispose();
         _location3D = null;
         _movementDirection360.dispose();
         _movementDirection360 = null;
         UnknownVarFromSnowBallGameObject_Int_1 = 0;
         UnknownVarFromSnowBallGameObject_Int_2 = 0;
         UnknownVarFromSnowBallGameObject_Int_3 = 0;
         _throwingHuman = null;
         UnknownVarFromSnowBallGameObject_Int_4 = 0;
      }
      
      public function initializeFromData(param1:SnowballGameObjectData, param2:HumanGameObject) : void
      {
         _location3D.changeLocation(param1.locationX3D,param1.locationY3D,param1.locationZ3D);
         _movementDirection360.setIntValue(param1.movementDirection360);
         UnknownVarFromSnowBallGameObject_Int_1 = param1.trajectory;
         UnknownVarFromSnowBallGameObject_Int_2 = param1.planarVelocity;
         UnknownVarFromSnowBallGameObject_Int_3 = param1.timeToLive;
         _throwingHuman = param2;
         UnknownVarFromSnowBallGameObject_Int_4 = param1.parabolaOffset;
         _active = true;
      }
      
      public function initialize(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:HumanGameObject) : void
      {
         var _loc10_:int = 0;
         _active = true;
         _location3D.changeLocation(param1,param2,param3);
         UnknownVarFromSnowBallGameObject_Int_1 = param4;
         var _loc8_:int = param5 - param1;
         var _loc9_:int = param6 - param2;
         _loc8_ = UnknownHabboGameSnowwarUtils1.javaDiv(_loc8_ / 200);
         _loc9_ = UnknownHabboGameSnowwarUtils1.javaDiv(_loc9_ / 200);
         _movementDirection360.setIntValue(Direction360.getAngleFromComponents(_loc8_,_loc9_));
         _loc10_ = SquareRoot.fast_sqrt(_loc8_ * _loc8_ + _loc9_ * _loc9_) * 200;
         initializeTrajectory(param4,_loc10_);
         if(UnknownVarFromSnowBallGameObject_Int_1 == 0)
         {
            UnknownVarFromSnowBallGameObject_Int_3 = 20000 / 2000;
            UnknownVarFromSnowBallGameObject_Int_2 = 2000;
         }
         else if(UnknownVarFromSnowBallGameObject_Int_1 == 1)
         {
            _loc10_ = Math.min(_loc10_,60000);
            UnknownVarFromSnowBallGameObject_Int_3 = _loc10_ * 0.000559;
            UnknownVarFromSnowBallGameObject_Int_2 = UnknownVarFromSnowBallGameObject_Int_3 == 0 ? 0 : UnknownHabboGameSnowwarUtils1.javaDiv(_loc10_ / UnknownVarFromSnowBallGameObject_Int_3);
         }
         else if(UnknownVarFromSnowBallGameObject_Int_1 == 2)
         {
            _loc10_ = Math.min(_loc10_,100000);
            UnknownVarFromSnowBallGameObject_Int_3 = _loc10_ * 0.0007072135785007072;
            UnknownVarFromSnowBallGameObject_Int_2 = UnknownVarFromSnowBallGameObject_Int_3 == 0 ? 0 : UnknownHabboGameSnowwarUtils1.javaDiv(_loc10_ / UnknownVarFromSnowBallGameObject_Int_3);
         }
         UnknownVarFromSnowBallGameObject_Int_4 = UnknownHabboGameSnowwarUtils1.javaDiv(UnknownVarFromSnowBallGameObject_Int_3 / 2);
         _throwingHuman = param7;
         if(HabboGamesCom.logEnabled)
         {
            HabboGamesCom.log("Snowball created, id=" + _gameObjectId + " ttl:" + UnknownVarFromSnowBallGameObject_Int_3 + " deltaX:" + _loc8_ + " deltaY:" + _loc9_ + " deltaX/200:" + UnknownHabboGameSnowwarUtils1.javaDiv(_loc8_ / 200) + " deltaY/200:" + UnknownHabboGameSnowwarUtils1.javaDiv(_loc9_ / 200) + " deltax^2+deltay^2:" + (_loc8_ * _loc8_ + _loc9_ * _loc9_) + " sqrt(deltax^2+deltay^2):" + SquareRoot.fast_sqrt(_loc8_ * _loc8_ + _loc9_ * _loc9_) + " sqrt(deltax^2+deltay^2)*200:" + SquareRoot.fast_sqrt(_loc8_ * _loc8_ + _loc9_ * _loc9_) * 200);
         }
      }
      
      private function initializeTrajectory(param1:int, param2:int) : void
      {
         if(param1 == 3)
         {
            if(param2 <= 42000)
            {
               UnknownVarFromSnowBallGameObject_Int_1 = 0;
            }
            else if(param2 <= 60000)
            {
               UnknownVarFromSnowBallGameObject_Int_1 = 1;
            }
            else
            {
               UnknownVarFromSnowBallGameObject_Int_1 = 2;
            }
         }
         else
         {
            UnknownVarFromSnowBallGameObject_Int_1 = param1;
         }
      }
      
      override public function get numberOfVariables() : int
      {
         return 11;
      }
      
      override public function getVariable(param1:int) : int
      {
         switch(param1)
         {
            case 0:
               return 1;
            case 1:
               return _gameObjectId;
            case 2:
               return _location3D.x;
            case 3:
               return _location3D.y;
            case 4:
               return _location3D.z;
            case 5:
               return _movementDirection360.intValue();
            case 6:
               return UnknownVarFromSnowBallGameObject_Int_1;
            case 7:
               return UnknownVarFromSnowBallGameObject_Int_3;
            case 8:
               return _throwingHuman?.gameObjectId;
            case 9:
               return UnknownVarFromSnowBallGameObject_Int_4;
            case 10:
               return UnknownVarFromSnowBallGameObject_Int_2;
            default:
               throw new Exception("No such variable:" + param1);
         }
      }
      
      override public function get direction360() : Direction360
      {
         return _movementDirection360;
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
      
      override public function subturn(param1:SynchronizedGameStage) : void
      {
         var _loc3_:SnowWarGameStage = param1 as SnowWarGameStage;
         if(!_active)
         {
            return;
         }
         UnknownVarFromSnowBallGameObject_Int_3--;
         if(UnknownVarFromSnowBallGameObject_Int_1 == 0)
         {
            updatePosition(10,true);
         }
         else if(UnknownVarFromSnowBallGameObject_Int_1 == 1)
         {
            updatePosition(25,false);
         }
         else
         {
            updatePosition(50,false);
         }
         var _loc5_:int = Tile.convertToTileX(_location3D.x);
         var _loc6_:int = Tile.convertToTileY(_location3D.y);
         var _loc4_:Tile = _loc3_.getTileAt(_loc5_,_loc6_);
         var _loc2_:Boolean = testCollisions(_loc3_,_loc4_);
         if(!_loc2_)
         {
            _loc2_ = _loc3_.testCollisionWithGround(this);
            if(_loc2_)
            {
               SnowWarEngine.playSound("HBSTG_snowwar_miss");
            }
         }
         if(_loc2_)
         {
            _loc3_.putGameObjectOnDeleteList(this);
         }
         if(HabboGamesCom.logEnabled)
         {
            HabboGamesCom.log("Snowball " + _gameObjectId + " tileX:" + _loc5_ + " tileY:" + _loc6_ + " collision:" + _loc2_);
         }
      }
      
      private function testCollisions(param1:SnowWarGameStage, param2:Tile) : Boolean
      {
         var _loc4_:Direction8 = null;
         var _loc3_:Boolean = false;
         if(param2)
         {
            _loc3_ = testCollision(param1,param2);
            if(!_loc3_)
            {
               _loc4_ = _movementDirection360.direction8Value();
               _loc3_ = testCollision(param1,param2.getTileInDirection(_loc4_));
               if(!_loc3_)
               {
                  _loc3_ = testCollision(param1,param2.getTileInDirection(_loc4_.rotateDirection45Degrees(false)));
                  if(!_loc3_)
                  {
                     _loc3_ = testCollision(param1,param2.getTileInDirection(_loc4_.rotateDirection45Degrees(true)));
                  }
               }
            }
         }
         return _loc3_;
      }
      
      private function testCollision(param1:SnowWarGameStage, param2:Tile) : Boolean
      {
         var _loc3_:SnowWarGameObject = null;
         if(param2)
         {
            _loc3_ = param2.gameObject;
            if(_loc3_)
            {
               if(HabboGamesCom.logEnabled)
               {
                  HabboGamesCom.log("Snowball " + _gameObjectId + " testing collision with " + _loc3_.gameObjectId);
               }
               if(_loc3_.testSnowBallCollision(this))
               {
                  _loc3_.onSnowBallHit(param1,this);
                  return true;
               }
            }
         }
         return false;
      }
      
      private function updatePosition(param1:int, param2:Boolean) : void
      {
         var _loc6_:int = _location3D.x + UnknownHabboGameSnowwarUtils1.javaDiv(_movementDirection360.getBaseVectorXComponent() * UnknownVarFromSnowBallGameObject_Int_2 / 255);
         var _loc5_:int = _location3D.y + UnknownHabboGameSnowwarUtils1.javaDiv(_movementDirection360.getBaseVectorYComponent() * UnknownVarFromSnowBallGameObject_Int_2 / 255);
         var _loc3_:int = UnknownVarFromSnowBallGameObject_Int_3 - UnknownVarFromSnowBallGameObject_Int_4;
         var _loc4_:int = (UnknownVarFromSnowBallGameObject_Int_4 * UnknownVarFromSnowBallGameObject_Int_4 - _loc3_ * _loc3_) * param1 + 3000;
         if(param2)
         {
            _loc4_ = Math.min(_loc4_,3000);
         }
         _location3D.changeLocation(_loc6_,_loc5_,_loc4_);
      }
      
      override public function onSnowBallHit(param1:SnowWarGameStage, param2:SnowBallGameObject) : void
      {
      }
      
      public function toString() : String
      {
         return " location=(" + _location3D.x + "," + _location3D.y + "," + _location3D.z + ")" + " dir=" + _movementDirection360 + " paraOffs=" + UnknownVarFromSnowBallGameObject_Int_4 + " ttl=" + UnknownVarFromSnowBallGameObject_Int_3;
      }
      
      public function get throwingHuman() : HumanGameObject
      {
         return _throwingHuman;
      }
   }
}

