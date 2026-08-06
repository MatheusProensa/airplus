package com.sulake.habbo.communication.messages.outgoing.avatar
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SaveWardrobeOutfitMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function SaveWardrobeOutfitMessageComposer(param1:int, param2:String, param3:String)
      {
         super();
         _messageArray.push(param1);
         _messageArray.push(param2);
         _messageArray.push(param3);
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

