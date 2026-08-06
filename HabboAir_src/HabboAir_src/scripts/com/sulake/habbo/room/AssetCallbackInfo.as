package com.sulake.habbo.room
{
   public class AssetCallbackInfo
   {
      private var _id:int;
      
      private var _listeners:Vector.<UnknownIHabboRoom1>;
      
      public function AssetCallbackInfo(param1:int)
      {
         super();
         this._id = param1;
         this._listeners = new Vector.<UnknownIHabboRoom1>();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get listeners() : Vector.<UnknownIHabboRoom1>
      {
         return _listeners;
      }
   }
}

