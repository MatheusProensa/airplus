package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class RentableSpaceStatusMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array;
      
      public function RentableSpaceStatusMessageComposer(param1:int)
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

