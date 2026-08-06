package com.sulake.habbo.communication.messages.outgoing.poll
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PollRejectComposer implements IMessageComposer
   {
      private var _messageArray:Array = null;
      
      public function PollRejectComposer(param1:int)
      {
         super();
         _messageArray = [param1];
      }
      
      public function getMessageArray() : Array
      {
         return _messageArray;
      }
      
      public function dispose() : void
      {
         _messageArray = null;
      }
   }
}

