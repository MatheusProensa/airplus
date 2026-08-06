package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class CollectibleItem extends CollectibleBaseItem
   {
      private var _amount:int;
      
      public function CollectibleItem(param1:IMessageDataWrapper)
      {
         super(param1);
      }
      
      override public function readAdditionalParams(param1:IMessageDataWrapper) : void
      {
         _amount = param1.readInteger();
      }
      
      public function get amount() : int
      {
         return _amount;
      }
   }
}

