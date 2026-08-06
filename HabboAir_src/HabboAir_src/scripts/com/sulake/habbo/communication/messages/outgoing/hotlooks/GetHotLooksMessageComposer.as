package com.sulake.habbo.communication.messages.outgoing.hotlooks
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.util.Byte;
   
   [SecureSWF(rename="true")]
   public class GetHotLooksMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function GetHotLooksMessageComposer(param1:int)
      {
         super();
         _messageArray.push(new Byte(param1));
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

