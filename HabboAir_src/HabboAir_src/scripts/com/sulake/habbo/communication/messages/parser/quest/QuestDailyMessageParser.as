package com.sulake.habbo.communication.messages.parser.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
   
   [SecureSWF(rename="true")]
   public class QuestDailyMessageParser implements IMessageParser
   {
      private var _quest:QuestMessageData;
      
      private var _easyQuestCount:int;
      
      private var _hardQuestCount:int;
      
      public function QuestDailyMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _quest = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:Boolean = param1.readBoolean();
         if(_loc2_)
         {
            _quest = new QuestMessageData(param1);
            _easyQuestCount = param1.readInteger();
            _hardQuestCount = param1.readInteger();
         }
         return true;
      }
      
      public function get quest() : QuestMessageData
      {
         return _quest;
      }
      
      public function get easyQuestCount() : int
      {
         return _easyQuestCount;
      }
      
      public function get hardQuestCount() : int
      {
         return _hardQuestCount;
      }
   }
}

