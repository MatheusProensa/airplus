package com.sulake.habbo.communication.messages.outgoing.notifications
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class ResetUnseenItemIdsComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var _messageArray:Array = [];
      
      public function ResetUnseenItemIdsComposer(param1:int, param2:Array)
      {
         super();
         _messageArray.push(param1);
         _messageArray.push(param2.length);
         _messageArray = _messageArray.concat(param2);
      }
      
      public function getMessageArray() : Array
      {
         return _messageArray;
      }
      
      public function dispose() : void
      {
         _messageArray = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

