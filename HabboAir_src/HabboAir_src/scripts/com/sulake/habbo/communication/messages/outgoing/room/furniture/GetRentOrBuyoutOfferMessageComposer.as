package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetRentOrBuyoutOfferMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array;
      
      public function GetRentOrBuyoutOfferMessageComposer(param1:Boolean, param2:String, param3:Boolean)
      {
         super();
         _messageArray = [param1,param2,param3];
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

