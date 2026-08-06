package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionPetLevelUpdateEvent extends RoomSessionEvent
   {
      public static const PET_LEVEL_UPDATE:String = "RSPLUE_PET_LEVEL_UPDATE";
      
      private var _petId:int;
      
      private var _level:int;
      
      public function RoomSessionPetLevelUpdateEvent(param1:IRoomSession, param2:int, param3:int, param4:Boolean = false, param5:Boolean = false)
      {
         super("RSPLUE_PET_LEVEL_UPDATE",param1,param4,param5);
         _petId = param2;
         _level = param3;
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

