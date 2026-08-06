package com.sulake.habbo.catalog.collectibles
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.room.UnknownHabboRoom1;
   import com.sulake.habbo.room.UnknownIHabboRoom1;
   
   public interface UnknownIHabboCatalogCollectibles1 extends UnknownIHabboRoom1, IComponentInterfaceQueue
   {
      function clearPreviewer() : void;
      
      function set imageResult(param1:UnknownHabboRoom1) : void;
      
      function set avatarResult(param1:String) : void;
      
      function set badgeResult(param1:String) : void;
      
      function set petResult(param1:String) : void;
      
      function setEffectResult(param1:String, param2:int) : void;
      
      function setUnknownImage() : void;
   }
}

