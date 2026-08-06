package com.sulake.habbo.notifications
{
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.utils.Map;
   import flash.display.BitmapData;
   
   public interface IHabboNotifications extends IUnknown
   {
      function addItem(param1:String, param2:String, param3:String = null, param4:String = null, param5:Object = null) : void;
      
      function addItemWithBitmap(param1:String, param2:String, param3:BitmapData = null, param4:String = null, param5:Object = null) : void;
      
      function removeNotificationById(param1:String) : void;
      
      function showNotification(param1:String, param2:Map = null) : void;
      
      function addSongPlayingNotification(param1:String, param2:String) : void;
   }
}

