package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PetMessageComposer implements IMessageComposer
   {
      protected var _messageArray:Array = [];
      
      public function PetMessageComposer(param1:int)
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
      }
   }
}

