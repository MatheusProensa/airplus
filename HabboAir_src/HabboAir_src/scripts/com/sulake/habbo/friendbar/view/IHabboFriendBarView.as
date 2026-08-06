package com.sulake.habbo.friendbar.view
{
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.friendbar.view.tabs.ITab;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   
   public interface IHabboFriendBarView extends IUnknown
   {
      function get events() : IEventDispatcher;
      
      function set visible(param1:Boolean) : void;
      
      function get visible() : Boolean;
      
      function selectTab(param1:ITab, param2:Boolean) : void;
      
      function deSelect(param1:Boolean) : void;
      
      function getAvatarFaceBitmap(param1:String) : BitmapData;
      
      function getGroupIconBitmap(param1:String) : BitmapData;
      
      function setMessengerIconNotify(param1:Boolean) : void;
      
      function setFriendListIconNotify(param1:Boolean) : void;
      
      function removeMessengerNotifications() : void;
      
      function get friendBarWidth() : int;
      
      function getIconLocation(param1:String) : IWindowController_1;
   }
}

