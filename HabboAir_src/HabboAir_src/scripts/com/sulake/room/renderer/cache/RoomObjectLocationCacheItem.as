package com.sulake.room.renderer.cache
{
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   [SecureSWF(rename="true")]
   public class RoomObjectLocationCacheItem
   {
      private var UnknownVarFromRoomObjectLocationCacheItem_String_1:String = "";
      
      private var UnknownVarFromRoomObjectLocationCacheItem_Int_1:int = -1;
      
      private var UnknownVarFromRoomObjectLocationCacheItem_Int_2:int = -1;
      
      private var UnknownVarFromRoomObjectLocationCacheItem_Vector3d_1:Vector3d = new Vector3d();
      
      private var UnknownVarFromRoomObjectLocationCacheItem_Vector3d_2:Vector3d = null;
      
      private var UnknownVarFromRoomObjectLocationCacheItem_Vector3d_3:Vector3d = null;
      
      private var _locationChanged:Boolean = false;
      
      public function RoomObjectLocationCacheItem(param1:String)
      {
         super();
         UnknownVarFromRoomObjectLocationCacheItem_String_1 = param1;
         UnknownVarFromRoomObjectLocationCacheItem_Vector3d_2 = new Vector3d();
         UnknownVarFromRoomObjectLocationCacheItem_Vector3d_3 = new Vector3d();
      }
      
      public function get locationChanged() : Boolean
      {
         return _locationChanged;
      }
      
      public function dispose() : void
      {
         UnknownVarFromRoomObjectLocationCacheItem_Vector3d_2 = null;
         UnknownVarFromRoomObjectLocationCacheItem_Vector3d_3 = null;
      }
      
      public function getScreenLocation(param1:IRoomObject, param2:IRoomGeometry) : IVector3d
      {
         var _loc7_:IVector3d = null;
         var _loc3_:Number = NaN;
         var _loc5_:IVector3d = null;
         if(param1 == null || param2 == null)
         {
            return null;
         }
         var _loc4_:Boolean = false;
         var _loc6_:IVector3d = param1.getLocation();
         if(param2.updateId != UnknownVarFromRoomObjectLocationCacheItem_Int_1 || param1.getUpdateID() != UnknownVarFromRoomObjectLocationCacheItem_Int_2)
         {
            UnknownVarFromRoomObjectLocationCacheItem_Int_2 = param1.getUpdateID();
            if(param2.updateId != UnknownVarFromRoomObjectLocationCacheItem_Int_1 || _loc6_.x != UnknownVarFromRoomObjectLocationCacheItem_Vector3d_1.x || _loc6_.y != UnknownVarFromRoomObjectLocationCacheItem_Vector3d_1.y || _loc6_.z != UnknownVarFromRoomObjectLocationCacheItem_Vector3d_1.z)
            {
               UnknownVarFromRoomObjectLocationCacheItem_Int_1 = param2.updateId;
               UnknownVarFromRoomObjectLocationCacheItem_Vector3d_1.assign(_loc6_);
               _loc4_ = true;
            }
         }
         _locationChanged = _loc4_;
         if(_loc4_)
         {
            _loc7_ = param2.getScreenPosition(_loc6_);
            if(_loc7_ == null)
            {
               return null;
            }
            _loc3_ = param1.getModel().getNumber(UnknownVarFromRoomObjectLocationCacheItem_String_1);
            if(isNaN(_loc3_) || _loc3_ == 0)
            {
               UnknownVarFromRoomObjectLocationCacheItem_Vector3d_3.x = Math.round(_loc6_.x);
               UnknownVarFromRoomObjectLocationCacheItem_Vector3d_3.y = Math.round(_loc6_.y);
               UnknownVarFromRoomObjectLocationCacheItem_Vector3d_3.z = _loc6_.z;
               if(UnknownVarFromRoomObjectLocationCacheItem_Vector3d_3.x != _loc6_.x || UnknownVarFromRoomObjectLocationCacheItem_Vector3d_3.y != _loc6_.y)
               {
                  _loc5_ = param2.getScreenPosition(UnknownVarFromRoomObjectLocationCacheItem_Vector3d_3);
                  UnknownVarFromRoomObjectLocationCacheItem_Vector3d_2.assign(_loc7_);
                  if(_loc5_ != null)
                  {
                     UnknownVarFromRoomObjectLocationCacheItem_Vector3d_2.z = _loc5_.z;
                  }
               }
               else
               {
                  UnknownVarFromRoomObjectLocationCacheItem_Vector3d_2.assign(_loc7_);
               }
            }
            else
            {
               UnknownVarFromRoomObjectLocationCacheItem_Vector3d_2.assign(_loc7_);
            }
         }
         return UnknownVarFromRoomObjectLocationCacheItem_Vector3d_2;
      }
   }
}

