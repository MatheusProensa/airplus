package com.sulake.habbo.communication.messages.parser.inventory.achievements
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class AchievementsScoreMessageParser implements IMessageParser
   {
      private var _score:int;
      
      public function AchievementsScoreMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _score = param1.readInteger();
         return true;
      }
      
      public function get score() : int
      {
         return _score;
      }
   }
}

