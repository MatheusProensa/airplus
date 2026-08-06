package com.sulake.habbo.friendbar.data
{
   public class FriendRequest implements IFriendRequest
   {
      private var _id:int;
      
      private var _name:String;
      
      private var _figure:String;
      
      public function FriendRequest(param1:int, param2:String, param3:String)
      {
         super();
         _id = param1;
         _name = param2;
         _figure = param3;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get figure() : String
      {
         return _figure;
      }
   }
}

