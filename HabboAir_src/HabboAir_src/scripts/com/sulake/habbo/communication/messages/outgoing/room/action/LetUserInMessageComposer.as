package com.sulake.habbo.communication.messages.outgoing.room.action
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class LetUserInMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array;
      
      public function LetUserInMessageComposer(param1:String, param2:Boolean)
      {
         super();
         _messageArray = [param1,param2];
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

