package com.sulake.habbo.room.utils
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   [SecureSWF(rename="true")]
   public class LegacyWallGeometry implements IComponentInterfaceQueue
   {
      public static const UnknownConstFromLegacyWallGeometry_String_1:String = "l";
      
      public static const DIRECTION_RIGHT:String = "r";
      
      private var _disposed:Boolean = false;
      
      private var _scale:int = 64;
      
      private var UnknownVarFromLegacyWallGeometry_Array_1:Array = [];
      
      private var _width:int = 0;
      
      private var UnknownVarFromLegacyWallGeometry_Int_1:int = 0;
      
      private var _floorHeight:int = 0;
      
      public function LegacyWallGeometry()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get scale() : int
      {
         return _scale;
      }
      
      public function set scale(param1:int) : void
      {
         _scale = param1;
      }
      
      public function dispose() : void
      {
         reset();
         _disposed = true;
      }
      
      public function initialize(param1:int, param2:int, param3:int) : void
      {
         var _loc6_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         if(param1 <= _width && param2 <= UnknownVarFromLegacyWallGeometry_Int_1)
         {
            _width = param1;
            UnknownVarFromLegacyWallGeometry_Int_1 = param2;
            _floorHeight = param3;
            return;
         }
         reset();
         _loc6_ = 0;
         while(_loc6_ < param2)
         {
            _loc4_ = [];
            UnknownVarFromLegacyWallGeometry_Array_1.push(_loc4_);
            _loc5_ = 0;
            while(_loc5_ < param1)
            {
               _loc4_.push(0);
               _loc5_++;
            }
            _loc6_++;
         }
         _width = param1;
         UnknownVarFromLegacyWallGeometry_Int_1 = param2;
         _floorHeight = param3;
      }
      
      private function reset() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Array = null;
         if(UnknownVarFromLegacyWallGeometry_Array_1 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < UnknownVarFromLegacyWallGeometry_Array_1.length)
            {
               _loc1_ = UnknownVarFromLegacyWallGeometry_Array_1[_loc2_] as Array;
               _loc2_++;
            }
            UnknownVarFromLegacyWallGeometry_Array_1 = [];
         }
      }
      
      public function setTileHeight(param1:int, param2:int, param3:Number) : Boolean
      {
         if(param1 < 0 || param1 >= _width || param2 < 0 || param2 >= UnknownVarFromLegacyWallGeometry_Int_1)
         {
            return false;
         }
         var _loc4_:Array = UnknownVarFromLegacyWallGeometry_Array_1[param2] as Array;
         if(_loc4_ != null)
         {
            _loc4_[param1] = param3;
            return true;
         }
         return false;
      }
      
      public function getTileHeight(param1:int, param2:int) : Number
      {
         if(param1 < 0 || param1 >= _width || param2 < 0 || param2 >= UnknownVarFromLegacyWallGeometry_Int_1)
         {
            return 0;
         }
         var _loc3_:Array = UnknownVarFromLegacyWallGeometry_Array_1[param2] as Array;
         if(_loc3_ != null)
         {
            return _loc3_[param1] as Number;
         }
         return 0;
      }
      
      public function getLocation(param1:int, param2:int, param3:int, param4:int, param5:String) : IVector3d
      {
         var _loc7_:Number = param1;
         var _loc8_:Number = param2;
         var _loc9_:Number = getTileHeight(param1,param2);
         if(param5 == "r")
         {
            _loc7_ += param3 / (_scale / 2) - 0.5;
            _loc8_ += 0.5;
            _loc9_ -= (param4 - param3 / 2) / (_scale / 2);
         }
         else
         {
            _loc8_ += (_scale / 2 - param3) / (_scale / 2) - 0.5;
            _loc7_ += 0.5;
            _loc9_ -= (param4 - (_scale / 2 - param3) / 2) / (_scale / 2);
         }
         return new Vector3d(_loc7_,_loc8_,_loc9_);
      }
      
      public function getLocationOldFormat(param1:Number, param2:Number, param3:String) : IVector3d
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:Number = 0;
         var _loc4_:Number = 0;
         _loc7_ = Math.ceil(param1);
         _loc5_ = _loc7_ - param1;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc12_:int = 0;
         var _loc11_:int = 0;
         var _loc13_:Number = 0;
         _loc6_ = 0;
         while(_loc6_ < _width)
         {
            if(_loc7_ >= 0 && _loc7_ < UnknownVarFromLegacyWallGeometry_Int_1)
            {
               if(getTileHeight(_loc6_,_loc7_) <= _floorHeight)
               {
                  _loc8_ = _loc6_ - 1;
                  _loc9_ = _loc7_;
                  _loc4_ = _loc6_;
                  param3 = "l";
                  break;
               }
               if(getTileHeight(_loc6_,_loc7_ + 1) <= _floorHeight)
               {
                  _loc8_ = _loc6_;
                  _loc9_ = _loc7_;
                  _loc4_ = _loc9_ - param1;
                  param3 = "r";
                  break;
               }
            }
            _loc7_++;
            _loc6_++;
         }
         _loc12_ = scale / 2 * _loc5_;
         var _loc10_:Number = -_loc4_ * scale / 2;
         _loc10_ = _loc10_ + -param2 * 18 / 32 * scale / 2;
         _loc13_ = getTileHeight(_loc8_,_loc9_);
         _loc11_ = _loc13_ * scale / 2 + _loc10_;
         if(param3 == "r")
         {
            _loc11_ += _loc5_ * scale / 4;
         }
         else
         {
            _loc11_ += (1 - _loc5_) * scale / 4;
         }
         return getLocation(_loc8_,_loc9_,_loc12_,_loc11_,param3);
      }
      
      public function getOldLocation(param1:IVector3d, param2:Number) : Array
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc7_:Number = 0;
         var _loc5_:Number = 0;
         var _loc8_:String = "";
         var _loc6_:Number = 0;
         if(param2 == 90)
         {
            _loc3_ = Math.floor(param1.x - 0.5);
            _loc4_ = Math.floor(param1.y + 0.5);
            _loc6_ = getTileHeight(_loc3_,_loc4_);
            _loc7_ = _scale / 2 - (param1.y - _loc4_ + 0.5) * (_scale / 2);
            _loc5_ = (_loc6_ - param1.z) * (_scale / 2) + (_scale / 2 - _loc7_) / 2;
            _loc8_ = "l";
         }
         else
         {
            if(param2 != 180)
            {
               return null;
            }
            _loc3_ = Math.floor(param1.x + 0.5);
            _loc4_ = Math.floor(param1.y - 0.5);
            _loc6_ = getTileHeight(_loc3_,_loc4_);
            _loc7_ = (param1.x + 0.5 - _loc3_) * (_scale / 2);
            _loc5_ = (_loc6_ - param1.z) * (_scale / 2) + _loc7_ / 2;
            _loc8_ = "r";
         }
         return [_loc3_,_loc4_,_loc7_,_loc5_,_loc8_];
      }
      
      public function getOldLocationString(param1:IVector3d, param2:Number) : String
      {
         var _loc3_:Array = getOldLocation(param1,param2);
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc4_:int = int(_loc3_[0]);
         var _loc5_:int = int(_loc3_[1]);
         var _loc9_:int = int(_loc3_[2]);
         var _loc6_:int = int(_loc3_[3]);
         var _loc8_:String = _loc3_[4];
         return ":w=" + _loc4_ + "," + _loc5_ + " l=" + _loc9_ + "," + _loc6_ + " " + _loc8_;
      }
      
      public function getDirection(param1:String) : Number
      {
         if(param1 == "r")
         {
            return 180;
         }
         return 90;
      }
      
      public function getFloorAltitude(param1:int, param2:int) : Number
      {
         var _loc4_:int = getTileHeight(param1,param2);
         var _loc3_:int = _loc4_ + 1;
         return _loc4_ + (int(getTileHeight(param1 - 1,param2 - 1)) == _loc3_ || int(getTileHeight(param1,param2 - 1)) == _loc3_ || int(getTileHeight(param1 + 1,param2 - 1)) == _loc3_ || int(getTileHeight(param1 - 1,param2)) == _loc3_ || int(getTileHeight(param1 + 1,param2)) == _loc3_ || int(getTileHeight(param1 - 1,param2 + 1)) == _loc3_ || int(getTileHeight(param1,param2 + 1)) == _loc3_ || int(getTileHeight(param1 + 1,param2 + 1)) == _loc3_ ? 0.5 : 0);
      }
      
      public function isRoomTile(param1:int, param2:int) : Boolean
      {
         return param1 >= 0 && param1 < _width && param2 >= 0 && param2 < UnknownVarFromLegacyWallGeometry_Int_1 && UnknownVarFromLegacyWallGeometry_Array_1[param2][param1] >= 0;
      }
   }
}

