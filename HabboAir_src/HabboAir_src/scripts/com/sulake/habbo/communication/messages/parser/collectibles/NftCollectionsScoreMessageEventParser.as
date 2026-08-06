package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class NftCollectionsScoreMessageEventParser implements IMessageParser
   {
      private var _score:int;
      
      private var _highestScore:int;
      
      private var _level:int;
      
      public function NftCollectionsScoreMessageEventParser()
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
         _highestScore = param1.readInteger();
         _level = param1.readInteger();
         return true;
      }
      
      public function get score() : int
      {
         return _score;
      }
      
      public function get highestScore() : int
      {
         return _highestScore;
      }
      
      public function get level() : int
      {
         return _level;
      }
   }
}

