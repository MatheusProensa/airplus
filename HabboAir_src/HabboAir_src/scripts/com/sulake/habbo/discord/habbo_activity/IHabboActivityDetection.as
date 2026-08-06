package com.sulake.habbo.discord.habbo_activity
{
   public interface IHabboActivityDetection
   {
      function isInRoom() : Boolean;
      
      function isInHiddenRoom() : Boolean;
      
      function get roomId() : int;
      
      function getCurrentRoomActivity() : HabboActivityState;
      
      function getCurrentRoomName() : String;
   }
}

