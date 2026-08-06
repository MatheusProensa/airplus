package com.sulake.habbo.communication.messages.parser.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalHallOfFame;
   
   [SecureSWF(rename="true")]
   public class CommunityGoalHallOfFameMessageParser implements IMessageParser
   {
      private var _data:CommunityGoalHallOfFame;
      
      public function CommunityGoalHallOfFameMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _data = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _data = new CommunityGoalHallOfFame(param1);
         return true;
      }
      
      public function get data() : CommunityGoalHallOfFame
      {
         return _data;
      }
   }
}

