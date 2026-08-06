package com.sulake.bootstrap
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.habbo.messenger.HabboMessenger;
   
   public class HabboMessengerBootstrap extends HabboMessenger
   {
      public function HabboMessengerBootstrap(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
      }
   }
}

