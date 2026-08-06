package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PurchaseRoomAdMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function PurchaseRoomAdMessageComposer(param1:int, param2:int, param3:int, param4:String, param5:Boolean, param6:String, param7:int)
      {
         super();
         _messageArray.push(param1);
         _messageArray.push(param2);
         _messageArray.push(param3);
         _messageArray.push(param4);
         _messageArray.push(param5);
         _messageArray.push(param6);
         _messageArray.push(param7);
      }
      
      public function getMessageArray() : Array
      {
         return _messageArray;
      }
      
      public function dispose() : void
      {
      }
   }
}

