package com.sulake.habbo.session.events
{
   import flash.display.BitmapData;
   import flash.events.Event;
   
   public class BadgeImageReadyEvent extends Event
   {
      public static const BADGE_READY:String = "BIRE_BADGE_IMAGE_READY";
      
      private var _badgeId:String;
      
      private var _badgeImage:BitmapData;
      
      public function BadgeImageReadyEvent(param1:String, param2:BitmapData, param3:Boolean = false, param4:Boolean = false)
      {
         super("BIRE_BADGE_IMAGE_READY",param3,param4);
         _badgeId = param1;
         _badgeImage = param2;
      }
      
      public function get badgeId() : String
      {
         return _badgeId;
      }
      
      public function get badgeImage() : BitmapData
      {
         return _badgeImage;
      }
   }
}

