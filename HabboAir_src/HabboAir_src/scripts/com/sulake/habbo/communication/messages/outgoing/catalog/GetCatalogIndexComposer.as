package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetCatalogIndexComposer implements IMessageComposer
   {
      private var _messageArray:Array;
      
      public function GetCatalogIndexComposer(param1:String)
      {
         super();
         _messageArray = [param1];
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

