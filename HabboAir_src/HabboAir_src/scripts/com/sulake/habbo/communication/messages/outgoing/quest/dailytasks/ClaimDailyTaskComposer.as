package com.sulake.habbo.communication.messages.outgoing.quest.dailytasks
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ClaimDailyTaskComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function ClaimDailyTaskComposer(param1:int)
      {
         super();
         _messageArray.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return _messageArray;
      }
      
      public function dispose() : void
      {
         _messageArray = [];
      }
   }
}

