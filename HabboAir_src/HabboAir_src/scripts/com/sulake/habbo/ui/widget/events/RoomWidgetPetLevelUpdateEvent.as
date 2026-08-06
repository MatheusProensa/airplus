package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetPetLevelUpdateEvent extends RoomWidgetUpdateEvent
   {
      public static const PET_LEVEL_UPDATE:String = "RWPLUE_PET_LEVEL_UPDATE";
      
      private var _petId:int;
      
      private var _level:int;
      
      public function RoomWidgetPetLevelUpdateEvent(param1:int, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         super("RWPLUE_PET_LEVEL_UPDATE",param3,param4);
         _petId = param1;
         _level = param2;
      }
      
      public function get petId() : int
      {
         return _petId;
      }
      
      public function get level() : int
      {
         return _level;
      }
   }
}

