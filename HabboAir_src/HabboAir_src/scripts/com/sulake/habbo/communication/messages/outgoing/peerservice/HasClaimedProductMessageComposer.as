package com.sulake.habbo.communication.messages.outgoing.peerservice
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class HasClaimedProductMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var _messageArray:Array;
      
      public function HasClaimedProductMessageComposer(param1:String)
      {
         super();
         _messageArray = [];
         _messageArray.push(param1);
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

