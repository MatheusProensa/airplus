package com.sulake.habbo.communication.messages.outgoing.help
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class GuideSessionOnDutyUpdateMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var _messageArray:Array = [];
      
      private var _disposed:Boolean = false;
      
      public function GuideSessionOnDutyUpdateMessageComposer(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean)
      {
         super();
         _messageArray = [param1,param2,param3,param4];
      }
      
      public function getMessageArray() : Array
      {
         return _messageArray;
      }
      
      public function dispose() : void
      {
         _messageArray = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

