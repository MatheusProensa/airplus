package com.sulake.habbo.communication.messages.outgoing.avatar
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ChangeUserNameMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array;
      
      public function ChangeUserNameMessageComposer(param1:String)
      {
         super();
         _messageArray = [];
         _messageArray.push(param1);
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

