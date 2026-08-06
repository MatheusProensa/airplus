package com.sulake.habbo.communication.messages.outgoing.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SilverFeeMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function SilverFeeMessageComposer(param1:Boolean)
      {
         super();
         _messageArray.push(param1);
      }
      
      public function dispose() : void
      {
         _messageArray = null;
      }
      
      public function getMessageArray() : Array
      {
         return _messageArray;
      }
   }
}

