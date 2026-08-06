package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ExtendRentOrBuyoutFurniMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array;
      
      public function ExtendRentOrBuyoutFurniMessageComposer(param1:Boolean, param2:int, param3:Boolean)
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

