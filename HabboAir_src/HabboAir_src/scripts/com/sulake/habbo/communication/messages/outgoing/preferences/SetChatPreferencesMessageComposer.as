package com.sulake.habbo.communication.messages.outgoing.preferences
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class SetChatPreferencesMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var _messageArray:Array = [];
      
      public function SetChatPreferencesMessageComposer(param1:int, param2:int, param3:int)
      {
         super();
         _messageArray.push(false);
         _messageArray.push(param1);
         _messageArray.push(param2);
         _messageArray.push(param3);
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
         return _messageArray == null;
      }
   }
}

