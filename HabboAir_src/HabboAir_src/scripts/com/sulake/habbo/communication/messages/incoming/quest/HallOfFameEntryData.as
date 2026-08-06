package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class HallOfFameEntryData implements IHallOfFameEntryData
   {
      private var _userId:int;
      
      private var _userName:String;
      
      private var _figure:String;
      
      private var _rank:int;
      
      private var _currentScore:int;
      
      public function HallOfFameEntryData(param1:IMessageDataWrapper)
      {
         super();
         _userId = param1.readInteger();
         _userName = param1.readString();
         _figure = param1.readString();
         _rank = param1.readInteger();
         _currentScore = param1.readInteger();
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get figure() : String
      {
         return _figure;
      }
      
      public function get rank() : int
      {
         return _rank;
      }
      
      public function get currentScore() : int
      {
         return _currentScore;
      }
   }
}

