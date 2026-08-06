package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetStoreSettingsMessage extends RoomWidgetMessage
   {
      public static const STORE_ALL_SETTINGS:String = "RWSSM_STORE_SETTINGS";
      
      public static const STORE_SOUND_SETTING:String = "RWSSM_STORE_SOUND";
      
      public static const PREVIEW_SOUND_SETTING:String = "RWSSM_PREVIEW_SOUND";
      
      private var _traxVolume:Number;
      
      private var _furniVolume:Number;
      
      private var _genericVolume:Number;
      
      public function RoomWidgetStoreSettingsMessage(param1:String)
      {
         super(param1);
      }
      
      public function get traxVolume() : Number
      {
         return _traxVolume;
      }
      
      public function set traxVolume(param1:Number) : void
      {
         _traxVolume = param1;
      }
      
      public function get furniVolume() : Number
      {
         return _furniVolume;
      }
      
      public function set furniVolume(param1:Number) : void
      {
         _furniVolume = param1;
      }
      
      public function get genericVolume() : Number
      {
         return _genericVolume;
      }
      
      public function set genericVolume(param1:Number) : void
      {
         _genericVolume = param1;
      }
   }
}

