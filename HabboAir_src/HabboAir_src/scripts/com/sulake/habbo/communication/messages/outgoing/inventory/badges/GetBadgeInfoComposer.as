package com.sulake.habbo.communication.messages.outgoing.inventory.badges
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetBadgeInfoComposer implements IMessageComposer
   {
      private var _messageArray:Array;
      
      public function GetBadgeInfoComposer(param1:String)
      {
         super();
         _messageArray = [param1];
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

