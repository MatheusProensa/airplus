package com.sulake.habbo.room.object
{
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   public class RoomPlaneBitmapMaskData
   {
      public static const MASK_CATEGORY_WINDOW:String = "window";
      
      public static const MASK_CATEGORY_HOLE:String = "hole";
      
      private var _loc:Vector3d = null;
      
      private var _type:String = null;
      
      private var _category:String = null;
      
      public function RoomPlaneBitmapMaskData(param1:String, param2:IVector3d, param3:String)
      {
         super();
         this.type = param1;
         this.loc = param2;
         this.category = param3;
      }
      
      public function get loc() : IVector3d
      {
         return _loc;
      }
      
      public function set loc(param1:IVector3d) : void
      {
         if(_loc == null)
         {
            _loc = new Vector3d();
         }
         _loc.assign(param1);
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function set type(param1:String) : void
      {
         _type = param1;
      }
      
      public function get category() : String
      {
         return _category;
      }
      
      public function set category(param1:String) : void
      {
         _category = param1;
      }
      
      public function dispose() : void
      {
         _loc = null;
      }
   }
}

