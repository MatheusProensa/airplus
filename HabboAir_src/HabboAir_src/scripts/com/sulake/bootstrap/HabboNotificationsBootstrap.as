package com.sulake.bootstrap
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.habbo.notifications.HabboNotifications;
   
   public class HabboNotificationsBootstrap extends HabboNotifications
   {
      public function HabboNotificationsBootstrap(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
      }
   }
}

