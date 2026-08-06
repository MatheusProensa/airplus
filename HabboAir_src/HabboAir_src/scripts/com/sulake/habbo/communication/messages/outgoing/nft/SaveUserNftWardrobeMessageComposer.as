package com.sulake.habbo.communication.messages.outgoing.nft
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class SaveUserNftWardrobeMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function SaveUserNftWardrobeMessageComposer(param1:String)
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
         this._messageArray = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

