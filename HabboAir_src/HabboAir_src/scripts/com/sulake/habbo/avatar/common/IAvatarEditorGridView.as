package com.sulake.habbo.avatar.common
{
   import com.sulake.core.window.IWindowController_1;
   
   public interface IAvatarEditorGridView
   {
      function dispose() : void;
      
      function get window() : IWindowController_1;
      
      function initFromList(param1:ICategoryBaseModel_1, param2:String) : void;
      
      function showPalettes(param1:int) : void;
   }
}

