package com.sulake.habbo.communication.messages.outgoing.preferences
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class SetNewNavigatorWindowPreferencesMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var _messageArray:Array = [];
      
      public function SetNewNavigatorWindowPreferencesMessageComposer(param1:int, param2:int, param3:int, param4:int, param5:Boolean, param6:int)
      {
         super();
         _messageArray.push(param1);
         _messageArray.push(param2);
         _messageArray.push(param3);
         _messageArray.push(param4);
         _messageArray.push(param5);
         _messageArray.push(param6);
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

