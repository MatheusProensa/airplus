package com.sulake.bootstrap
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.habbo.discord.HabboDiscordManager;
   
   public class HabboDiscordManagerBootstrap extends HabboDiscordManager
   {
      public function HabboDiscordManagerBootstrap(param1:IComponent_2, param2:uint, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
      }
   }
}

