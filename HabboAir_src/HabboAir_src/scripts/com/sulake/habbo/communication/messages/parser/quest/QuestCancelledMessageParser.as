package com.sulake.habbo.communication.messages.parser.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
   
   [SecureSWF(rename="true")]
   public class QuestCancelledMessageParser implements IMessageParser
   {
      private var _expired:Boolean;
      
      private var _quest:QuestMessageData;
      
      public function QuestCancelledMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _expired = param1.readBoolean();
         _quest = new QuestMessageData(param1);
         return true;
      }
      
      public function get expired() : Boolean
      {
         return _expired;
      }
      
      public function get quest() : QuestMessageData
      {
         return _quest;
      }
   }
}

