package com.sulake.habbo.groups
{
   import com.sulake.habbo.communication.messages.incoming.users.IGuildEditData;
   
   public class GuildSettingsData
   {
      private var _guildType:int = 0;
      
      private var _rightsLevel:int = 0;
      
      private var _isModified:Boolean = false;
      
      public function GuildSettingsData(param1:IGuildEditData = null)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         _guildType = param1.guildType;
         _rightsLevel = param1.guildRightsLevel;
      }
      
      public function get guildType() : int
      {
         return _guildType;
      }
      
      public function set guildType(param1:int) : void
      {
         if(param1 != _guildType)
         {
            _isModified = true;
         }
         _guildType = param1;
      }
      
      public function get rightsLevel() : int
      {
         return _rightsLevel;
      }
      
      public function set rightsLevel(param1:int) : void
      {
         if(param1 != _rightsLevel)
         {
            _isModified = true;
         }
         _rightsLevel = param1;
      }
      
      public function get isModified() : Boolean
      {
         return _isModified;
      }
      
      public function resetModified() : void
      {
         _isModified = false;
      }
   }
}

