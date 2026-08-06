package com.sulake.habbo.navigator.roomsettings
{
   import com.sulake.habbo.communication.messages.incoming.roomsettings.IBannedUserData;
   
   public class FriendEntryData implements IBannedUserData
   {
      private var _userId:int;
      
      private var _userName:String;
      
      public function FriendEntryData(param1:int, param2:String)
      {
         super();
         _userId = param1;
         _userName = param2;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
   }
}

