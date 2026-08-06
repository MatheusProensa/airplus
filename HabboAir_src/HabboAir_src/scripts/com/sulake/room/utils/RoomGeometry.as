package com.sulake.room.utils
{
   import com.sulake.core.utils.Map;
   import flash.geom.Point;
   
   public class RoomGeometry implements IRoomGeometry
   {
      public static const SCALE_ZOOMED_IN:Number = 64;
      
      public static const SCALE_ZOOMED_OUT:Number = 32;
      
      private var _updateId:int = 0;
      
      private var UnknownVarFromRoomGeometry_Vector3d_1:Vector3d;
      
      private var UnknownVarFromRoomGeometry_Vector3d_2:Vector3d;
      
      private var UnknownVarFromRoomGeometry_Vector3d_3:Vector3d;
      
      private var _directionAxis:Vector3d;
      
      private var UnknownVarFromRoomGeometry_Vector3d_4:Vector3d;
      
      private var _direction:Vector3d;
      
      private var _depth:Vector3d;
      
      private var UnknownVarFromRoomGeometry_Number_1:Number = 1;
      
      private var UnknownVarFromRoomGeometry_Number_2:Number = 1;
      
      private var UnknownVarFromRoomGeometry_Number_3:Number = 1;
      
      private var UnknownVarFromRoomGeometry_Number_4:Number = 1;
      
      private var _x_scale_internal:Number = 1;
      
      private var _y_scale_internal:Number = 1;
      
      private var _z_scale_internal:Number = 1;
      
      private var UnknownVarFromRoomGeometry_Vector3d_5:Vector3d;
      
      private var UnknownVarFromRoomGeometry_Vector3d_6:Vector3d;
      
      private var UnknownVarFromRoomGeometry_Number_5:Number = -500;
      
      private var UnknownVarFromRoomGeometry_Number_6:Number = 500;
      
      private var UnknownVarFromRoomGeometry_Map_1:Map = null;
      
      public var LockAnimationFPS:Boolean = true;
      
      public function RoomGeometry(param1:Number, param2:IVector3d, param3:IVector3d, param4:IVector3d = null)
      {
         super();
         this.scale = param1;
         UnknownVarFromRoomGeometry_Vector3d_1 = new Vector3d();
         UnknownVarFromRoomGeometry_Vector3d_2 = new Vector3d();
         UnknownVarFromRoomGeometry_Vector3d_3 = new Vector3d();
         _directionAxis = new Vector3d();
         UnknownVarFromRoomGeometry_Vector3d_4 = new Vector3d();
         _direction = new Vector3d();
         _depth = new Vector3d();
         _x_scale_internal = 1;
         _y_scale_internal = 1;
         x_scale = 1;
         y_scale = 1;
         _z_scale_internal = Math.sqrt(0.5) / Math.sqrt(0.75);
         z_scale = 1;
         location = new Vector3d(param3.x,param3.y,param3.z);
         direction = new Vector3d(param2.x,param2.y,param2.z);
         if(param4 != null)
         {
            setDepthVector(param4);
         }
         else
         {
            setDepthVector(param2);
         }
         UnknownVarFromRoomGeometry_Map_1 = new Map();
      }
      
      public static function getIntersectionVector(param1:IVector3d, param2:IVector3d, param3:IVector3d, param4:IVector3d) : IVector3d
      {
         var _loc6_:Number = Vector3d.dotProduct(param2,param4);
         if(Math.abs(_loc6_) < 0.00001)
         {
            return null;
         }
         var _loc8_:Vector3d = Vector3d.dif(param1,param3);
         var _loc5_:Number = -Vector3d.dotProduct(param4,_loc8_) / _loc6_;
         return Vector3d.sum(param1,Vector3d.product(param2,_loc5_));
      }
      
      public function get updateId() : int
      {
         return _updateId;
      }
      
      public function get scale() : Number
      {
         return UnknownVarFromRoomGeometry_Number_1 / Math.sqrt(0.5);
      }
      
      public function get directionAxis() : IVector3d
      {
         return _directionAxis;
      }
      
      public function get location() : IVector3d
      {
         UnknownVarFromRoomGeometry_Vector3d_4.assign(UnknownVarFromRoomGeometry_Vector3d_5);
         UnknownVarFromRoomGeometry_Vector3d_4.x *= UnknownVarFromRoomGeometry_Number_2;
         UnknownVarFromRoomGeometry_Vector3d_4.y *= UnknownVarFromRoomGeometry_Number_3;
         UnknownVarFromRoomGeometry_Vector3d_4.z *= UnknownVarFromRoomGeometry_Number_4;
         return UnknownVarFromRoomGeometry_Vector3d_4;
      }
      
      public function get direction() : IVector3d
      {
         return _direction;
      }
      
      public function set x_scale(param1:Number) : void
      {
         if(UnknownVarFromRoomGeometry_Number_2 != param1 * _x_scale_internal)
         {
            UnknownVarFromRoomGeometry_Number_2 = param1 * _x_scale_internal;
            _updateId++;
         }
      }
      
      public function set y_scale(param1:Number) : void
      {
         if(UnknownVarFromRoomGeometry_Number_3 != param1 * _y_scale_internal)
         {
            UnknownVarFromRoomGeometry_Number_3 = param1 * _y_scale_internal;
            _updateId++;
         }
      }
      
      public function set z_scale(param1:Number) : void
      {
         if(UnknownVarFromRoomGeometry_Number_4 != param1 * _z_scale_internal)
         {
            UnknownVarFromRoomGeometry_Number_4 = param1 * _z_scale_internal;
            _updateId++;
         }
      }
      
      public function set scale(param1:Number) : void
      {
         if(param1 <= 1)
         {
            param1 = 1;
         }
         param1 *= Math.sqrt(0.5);
         if(param1 != UnknownVarFromRoomGeometry_Number_1)
         {
            UnknownVarFromRoomGeometry_Number_1 = param1;
            _updateId++;
         }
      }
      
      public function set location(param1:IVector3d) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(UnknownVarFromRoomGeometry_Vector3d_5 == null)
         {
            UnknownVarFromRoomGeometry_Vector3d_5 = new Vector3d();
         }
         var _loc2_:Number = UnknownVarFromRoomGeometry_Vector3d_5.x;
         var _loc3_:Number = UnknownVarFromRoomGeometry_Vector3d_5.y;
         var _loc4_:Number = UnknownVarFromRoomGeometry_Vector3d_5.z;
         UnknownVarFromRoomGeometry_Vector3d_5.assign(param1);
         UnknownVarFromRoomGeometry_Vector3d_5.x /= UnknownVarFromRoomGeometry_Number_2;
         UnknownVarFromRoomGeometry_Vector3d_5.y /= UnknownVarFromRoomGeometry_Number_3;
         UnknownVarFromRoomGeometry_Vector3d_5.z /= UnknownVarFromRoomGeometry_Number_4;
         if(UnknownVarFromRoomGeometry_Vector3d_5.x != _loc2_ || UnknownVarFromRoomGeometry_Vector3d_5.y != _loc3_ || UnknownVarFromRoomGeometry_Vector3d_5.z != _loc4_)
         {
            _updateId++;
         }
      }
      
      public function set direction(param1:IVector3d) : void
      {
         var _loc4_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc19_:Vector3d = null;
         var _loc14_:Vector3d = null;
         var _loc2_:Vector3d = null;
         if(param1 == null)
         {
            return;
         }
         if(UnknownVarFromRoomGeometry_Vector3d_6 == null)
         {
            UnknownVarFromRoomGeometry_Vector3d_6 = new Vector3d();
         }
         var _loc7_:Number = UnknownVarFromRoomGeometry_Vector3d_6.x;
         var _loc8_:Number = UnknownVarFromRoomGeometry_Vector3d_6.y;
         var _loc9_:Number = UnknownVarFromRoomGeometry_Vector3d_6.z;
         UnknownVarFromRoomGeometry_Vector3d_6.assign(param1);
         _direction.assign(param1);
         if(UnknownVarFromRoomGeometry_Vector3d_6.x != _loc7_ || UnknownVarFromRoomGeometry_Vector3d_6.y != _loc8_ || UnknownVarFromRoomGeometry_Vector3d_6.z != _loc9_)
         {
            _updateId++;
         }
         var _loc18_:Vector3d = new Vector3d(0,1,0);
         var _loc20_:Vector3d = new Vector3d(0,0,1);
         var _loc22_:Vector3d = new Vector3d(1,0,0);
         var _loc10_:Number = param1.x / 180 * 3.141592653589793;
         var _loc11_:Number = param1.y / 180 * 3.141592653589793;
         var _loc12_:Number = param1.z / 180 * 3.141592653589793;
         var _loc6_:Number = Math.cos(_loc10_);
         var _loc25_:Number = Math.sin(_loc10_);
         var _loc16_:Vector3d = Vector3d.sum(Vector3d.product(_loc18_,_loc6_),Vector3d.product(_loc22_,-_loc25_));
         var _loc15_:Vector3d = new Vector3d(_loc20_.x,_loc20_.y,_loc20_.z);
         var _loc17_:Vector3d = Vector3d.sum(Vector3d.product(_loc18_,_loc25_),Vector3d.product(_loc22_,_loc6_));
         var _loc5_:Number = Math.cos(_loc11_);
         var _loc24_:Number = Math.sin(_loc11_);
         var _loc13_:Vector3d = new Vector3d(_loc16_.x,_loc16_.y,_loc16_.z);
         var _loc23_:Vector3d = Vector3d.sum(Vector3d.product(_loc15_,_loc5_),Vector3d.product(_loc17_,_loc24_));
         var _loc3_:Vector3d = Vector3d.sum(Vector3d.product(_loc15_,-_loc24_),Vector3d.product(_loc17_,_loc5_));
         if(_loc12_ != 0)
         {
            _loc4_ = Math.cos(_loc12_);
            _loc21_ = Math.sin(_loc12_);
            _loc19_ = Vector3d.sum(Vector3d.product(_loc13_,_loc4_),Vector3d.product(_loc23_,_loc21_));
            _loc14_ = Vector3d.sum(Vector3d.product(_loc13_,-_loc21_),Vector3d.product(_loc23_,_loc4_));
            _loc2_ = new Vector3d(_loc3_.x,_loc3_.y,_loc3_.z);
            UnknownVarFromRoomGeometry_Vector3d_1.assign(_loc19_);
            UnknownVarFromRoomGeometry_Vector3d_2.assign(_loc14_);
            UnknownVarFromRoomGeometry_Vector3d_3.assign(_loc2_);
            _directionAxis.assign(UnknownVarFromRoomGeometry_Vector3d_3);
         }
         else
         {
            UnknownVarFromRoomGeometry_Vector3d_1.assign(_loc13_);
            UnknownVarFromRoomGeometry_Vector3d_2.assign(_loc23_);
            UnknownVarFromRoomGeometry_Vector3d_3.assign(_loc3_);
            _directionAxis.assign(UnknownVarFromRoomGeometry_Vector3d_3);
         }
      }
      
      public function dispose() : void
      {
         UnknownVarFromRoomGeometry_Vector3d_1 = null;
         UnknownVarFromRoomGeometry_Vector3d_2 = null;
         UnknownVarFromRoomGeometry_Vector3d_3 = null;
         UnknownVarFromRoomGeometry_Vector3d_5 = null;
         UnknownVarFromRoomGeometry_Vector3d_6 = null;
         _directionAxis = null;
         UnknownVarFromRoomGeometry_Vector3d_4 = null;
         if(UnknownVarFromRoomGeometry_Map_1 != null)
         {
            UnknownVarFromRoomGeometry_Map_1.dispose();
            UnknownVarFromRoomGeometry_Map_1 = null;
         }
      }
      
      public function setDisplacement(param1:IVector3d, param2:IVector3d) : void
      {
         var _loc4_:String = null;
         var _loc3_:Vector3d = null;
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(UnknownVarFromRoomGeometry_Map_1 != null)
         {
            _loc4_ = int(Math.round(param1.x)) + "_" + int(Math.round(param1.y)) + "_" + int(Math.round(param1.z));
            UnknownVarFromRoomGeometry_Map_1.remove(_loc4_);
            _loc3_ = new Vector3d();
            _loc3_.assign(param2);
            UnknownVarFromRoomGeometry_Map_1.add(_loc4_,_loc3_);
            _updateId++;
         }
      }
      
      private function getDisplacenent(param1:IVector3d) : IVector3d
      {
         var _loc2_:String = null;
         if(UnknownVarFromRoomGeometry_Map_1 != null)
         {
            _loc2_ = int(Math.round(param1.x)) + "_" + int(Math.round(param1.y)) + "_" + int(Math.round(param1.z));
            return UnknownVarFromRoomGeometry_Map_1.getValue(_loc2_);
         }
         return null;
      }
      
      public function setDepthVector(param1:IVector3d) : void
      {
         var _loc9_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc16_:Vector3d = null;
         var _loc7_:Vector3d = null;
         var _loc4_:Vector3d = null;
         var _loc15_:Vector3d = new Vector3d(0,1,0);
         var _loc17_:Vector3d = new Vector3d(0,0,1);
         var _loc19_:Vector3d = new Vector3d(1,0,0);
         var _loc2_:Number = param1.x / 180 * 3.141592653589793;
         var _loc3_:Number = param1.y / 180 * 3.141592653589793;
         var _loc5_:Number = param1.z / 180 * 3.141592653589793;
         var _loc11_:Number = Math.cos(_loc2_);
         var _loc22_:Number = Math.sin(_loc2_);
         var _loc13_:Vector3d = Vector3d.sum(Vector3d.product(_loc15_,_loc11_),Vector3d.product(_loc19_,-_loc22_));
         var _loc12_:Vector3d = new Vector3d(_loc17_.x,_loc17_.y,_loc17_.z);
         var _loc14_:Vector3d = Vector3d.sum(Vector3d.product(_loc15_,_loc22_),Vector3d.product(_loc19_,_loc11_));
         var _loc10_:Number = Math.cos(_loc3_);
         var _loc21_:Number = Math.sin(_loc3_);
         var _loc6_:Vector3d = new Vector3d(_loc13_.x,_loc13_.y,_loc13_.z);
         var _loc20_:Vector3d = Vector3d.sum(Vector3d.product(_loc12_,_loc10_),Vector3d.product(_loc14_,_loc21_));
         var _loc8_:Vector3d = Vector3d.sum(Vector3d.product(_loc12_,-_loc21_),Vector3d.product(_loc14_,_loc10_));
         if(_loc5_ != 0)
         {
            _loc9_ = Math.cos(_loc5_);
            _loc18_ = Math.sin(_loc5_);
            _loc16_ = Vector3d.sum(Vector3d.product(_loc6_,_loc9_),Vector3d.product(_loc20_,_loc18_));
            _loc7_ = Vector3d.sum(Vector3d.product(_loc6_,-_loc18_),Vector3d.product(_loc20_,_loc9_));
            _loc4_ = new Vector3d(_loc8_.x,_loc8_.y,_loc8_.z);
            _depth.assign(_loc4_);
         }
         else
         {
            _depth.assign(_loc8_);
         }
         _updateId++;
      }
      
      public function adjustLocation(param1:IVector3d, param2:Number) : void
      {
         if(param1 == null || UnknownVarFromRoomGeometry_Vector3d_3 == null)
         {
            return;
         }
         var _loc4_:Vector3d = Vector3d.product(UnknownVarFromRoomGeometry_Vector3d_3,-param2);
         var _loc3_:Vector3d = new Vector3d(param1.x + _loc4_.x,param1.y + _loc4_.y,param1.z + _loc4_.z);
         location = _loc3_;
      }
      
      public function getCoordinatePosition(param1:IVector3d) : IVector3d
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:Number = Vector3d.scalarProjection(param1,UnknownVarFromRoomGeometry_Vector3d_1);
         var _loc4_:Number = Vector3d.scalarProjection(param1,UnknownVarFromRoomGeometry_Vector3d_2);
         var _loc5_:Number = Vector3d.scalarProjection(param1,UnknownVarFromRoomGeometry_Vector3d_3);
         return new Vector3d(_loc3_,_loc4_,_loc5_);
      }
      
      public function getScreenPosition(param1:IVector3d) : IVector3d
      {
         var _loc2_:Vector3d = Vector3d.dif(param1,UnknownVarFromRoomGeometry_Vector3d_5);
         _loc2_.x *= UnknownVarFromRoomGeometry_Number_2;
         _loc2_.y *= UnknownVarFromRoomGeometry_Number_3;
         _loc2_.z *= UnknownVarFromRoomGeometry_Number_4;
         var _loc5_:Number = Vector3d.scalarProjection(_loc2_,_depth);
         if(_loc5_ < UnknownVarFromRoomGeometry_Number_5 || _loc5_ > UnknownVarFromRoomGeometry_Number_6)
         {
            return null;
         }
         var _loc3_:Number = Vector3d.scalarProjection(_loc2_,UnknownVarFromRoomGeometry_Vector3d_1);
         var _loc4_:Number = -Vector3d.scalarProjection(_loc2_,UnknownVarFromRoomGeometry_Vector3d_2);
         _loc3_ *= UnknownVarFromRoomGeometry_Number_1;
         _loc4_ *= UnknownVarFromRoomGeometry_Number_1;
         var _loc6_:IVector3d = getDisplacenent(param1);
         if(_loc6_ != null)
         {
            _loc2_ = Vector3d.dif(param1,UnknownVarFromRoomGeometry_Vector3d_5);
            _loc2_.add(_loc6_);
            _loc2_.x *= UnknownVarFromRoomGeometry_Number_2;
            _loc2_.y *= UnknownVarFromRoomGeometry_Number_3;
            _loc2_.z *= UnknownVarFromRoomGeometry_Number_4;
            _loc5_ = Vector3d.scalarProjection(_loc2_,_depth);
         }
         _loc2_.x = _loc3_;
         _loc2_.y = _loc4_;
         _loc2_.z = _loc5_;
         return _loc2_;
      }
      
      public function getScreenPoint(param1:IVector3d) : Point
      {
         var _loc2_:IVector3d = getScreenPosition(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         return new Point(_loc2_.x,_loc2_.y);
      }
      
      public function getPlanePosition(param1:Point, param2:IVector3d, param3:IVector3d, param4:IVector3d) : Point
      {
         var _loc10_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc14_:Number = param1.x / UnknownVarFromRoomGeometry_Number_1;
         var _loc16_:Number = -param1.y / UnknownVarFromRoomGeometry_Number_1;
         var _loc6_:Vector3d = Vector3d.product(UnknownVarFromRoomGeometry_Vector3d_1,_loc14_);
         _loc6_.add(Vector3d.product(UnknownVarFromRoomGeometry_Vector3d_2,_loc16_));
         var _loc8_:Vector3d = new Vector3d(UnknownVarFromRoomGeometry_Vector3d_5.x * UnknownVarFromRoomGeometry_Number_2,UnknownVarFromRoomGeometry_Vector3d_5.y * UnknownVarFromRoomGeometry_Number_3,UnknownVarFromRoomGeometry_Vector3d_5.z * UnknownVarFromRoomGeometry_Number_4);
         _loc8_.add(_loc6_);
         var _loc15_:IVector3d = UnknownVarFromRoomGeometry_Vector3d_3;
         var _loc5_:Vector3d = new Vector3d(param2.x * UnknownVarFromRoomGeometry_Number_2,param2.y * UnknownVarFromRoomGeometry_Number_3,param2.z * UnknownVarFromRoomGeometry_Number_4);
         var _loc13_:Vector3d = new Vector3d(param3.x * UnknownVarFromRoomGeometry_Number_2,param3.y * UnknownVarFromRoomGeometry_Number_3,param3.z * UnknownVarFromRoomGeometry_Number_4);
         var _loc7_:Vector3d = new Vector3d(param4.x * UnknownVarFromRoomGeometry_Number_2,param4.y * UnknownVarFromRoomGeometry_Number_3,param4.z * UnknownVarFromRoomGeometry_Number_4);
         var _loc11_:IVector3d = Vector3d.crossProduct(_loc13_,_loc7_);
         var _loc9_:Vector3d = new Vector3d();
         _loc9_.assign(RoomGeometry.getIntersectionVector(_loc8_,_loc15_,_loc5_,_loc11_));
         if(_loc9_ != null)
         {
            _loc9_.sub(_loc5_);
            _loc10_ = Vector3d.scalarProjection(_loc9_,param3) / _loc13_.length * param3.length;
            _loc12_ = Vector3d.scalarProjection(_loc9_,param4) / _loc7_.length * param4.length;
            return new Point(_loc10_,_loc12_);
         }
         return null;
      }
      
      public function performZoom() : void
      {
         if(isZoomedIn())
         {
            scale = 32;
         }
         else
         {
            scale = 64;
         }
      }
      
      public function isZoomedIn() : Boolean
      {
         return scale == 64;
      }
      
      public function performZoomOut() : void
      {
         scale = 32;
      }
      
      public function performZoomIn() : void
      {
         scale = 64;
      }
   }
}

