package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SetTargetedOfferStateComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function SetTargetedOfferStateComposer(param1:int, param2:int)
      {
         super();
         _messageArray.push(param1);
         _messageArray.push(param2);
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

