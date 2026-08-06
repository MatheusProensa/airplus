package com.sulake.habbo.communication.messages.outgoing.discord
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class SetDiscordPreferencesMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var _messageArray:Array = [];
      
      public function SetDiscordPreferencesMessageComposer(param1:int, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean)
      {
         super();
         _messageArray.push(param1);
         _messageArray.push(param2);
         _messageArray.push(param3);
         _messageArray.push(param4);
         _messageArray.push(param5);
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

