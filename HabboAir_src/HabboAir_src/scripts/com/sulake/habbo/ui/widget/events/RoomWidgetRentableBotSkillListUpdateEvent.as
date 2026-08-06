package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetRentableBotSkillListUpdateEvent extends RoomWidgetUpdateEvent
   {
      public static const SKILL_LIST:String = "RWRBSLUE_SKILL_LIST";
      
      private var _botId:int;
      
      private var _botSkillsWithCommands:Array;
      
      public function RoomWidgetRentableBotSkillListUpdateEvent(param1:int, param2:Array, param3:Boolean = false, param4:Boolean = false)
      {
         super("RWRBSLUE_SKILL_LIST",param3,param4);
         _botId = param1;
         _botSkillsWithCommands = param2;
      }
      
      public function get botSkillsWithCommands() : Array
      {
         return _botSkillsWithCommands;
      }
      
      public function get botId() : int
      {
         return _botId;
      }
   }
}

