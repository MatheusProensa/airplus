package com.sulake.habbo.communication.messages.parser.game.score
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class LeaderboardEntry
   {
      private var _userId:int;
      
      private var _score:int;
      
      private var _rank:int;
      
      private var _name:String;
      
      private var _figure:String;
      
      private var _gender:String;
      
      public function LeaderboardEntry(param1:IMessageDataWrapper)
      {
         super();
         _userId = param1.readInteger();
         _score = param1.readInteger();
         _rank = param1.readInteger();
         _name = param1.readString();
         _figure = param1.readString();
         _gender = param1.readString();
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get score() : int
      {
         return _score;
      }
      
      public function get rank() : int
      {
         return _rank;
      }
      
      public function get figure() : String
      {
         return _figure;
      }
      
      public function get gender() : String
      {
         return _gender;
      }
      
      public function get name() : String
      {
         return _name;
      }
   }
}

