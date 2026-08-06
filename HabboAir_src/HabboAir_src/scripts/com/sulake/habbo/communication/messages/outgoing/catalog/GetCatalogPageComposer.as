package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetCatalogPageComposer implements IMessageComposer
   {
      private var _messageArray:Array;
      
      public function GetCatalogPageComposer(param1:int, param2:int, param3:String)
      {
         super();
         _messageArray = [param1,param2,param3];
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

