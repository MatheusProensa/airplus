package com.sulake.habbo.window.widgets
{
   import com.sulake.core.window.IWindowController_2;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils4;
   
   public interface IBadgeImageWidget extends IWindowController_2, UnknownICoreWindowUtils4
   {
      function get type() : String;
      
      function set type(param1:String) : void;
      
      function get badgeId() : String;
      
      function set badgeId(param1:String) : void;
      
      function get groupId() : int;
      
      function set groupId(param1:int) : void;
      
      function get glowColor() : int;
      
      function set glowColor(param1:int) : void;
      
      function playGlow(param1:uint, param2:int = 500, param3:Number = 1.04) : void;
      
      function clearGlow() : void;
      
      function refresh() : void;
   }
}

