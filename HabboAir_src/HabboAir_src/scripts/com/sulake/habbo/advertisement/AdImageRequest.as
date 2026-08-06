package com.sulake.habbo.advertisement
{
   public class AdImageRequest
   {
      private var _roomId:int;
      
      private var _objectId:int;
      
      private var _objectCategory:int;
      
      private var _imageURL:String;
      
      private var _clickURL:String;
      
      public function AdImageRequest(param1:int, param2:String = null, param3:String = null, param4:int = -1, param5:int = -1)
      {
         super();
         _roomId = param1;
         _objectId = param4;
         _objectCategory = param5;
         _imageURL = param2;
         _clickURL = param3;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
      
      public function get objectCategory() : int
      {
         return _objectCategory;
      }
      
      public function get imageURL() : String
      {
         return _imageURL;
      }
      
      public function get clickURL() : String
      {
         return _clickURL;
      }
   }
}

