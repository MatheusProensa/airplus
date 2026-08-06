package com.sulake.habbo.room.utils
{
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   [SecureSWF(rename="true")]
   public class RoomCamera
   {
      private static const MOVE_SPEED_DENOMINATOR:Number = 12;
      
      private var _targetId:int = -1;
      
      private var _targetCategory:int = -2;
      
      private var UnknownVarFromRoomCamera_Vector3d_1:Vector3d = null;
      
      private var UnknownVarFromRoomCamera_Number_1:Number = 0;
      
      private var UnknownVarFromRoomCamera_Number_2:Number = 0;
      
      private var UnknownVarFromRoomCamera_Boolean_1:Boolean = false;
      
      private var _location:Vector3d = null;
      
      private var _targetObjectLoc:Vector3d = new Vector3d();
      
      private var _limitedLocationX:Boolean = false;
      
      private var _limitedLocationY:Boolean = false;
      
      private var _centeredLocX:Boolean = false;
      
      private var _centeredLocY:Boolean = false;
      
      private var _screenWd:int = 0;
      
      private var _screenHt:int = 0;
      
      private var _scale:int = 0;
      
      private var _roomWd:int = 0;
      
      private var _roomHt:int = 0;
      
      private var _geometryUpdateId:int = -1;
      
      private var UnknownVarFromRoomCamera_Boolean_2:Boolean = false;
      
      private var UnknownVarFromRoomCamera_Int_1:int;
      
      public function RoomCamera()
      {
         super();
      }
      
      public function get location() : IVector3d
      {
         return _location;
      }
      
      public function get targetId() : int
      {
         return _targetId;
      }
      
      public function get targetCategory() : int
      {
         return _targetCategory;
      }
      
      public function get targetObjectLoc() : IVector3d
      {
         return _targetObjectLoc;
      }
      
      public function get limitedLocationX() : Boolean
      {
         return _limitedLocationX;
      }
      
      public function get limitedLocationY() : Boolean
      {
         return _limitedLocationY;
      }
      
      public function get centeredLocX() : Boolean
      {
         return _centeredLocX;
      }
      
      public function get centeredLocY() : Boolean
      {
         return _centeredLocY;
      }
      
      public function get screenWd() : int
      {
         return _screenWd;
      }
      
      public function get screenHt() : int
      {
         return _screenHt;
      }
      
      public function get scale() : int
      {
         return _scale;
      }
      
      public function get roomWd() : int
      {
         return _roomWd;
      }
      
      public function get roomHt() : int
      {
         return _roomHt;
      }
      
      public function get geometryUpdateId() : int
      {
         return _geometryUpdateId;
      }
      
      public function get isMoving() : Boolean
      {
         if(UnknownVarFromRoomCamera_Vector3d_1 != null && _location != null)
         {
            return true;
         }
         return false;
      }
      
      public function set targetId(param1:int) : void
      {
         _targetId = param1;
      }
      
      public function set targetObjectLoc(param1:IVector3d) : void
      {
         _targetObjectLoc.assign(param1);
      }
      
      public function set targetCategory(param1:int) : void
      {
         _targetCategory = param1;
      }
      
      public function set limitedLocationX(param1:Boolean) : void
      {
         _limitedLocationX = param1;
      }
      
      public function set limitedLocationY(param1:Boolean) : void
      {
         _limitedLocationY = param1;
      }
      
      public function set centeredLocX(param1:Boolean) : void
      {
         _centeredLocX = param1;
      }
      
      public function set centeredLocY(param1:Boolean) : void
      {
         _centeredLocY = param1;
      }
      
      public function set screenWd(param1:int) : void
      {
         _screenWd = param1;
      }
      
      public function set screenHt(param1:int) : void
      {
         _screenHt = param1;
      }
      
      public function set scale(param1:int) : void
      {
         if(_scale != param1)
         {
            _scale = param1;
            UnknownVarFromRoomCamera_Boolean_2 = true;
         }
      }
      
      public function set roomWd(param1:int) : void
      {
         _roomWd = param1;
      }
      
      public function set roomHt(param1:int) : void
      {
         _roomHt = param1;
      }
      
      public function set geometryUpdateId(param1:int) : void
      {
         _geometryUpdateId = param1;
      }
      
      public function set target(param1:IVector3d) : void
      {
         var _loc2_:Vector3d = null;
         if(UnknownVarFromRoomCamera_Vector3d_1 == null)
         {
            UnknownVarFromRoomCamera_Vector3d_1 = new Vector3d();
         }
         if(UnknownVarFromRoomCamera_Vector3d_1.x != param1.x || UnknownVarFromRoomCamera_Vector3d_1.y != param1.y || UnknownVarFromRoomCamera_Vector3d_1.z != param1.z)
         {
            UnknownVarFromRoomCamera_Vector3d_1.assign(param1);
            _loc2_ = Vector3d.dif(UnknownVarFromRoomCamera_Vector3d_1,_location);
            UnknownVarFromRoomCamera_Number_1 = _loc2_.length;
            UnknownVarFromRoomCamera_Boolean_1 = true;
         }
      }
      
      public function dispose() : void
      {
         UnknownVarFromRoomCamera_Vector3d_1 = null;
         _location = null;
      }
      
      public function initializeLocation(param1:IVector3d) : void
      {
         if(_location != null)
         {
            return;
         }
         _location = new Vector3d();
         _location.assign(param1);
      }
      
      public function resetLocation(param1:IVector3d) : void
      {
         if(_location == null)
         {
            _location = new Vector3d();
         }
         _location.assign(param1);
      }
      
      public function update(param1:uint, param2:Number) : void
      {
         var _loc4_:Vector3d = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc7_:Number = NaN;
         if(UnknownVarFromRoomCamera_Int_1 > 0 && UnknownVarFromRoomCamera_Vector3d_1 != null && _location != null)
         {
            if(UnknownVarFromRoomCamera_Boolean_2)
            {
               UnknownVarFromRoomCamera_Boolean_2 = false;
               _location = UnknownVarFromRoomCamera_Vector3d_1;
               UnknownVarFromRoomCamera_Vector3d_1 = null;
               return;
            }
            _loc4_ = Vector3d.dif(UnknownVarFromRoomCamera_Vector3d_1,_location);
            if(_loc4_.length > UnknownVarFromRoomCamera_Number_1)
            {
               UnknownVarFromRoomCamera_Number_1 = _loc4_.length;
            }
            if(_loc4_.length <= param2)
            {
               _location = UnknownVarFromRoomCamera_Vector3d_1;
               UnknownVarFromRoomCamera_Vector3d_1 = null;
               UnknownVarFromRoomCamera_Number_2 = 0;
            }
            else
            {
               _loc5_ = Math.sin(3.141592653589793 * _loc4_.length / UnknownVarFromRoomCamera_Number_1);
               _loc6_ = param2 * 0.5;
               _loc3_ = UnknownVarFromRoomCamera_Number_1 / 12;
               _loc7_ = _loc6_ + (_loc3_ - _loc6_) * _loc5_;
               if(UnknownVarFromRoomCamera_Boolean_1)
               {
                  if(_loc7_ < UnknownVarFromRoomCamera_Number_2)
                  {
                     _loc7_ = UnknownVarFromRoomCamera_Number_2;
                     if(_loc7_ > _loc4_.length)
                     {
                        _loc7_ = _loc4_.length;
                     }
                  }
                  else
                  {
                     UnknownVarFromRoomCamera_Boolean_1 = false;
                  }
               }
               UnknownVarFromRoomCamera_Number_2 = _loc7_;
               _loc4_.div(_loc4_.length);
               _loc4_.mul(_loc7_);
               _location = Vector3d.sum(_location,_loc4_);
            }
         }
      }
      
      public function reset() : void
      {
         _geometryUpdateId = -1;
      }
      
      public function activateFollowing(param1:int) : void
      {
         UnknownVarFromRoomCamera_Int_1 = param1;
      }
   }
}

