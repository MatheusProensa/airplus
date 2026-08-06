package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SelectClubGiftComposer implements IMessageComposer
   {
      private var _productCode:String;
      
      public function SelectClubGiftComposer(param1:String)
      {
         super();
         _productCode = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [_productCode];
      }
      
      public function dispose() : void
      {
         _productCode = null;
      }
   }
}

