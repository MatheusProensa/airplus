package com.sulake.habbo.communication.messages.outgoing.help
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class GuideSessionMessageMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var _messageArray:Array = [];
      
      private var _disposed:Boolean = false;
      
      public function GuideSessionMessageMessageComposer(param1:String)
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
         _messageArray = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

