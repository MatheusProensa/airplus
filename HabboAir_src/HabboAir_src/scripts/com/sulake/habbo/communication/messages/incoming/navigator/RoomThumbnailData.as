package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class RoomThumbnailData implements IComponentInterfaceQueue
   {
      private var _bgImgId:int;
      
      private var _frontImgId:int;
      
      private var _objects:Array;
      
      private var _disposed:Boolean;
      
      public function RoomThumbnailData(param1:IMessageDataWrapper)
      {
         var _loc4_:int = 0;
         var _loc3_:RoomThumbnailObjectData = null;
         _objects = [];
         super();
         if(param1 == null)
         {
            return;
         }
         _bgImgId = param1.readInteger();
         _frontImgId = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = new RoomThumbnailObjectData();
            _loc3_.pos = param1.readInteger();
            _loc3_.imgId = param1.readInteger();
            _objects.push(_loc3_);
            _loc4_++;
         }
         if(_bgImgId == 0)
         {
            setDefaults();
         }
      }
      
      public function setDefaults() : void
      {
         _bgImgId = 1;
         _frontImgId = 0;
         var _loc1_:RoomThumbnailObjectData = new RoomThumbnailObjectData();
         _loc1_.pos = 4;
         _loc1_.imgId = 1;
         _objects.push(_loc1_);
      }
      
      public function getCopy() : RoomThumbnailData
      {
         var _loc1_:RoomThumbnailData = new RoomThumbnailData(null);
         _loc1_._bgImgId = this._bgImgId;
         _loc1_._frontImgId = this._frontImgId;
         for each(var _loc2_ in _objects)
         {
            _loc1_._objects.push(_loc2_.getCopy());
         }
         return _loc1_;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         this._objects = null;
      }
      
      public function getAsString() : String
      {
         var _loc1_:String = _frontImgId + ";";
         _loc1_ += _bgImgId + ";";
         for each(var _loc2_ in _objects)
         {
            _loc1_ += _loc2_.imgId + "," + _loc2_.pos + ";";
         }
         return _loc1_;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get bgImgId() : int
      {
         return _bgImgId;
      }
      
      public function get frontImgId() : int
      {
         return _frontImgId;
      }
      
      public function get objects() : Array
      {
         return _objects;
      }
      
      public function set bgImgId(param1:int) : void
      {
         _bgImgId = param1;
      }
      
      public function set frontImgId(param1:int) : void
      {
         _frontImgId = param1;
      }
   }
}

