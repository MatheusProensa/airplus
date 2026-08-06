package com.sulake.habbo.quest.events
{
   import com.sulake.habbo.communication.messages.incoming.quest.QuestMessageData;
   import flash.events.Event;
   
   public class QuestCompletedEvent extends Event
   {
      public static const QUEST_SEASONAL:String = "qce_seasonal";
      
      private var _questData:QuestMessageData;
      
      public function QuestCompletedEvent(param1:String, param2:QuestMessageData, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _questData = param2;
      }
      
      public function get questData() : QuestMessageData
      {
         return _questData;
      }
   }
}

