package com.sulake.habbo.communication.messages.outgoing.advertisement
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class InterstitialShownMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function InterstitialShownMessageComposer()
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

