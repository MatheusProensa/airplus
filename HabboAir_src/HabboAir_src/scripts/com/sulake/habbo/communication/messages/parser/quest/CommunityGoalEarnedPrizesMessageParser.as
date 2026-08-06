package com.sulake.habbo.communication.messages.parser.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.quest.PrizeData;
   
   [SecureSWF(rename="true")]
   public class CommunityGoalEarnedPrizesMessageParser implements IMessageParser
   {
      private var _prizes:Array;
      
      public function CommunityGoalEarnedPrizesMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _prizes = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _prizes.push(new PrizeData(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get prizes() : Array
      {
         return _prizes;
      }
   }
}

