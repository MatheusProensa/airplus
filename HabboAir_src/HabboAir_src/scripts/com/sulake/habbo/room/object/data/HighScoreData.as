package com.sulake.habbo.room.object.data
{
   public class HighScoreData
   {
      private var _score:int;
      
      private var _users:Array = [];
      
      public function HighScoreData()
      {
         super();
         _score = -1;
      }
      
      public function get score() : int
      {
         return _score;
      }
      
      public function set score(param1:int) : void
      {
         _score = param1;
      }
      
      public function get users() : Array
      {
         return _users;
      }
      
      public function set users(param1:Array) : void
      {
         _users = param1;
      }
      
      public function addUser(param1:String) : void
      {
         _users.push(param1);
      }
   }
}

