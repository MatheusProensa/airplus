package com.sulake.room.renderer.utils
{
   [SecureSWF(rename="true")]
   public class ObjectMouseData
   {
      private var _objectId:String = "";
      
      private var _spriteTag:String = "";
      
      public function ObjectMouseData()
      {
         super();
      }
      
      public function get objectId() : String
      {
         return _objectId;
      }
      
      public function set objectId(param1:String) : void
      {
         _objectId = param1;
      }
      
      public function get spriteTag() : String
      {
         return _spriteTag;
      }
      
      public function set spriteTag(param1:String) : void
      {
         _spriteTag = param1;
      }
   }
}

