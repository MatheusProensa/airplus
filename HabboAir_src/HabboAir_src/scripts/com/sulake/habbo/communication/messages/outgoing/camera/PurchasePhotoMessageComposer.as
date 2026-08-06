package com.sulake.habbo.communication.messages.outgoing.camera
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PurchasePhotoMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function PurchasePhotoMessageComposer()
      {
         super();
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

