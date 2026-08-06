package com.sulake.habbo.ui.widget.contextmenu
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.friendlist.IHabboFriendList;
   import com.sulake.habbo.ui.widget.IRoomWidgetMessageListener;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public interface UnknownIHabboUiWidgetContextmenu1
   {
      function get assets() : IAssetLibraryCollection;
      
      function get windowManager() : IHabboWindowManagerComponent;
      
      function get messageListener() : IRoomWidgetMessageListener;
      
      function get catalog() : IHabboCatalog;
      
      function get friendList() : IHabboFriendList;
      
      function removeView(param1:ContextInfoView, param2:Boolean) : void;
   }
}

