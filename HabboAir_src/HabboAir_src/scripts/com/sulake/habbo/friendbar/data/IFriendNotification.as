package com.sulake.habbo.friendbar.data
{
   public interface IFriendNotification
   {
      function get typeCode() : int;
      
      function set typeCode(param1:int) : void;
      
      function get message() : String;
      
      function set message(param1:String) : void;
      
      function get viewOnce() : Boolean;
      
      function set viewOnce(param1:Boolean) : void;
   }
}

