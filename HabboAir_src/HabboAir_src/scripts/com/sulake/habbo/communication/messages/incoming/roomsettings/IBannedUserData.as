package com.sulake.habbo.communication.messages.incoming.roomsettings
{
   public interface IBannedUserData
   {
      function get userId() : int;
      
      function get userName() : String;
   }
}

