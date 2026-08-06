package com.sulake.habbo.catalog.viewer.widgets.events
{
   import flash.events.Event;
   
   public class CatalogWidgetGuildSelectedEvent extends Event
   {
      public static const NO_GUILD_SELECTED:int = -1;
      
      private var _guildId:int;
      
      private var _color1:String;
      
      private var _color2:String;
      
      private var _badgeCode:String;
      
      public function CatalogWidgetGuildSelectedEvent(param1:int, param2:String, param3:String, param4:String)
      {
         _guildId = param1;
         _color1 = param2;
         _color2 = param3;
         _badgeCode = param4;
         super("GUILD_SELECTED");
      }
      
      public function get guildId() : int
      {
         return _guildId;
      }
      
      public function get color1() : String
      {
         return _color1;
      }
      
      public function get color2() : String
      {
         return _color2;
      }
      
      public function get badgeCode() : String
      {
         return _badgeCode;
      }
   }
}

