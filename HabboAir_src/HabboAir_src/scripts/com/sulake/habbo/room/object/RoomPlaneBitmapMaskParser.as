package com.sulake.habbo.room.object
{
   import com.sulake.core.utils.Map;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.UnknownRoomUtils1;
   import com.sulake.room.utils.Vector3d;
   
   public class RoomPlaneBitmapMaskParser
   {
      private var UnknownVarFromRoomPlaneBitmapMaskParser_Map_1:Map = null;
      
      public function RoomPlaneBitmapMaskParser()
      {
         super();
         UnknownVarFromRoomPlaneBitmapMaskParser_Map_1 = new Map();
      }
      
      public function get maskCount() : int
      {
         return UnknownVarFromRoomPlaneBitmapMaskParser_Map_1.length;
      }
      
      public function dispose() : void
      {
         if(UnknownVarFromRoomPlaneBitmapMaskParser_Map_1 != null)
         {
            reset();
            UnknownVarFromRoomPlaneBitmapMaskParser_Map_1.dispose();
            UnknownVarFromRoomPlaneBitmapMaskParser_Map_1 = null;
         }
      }
      
      public function initialize(param1:XML) : Boolean
      {
         var _loc3_:int = 0;
         var _loc14_:XML = null;
         var _loc12_:String = null;
         var _loc5_:String = null;
         var _loc10_:Vector3d = null;
         var _loc13_:String = null;
         var _loc6_:XMLList = null;
         var _loc11_:XML = null;
         var _loc2_:RoomPlaneBitmapMaskData = null;
         if(param1 == null)
         {
            return false;
         }
         UnknownVarFromRoomPlaneBitmapMaskParser_Map_1.reset();
         var _loc7_:Array = ["id","type","category"];
         var _loc8_:Array = ["x","y","z"];
         var _loc9_:XMLList = null;
         var _loc4_:XMLList = param1.planeMask;
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length())
         {
            _loc14_ = _loc4_[_loc3_];
            if(!UnknownRoomUtils1.checkRequiredAttributes(_loc14_,_loc7_))
            {
               return false;
            }
            _loc12_ = _loc14_.@id;
            _loc5_ = _loc14_.@type;
            _loc10_ = null;
            _loc13_ = _loc14_.@category;
            _loc6_ = _loc14_.location;
            if(_loc6_.length() != 1)
            {
               return false;
            }
            _loc11_ = _loc6_[0];
            if(!UnknownRoomUtils1.checkRequiredAttributes(_loc11_,_loc8_))
            {
               return false;
            }
            _loc10_ = new Vector3d(Number(_loc11_.@x),Number(_loc11_.@y),Number(_loc11_.@z));
            _loc2_ = new RoomPlaneBitmapMaskData(_loc5_,_loc10_,_loc13_);
            UnknownVarFromRoomPlaneBitmapMaskParser_Map_1.add(_loc12_,_loc2_);
            _loc3_++;
         }
         return true;
      }
      
      public function reset() : void
      {
         var _loc1_:int = 0;
         var _loc2_:RoomPlaneBitmapMaskData = null;
         _loc1_ = 0;
         while(_loc1_ < UnknownVarFromRoomPlaneBitmapMaskParser_Map_1.length)
         {
            _loc2_ = UnknownVarFromRoomPlaneBitmapMaskParser_Map_1.getWithIndex(_loc1_) as RoomPlaneBitmapMaskData;
            if(_loc2_ != null)
            {
               _loc2_.dispose();
            }
            _loc1_++;
         }
         UnknownVarFromRoomPlaneBitmapMaskParser_Map_1.reset();
      }
      
      public function addMask(param1:String, param2:String, param3:IVector3d, param4:String) : Boolean
      {
         if(param1 == null || param1 == "" || param2 == null || param2 == "" || param3 == null)
         {
            return false;
         }
         var _loc6_:RoomPlaneBitmapMaskData = new RoomPlaneBitmapMaskData(param2,param3,param4);
         var _loc5_:RoomPlaneBitmapMaskData = UnknownVarFromRoomPlaneBitmapMaskParser_Map_1.remove(param1) as RoomPlaneBitmapMaskData;
         if(_loc5_ != null)
         {
            _loc5_.dispose();
         }
         UnknownVarFromRoomPlaneBitmapMaskParser_Map_1.add(param1,_loc6_);
         return true;
      }
      
      public function removeMask(param1:String) : Boolean
      {
         var _loc2_:RoomPlaneBitmapMaskData = UnknownVarFromRoomPlaneBitmapMaskParser_Map_1.remove(param1) as RoomPlaneBitmapMaskData;
         if(_loc2_ != null)
         {
            _loc2_.dispose();
            return true;
         }
         return false;
      }
      
      public function getXML() : XML
      {
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc3_:XML = null;
         var _loc1_:IVector3d = null;
         var _loc2_:XML = <planeMasks/>
			
			;
         _loc4_ = 0;
         while(_loc4_ < maskCount)
         {
            _loc5_ = getMaskType(_loc4_);
            _loc6_ = getMaskCategory(_loc4_);
            _loc3_ = <planeMask id={_loc4_} type={_loc5_} category={_loc6_}/>
				;
            _loc1_ = getMaskLocation(_loc4_);
            if(_loc1_ != null)
            {
               _loc3_.appendChild(<location x={_loc1_.x} y={_loc1_.y} z={_loc1_.z}/> );
               _loc2_.appendChild(_loc3_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function getMaskLocation(param1:int) : IVector3d
      {
         if(param1 < 0 || param1 >= maskCount)
         {
            return null;
         }
         var _loc2_:RoomPlaneBitmapMaskData = UnknownVarFromRoomPlaneBitmapMaskParser_Map_1.getWithIndex(param1) as RoomPlaneBitmapMaskData;
         if(_loc2_ != null)
         {
            return _loc2_.loc;
         }
         return null;
      }
      
      public function getMaskType(param1:int) : String
      {
         if(param1 < 0 || param1 >= maskCount)
         {
            return null;
         }
         var _loc2_:RoomPlaneBitmapMaskData = UnknownVarFromRoomPlaneBitmapMaskParser_Map_1.getWithIndex(param1) as RoomPlaneBitmapMaskData;
         if(_loc2_ != null)
         {
            return _loc2_.type;
         }
         return null;
      }
      
      public function getMaskCategory(param1:int) : String
      {
         if(param1 < 0 || param1 >= maskCount)
         {
            return null;
         }
         var _loc2_:RoomPlaneBitmapMaskData = UnknownVarFromRoomPlaneBitmapMaskParser_Map_1.getWithIndex(param1) as RoomPlaneBitmapMaskData;
         if(_loc2_ != null)
         {
            return _loc2_.category;
         }
         return null;
      }
   }
}

