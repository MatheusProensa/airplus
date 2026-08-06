package com.sulake.habbo.communication.messages.outgoing.users
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetGuildEditorDataMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function GetGuildEditorDataMessageComposer()
      {
         super();
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

