package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class BadgeLeaderboardEntryData
   {
      private var _userId:int;
      
      private var _userName:String;
      
      private var _figureString:String;
      
      private var _rank:int;
      
      private var _score:int;
      
      public function BadgeLeaderboardEntryData(param1:IMessageDataWrapper)
      {
         super();
         _userId = param1.readInteger();
         _userName = param1.readString();
         _figureString = param1.readString();
         _rank = param1.readInteger();
         _score = param1.readInteger();
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get figureString() : String
      {
         return _figureString;
      }
      
      public function get rank() : int
      {
         return _rank;
      }
      
      public function get score() : int
      {
         return _score;
      }
   }
}

