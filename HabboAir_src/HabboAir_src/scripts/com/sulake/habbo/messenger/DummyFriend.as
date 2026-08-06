package com.sulake.habbo.messenger
{
   import com.sulake.habbo.friendlist.UnknownIHabboFriendlist1;
   
   public class DummyFriend implements UnknownIHabboFriendlist1
   {
      private var _id:int;
      
      private var _userName:String;
      
      private var _figure:String;
      
      public function DummyFriend(param1:int, param2:String, param3:String)
      {
         super();
         _id = param1;
         _userName = param2;
         _figure = param3;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _userName;
      }
      
      public function get gender() : int
      {
         return 0;
      }
      
      public function get online() : Boolean
      {
         return true;
      }
      
      public function get followingAllowed() : Boolean
      {
         return true;
      }
      
      public function get figure() : String
      {
         return _figure;
      }
      
      public function get realName() : String
      {
         return "";
      }
      
      public function get persistedMessageUser() : Boolean
      {
         return true;
      }
      
      public function get pocketHabboUser() : Boolean
      {
         return false;
      }
      
      public function get relationshipStatus() : int
      {
         return 0;
      }
   }
}

