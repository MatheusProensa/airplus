package com.sulake.habbo.communication.messages.outgoing.collectibles
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class NftCollectiblesClaimRewardItemMessageComposer implements IMessageComposer
   {
      private var _messageArray:Array = [];
      
      public function NftCollectiblesClaimRewardItemMessageComposer(param1:String, param2:String)
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
         _messageArray = [];
      }
   }
}

