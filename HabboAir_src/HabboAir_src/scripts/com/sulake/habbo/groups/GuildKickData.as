package com.sulake.habbo.groups
{
   public class GuildKickData
   {
      private var _kickTargetId:int;
      
      private var _kickGuildId:int;
      
      private var _targetBlocked:Boolean;
      
      public function GuildKickData(param1:int, param2:int, param3:Boolean = false)
      {
         super();
         _kickTargetId = param1;
         _kickGuildId = param2;
         _targetBlocked = param3;
      }
      
      public function get kickTargetId() : int
      {
         return _kickTargetId;
      }
      
      public function get kickGuildId() : int
      {
         return _kickGuildId;
      }
      
      public function get targetBlocked() : Boolean
      {
         return _targetBlocked;
      }
   }
}

