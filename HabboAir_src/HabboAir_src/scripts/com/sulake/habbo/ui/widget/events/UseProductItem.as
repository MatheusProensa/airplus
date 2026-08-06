package com.sulake.habbo.ui.widget.events
{
   public class UseProductItem
   {
      private var _id:int;
      
      private var _category:int;
      
      private var _name:String;
      
      private var _requestRoomObjectId:int;
      
      private var _targetRoomObjectId:int;
      
      private var _requestInventoryStripId:int;
      
      private var _replace:Boolean;
      
      public function UseProductItem(param1:int, param2:int, param3:String, param4:int, param5:int, param6:int = -1, param7:Boolean = false)
      {
         super();
         _id = param1;
         _category = param2;
         _name = param3;
         _requestRoomObjectId = param4;
         _targetRoomObjectId = param5;
         _requestInventoryStripId = param6;
         _replace = param7;
      }
      
      public function dispose() : void
      {
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get category() : int
      {
         return _category;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get requestRoomObjectId() : int
      {
         return _requestRoomObjectId;
      }
      
      public function get targetRoomObjectId() : int
      {
         return _targetRoomObjectId;
      }
      
      public function get requestInventoryStripId() : int
      {
         return _requestInventoryStripId;
      }
      
      public function get replace() : Boolean
      {
         return _replace;
      }
   }
}

