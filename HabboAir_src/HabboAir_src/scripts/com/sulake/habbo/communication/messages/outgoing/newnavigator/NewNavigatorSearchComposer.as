package com.sulake.habbo.communication.messages.outgoing.newnavigator
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class NewNavigatorSearchComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function NewNavigatorSearchComposer(param1:String, param2:String)
      {
         super();
         _messageArray.push(param1);
         _messageArray.push(param2);
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

