package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   public class TeleportToRoom extends DefaultActionType
   {
      public function TeleportToRoom()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.TELEPORT_TO_ROOM;
      }
   }
}

