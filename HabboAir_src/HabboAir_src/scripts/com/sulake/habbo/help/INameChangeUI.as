package com.sulake.habbo.help
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   
   public interface INameChangeUI
   {
      function get localization() : IHabboLocalizationManager;
      
      function get assets() : IAssetLibraryCollection;
      
      function get myName() : String;
      
      function buildXmlWindow(param1:String, param2:uint = 1) : IWindowModel;
      
      function checkName(param1:String) : void;
      
      function changeName(param1:String) : void;
      
      function showView() : void;
      
      function hideView() : void;
   }
}

