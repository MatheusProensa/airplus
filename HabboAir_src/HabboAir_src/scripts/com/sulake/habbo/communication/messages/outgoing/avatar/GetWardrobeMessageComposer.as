package com.sulake.habbo.communication.messages.outgoing.avatar
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetWardrobeMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function GetWardrobeMessageComposer()
      {
         super();
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

