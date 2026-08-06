package com.sulake.habbo.communication.messages.outgoing.quest.dailytasks
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetDailyTasksComposer implements IMessageComposer
   {
      public function GetDailyTasksComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return [];
      }
      
      public function dispose() : void
      {
      }
   }
}

