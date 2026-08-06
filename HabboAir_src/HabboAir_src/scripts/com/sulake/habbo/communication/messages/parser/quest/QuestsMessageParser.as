package com.sulake.habbo.communication.messages.parser.quest
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
   
   [SecureSWF(rename="true")]
   public class QuestsMessageParser implements IMessageParser
   {
      private var _quests:Array;
      
      private var _openWindow:Boolean;
      
      public function QuestsMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _quests = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _quests.push(new QuestMessageData(param1));
            _loc3_++;
         }
         _openWindow = param1.readBoolean();
         return true;
      }
      
      public function get quests() : Array
      {
         return _quests;
      }
      
      public function get openWindow() : Boolean
      {
         return _openWindow;
      }
   }
}

