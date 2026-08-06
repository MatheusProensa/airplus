package com.sulake.habbo.communication.messages.incoming.navigator
{
   [SecureSWF(rename="true")]
   public class RoomThumbnailObjectData
   {
      private var _pos:int;
      
      private var _imgId:int;
      
      public function RoomThumbnailObjectData()
      {
         super();
      }
      
      public function getCopy() : RoomThumbnailObjectData
      {
         var _loc1_:RoomThumbnailObjectData = new RoomThumbnailObjectData();
         _loc1_._pos = this._pos;
         _loc1_._imgId = this._imgId;
         return _loc1_;
      }
      
      public function set pos(param1:int) : void
      {
         this._pos = param1;
      }
      
      public function set imgId(param1:int) : void
      {
         this._imgId = param1;
      }
      
      public function get pos() : int
      {
         return _pos;
      }
      
      public function get imgId() : int
      {
         return _imgId;
      }
   }
}

