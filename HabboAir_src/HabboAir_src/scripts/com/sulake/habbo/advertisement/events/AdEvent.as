package com.sulake.habbo.advertisement.events
{
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class AdEvent extends Event
   {
      public static const ROOM_AD_IMAGE_LOADED:String = "AE_ROOM_AD_IMAGE_LOADED";
      
      public static const ROOM_AD_IMAGE_LOADING_FAILED:String = "AE_ROOM_AD_IMAGE_LOADING_FAILED";
      
      public static const ROOM_AD_SHOW:String = "AE_ROOM_AD_SHOW";
      
      private var _image:BitmapData;
      
      private var _roomId:int;
      
      private var _imageUrl:String;
      
      private var _clickUrl:String;
      
      private var _adWarningL:BitmapData;
      
      private var _adWarningR:BitmapData;
      
      private var _objectId:int;
      
      private var _objectCategory:int;
      
      public function AdEvent(param1:String, param2:int, param3:BitmapData = null, param4:String = "", param5:String = "", param6:BitmapData = null, param7:BitmapData = null, param8:int = -1, param9:int = -1, param10:Boolean = false, param11:Boolean = false)
      {
         super(param1,param10,param11);
         _image = param3;
         _roomId = param2;
         _imageUrl = param4;
         _clickUrl = param5;
         _adWarningL = param6;
         _adWarningR = param7;
         _objectId = param8;
         _objectCategory = param9;
      }
      
      public function get image() : BitmapData
      {
         return _image;
      }
      
      public function get roomId() : int
      {
         return _roomId;
      }
      
      public function get imageUrl() : String
      {
         return _imageUrl;
      }
      
      public function get clickUrl() : String
      {
         return _clickUrl;
      }
      
      public function get adWarningL() : BitmapData
      {
         return _adWarningL;
      }
      
      public function get adWarningR() : BitmapData
      {
         return _adWarningR;
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
      
      public function get objectCategory() : int
      {
         return _objectCategory;
      }
   }
}

