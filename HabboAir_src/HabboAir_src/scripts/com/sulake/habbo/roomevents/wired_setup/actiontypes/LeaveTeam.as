package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   public class LeaveTeam extends DefaultActionType
   {
      public function LeaveTeam()
      {
         super();
      }
      
      override public function get code() : int
      {
         return ActionTypeCodes.LEAVE_TEAM;
      }
   }
}

