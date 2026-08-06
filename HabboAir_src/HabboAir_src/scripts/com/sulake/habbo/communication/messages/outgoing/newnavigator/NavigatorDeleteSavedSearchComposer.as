package com.sulake.habbo.communication.messages.outgoing.newnavigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class NavigatorDeleteSavedSearchComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function NavigatorDeleteSavedSearchComposer(param1:int)
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
         _messageArray = null;
      }
   }
}

