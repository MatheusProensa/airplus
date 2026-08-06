package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionPetCommandsUpdateEvent extends RoomSessionEvent
   {
      public static const PET_COMMANDS:String = "RSPIUE_ENABLED_PET_COMMANDS";
      
      private var _petId:int;
      
      private var _allCommands:Array;
      
      private var _enabledCommands:Array;
      
      public function RoomSessionPetCommandsUpdateEvent(param1:IRoomSession, param2:int, param3:Array, param4:Array, param5:Boolean = false, param6:Boolean = false)
      {
         super("RSPIUE_ENABLED_PET_COMMANDS",param1,param5,param6);
         _petId = param2;
         _allCommands = param3;
         _enabledCommands = param4;
      }
      
      public function get petId() : int
      {
         return _petId;
      }
      
      public function get allCommands() : Array
      {
         return _allCommands;
      }
      
      public function get enabledCommands() : Array
      {
         return _enabledCommands;
      }
   }
}

