package com.sulake.habbo.avatar.common
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   
   public interface ISideContentModel
   {
      function dispose() : void;
      
      function reset() : void;
      
      function get controller() : HabboAvatarEditor;
      
      function getWindowContainer() : IWindowController_1;
   }
}

