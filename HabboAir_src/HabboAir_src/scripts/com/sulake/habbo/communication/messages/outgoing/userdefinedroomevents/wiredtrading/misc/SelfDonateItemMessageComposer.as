package com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents.wiredtrading.misc
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class SelfDonateItemMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var _messageArray:Array;
      
      public function SelfDonateItemMessageComposer(param1:Boolean, param2:int, param3:String, param4:int)
      {
         super();
         _messageArray = [];
         _messageArray.push(param1);
         _messageArray.push(param2);
         _messageArray.push(param3 == null ? "" : param3);
         _messageArray.push(param4);
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

