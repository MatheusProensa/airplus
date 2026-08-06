package com.sulake.habbo.inventory.events
{
   import flash.events.Event;
   
   public class HabboInventoryFurniListParsedEvent extends Event
   {
      public static const UnknownConstFromHabboInventoryFurniListParsedEvent_String_1:String = "HFLPE_FURNI_LIST_PARSED";
      
      private var _category:String;
      
      public function HabboInventoryFurniListParsedEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super("HFLPE_FURNI_LIST_PARSED");
         _category = param1;
      }
      
      public function get category() : String
      {
         return _category;
      }
   }
}

