package com.sulake.habbo.ui.widget.furniture.trophy
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public interface ITrophyFurniWidget
   {
      function get assets() : IAssetLibraryCollection;
      
      function get name() : String;
      
      function get date() : String;
      
      function get color() : int;
      
      function get frameTitle() : String;
      
      function get headerColor() : uint;
      
      function get backgroundTheme() : int;
      
      function get windowManager() : IHabboWindowManagerComponent;
      
      function get message() : String;
   }
}

