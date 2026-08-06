package com.sulake.habbo.communication.messages.parser.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
   
   [SecureSWF(rename="true")]
   public class QuestMessageParser implements IMessageParser
   {
      private var _quest:QuestMessageData;
      
      public function QuestMessageParser()
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
         _quest = new QuestMessageData(param1);
         return true;
      }
      
      public function get quest() : QuestMessageData
      {
         return _quest;
      }
   }
}

