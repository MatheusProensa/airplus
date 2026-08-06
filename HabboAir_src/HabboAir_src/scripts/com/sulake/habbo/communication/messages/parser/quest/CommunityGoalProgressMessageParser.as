package com.sulake.habbo.communication.messages.parser.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.quest.CommunityGoalData;
   
   [SecureSWF(rename="true")]
   public class CommunityGoalProgressMessageParser implements IMessageParser
   {
      private var _data:CommunityGoalData;
      
      public function CommunityGoalProgressMessageParser()
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
         _data = new CommunityGoalData(param1);
         return true;
      }
      
      public function get data() : CommunityGoalData
      {
         return _data;
      }
   }
}

