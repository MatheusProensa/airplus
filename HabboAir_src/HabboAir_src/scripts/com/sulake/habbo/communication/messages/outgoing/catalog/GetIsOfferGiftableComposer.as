package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetIsOfferGiftableComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function GetIsOfferGiftableComposer(param1:int)
      {
         super();
         _messageArray.push(param1);
      }
      
      public function dispose() : void
      {
         _messageArray = [];
      }
      
      public function getMessageArray() : Array
      {
         return _messageArray;
      }
   }
}

