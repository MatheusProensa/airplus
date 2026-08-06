package com.sulake.habbo.communication.messages.outgoing.habbicons
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class UnknownHabbiconMessageEvent implements IMessageComposer
   {
      public function UnknownHabbiconMessageEvent()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return [];
      }
      
      public function dispose() : void
      {
      }
   }
}

