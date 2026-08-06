package com.sulake.habbo.communication.messages.outgoing.customfilter
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class AddToCustomFilterMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function AddToCustomFilterMessageComposer(param1:String)
      {
         super();
         _messageArray.push(param1);
      }
      
      public function getMessageArray() : Array
      {
         return _messageArray;
      }
      
      public function dispose() : void
      {
         _messageArray = [];
      }
   }
}

