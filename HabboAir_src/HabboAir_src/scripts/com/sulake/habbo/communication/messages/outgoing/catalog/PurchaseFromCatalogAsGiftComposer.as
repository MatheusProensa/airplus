package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PurchaseFromCatalogAsGiftComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function PurchaseFromCatalogAsGiftComposer(param1:int, param2:int, param3:String, param4:String, param5:String, param6:int, param7:int, param8:int, param9:Boolean)
      {
         super();
         _messageArray.push(param1);
         _messageArray.push(param2);
         _messageArray.push(param3);
         _messageArray.push(param4);
         _messageArray.push(param5);
         _messageArray.push(param6);
         _messageArray.push(param7);
         _messageArray.push(param8);
         _messageArray.push(param9);
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

