package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UserChangeMessageParser implements IMessageParser
   {
      private var _id:int;
      
      private var _figure:String;
      
      private var _sex:String;
      
      private var _customInfo:String;
      
      private var _achievementScore:int;
      
      private var _badgesRank:int = -1;
      
      public function UserChangeMessageParser()
      {
         super();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get figure() : String
      {
         return _figure;
      }
      
      public function get sex() : String
      {
         return _sex;
      }
      
      public function get customInfo() : String
      {
         return _customInfo;
      }
      
      public function get achievementScore() : int
      {
         return _achievementScore;
      }
      
      public function get badgesRank() : int
      {
         return _badgesRank;
      }
      
      public function flush() : Boolean
      {
         _id = 0;
         _figure = "";
         _sex = "";
         _customInfo = "";
         _badgesRank = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         _id = param1.readInteger();
         _figure = param1.readString();
         _sex = param1.readString();
         _customInfo = param1.readString();
         _achievementScore = param1.readInteger();
         param1.readString();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            param1.readInteger();
            param1.readInteger();
            param1.readInteger();
            _loc3_++;
         }
         _badgesRank = param1.readInteger();
         if(_sex)
         {
            _sex = _sex.toUpperCase();
         }
         return true;
      }
   }
}

