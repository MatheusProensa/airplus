package com.sulake.habbo.communication.messages.outgoing.camera
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PublishPhotoMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function PublishPhotoMessageComposer()
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

