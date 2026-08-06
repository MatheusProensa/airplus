package com.sulake.habbo.communication.messages.parser.inventory.bots
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BotRemovedFromInventoryParser implements IMessageParser
   {
      private var _itemId:int;
      
      public function BotRemovedFromInventoryParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _itemId = param1.readInteger();
         return true;
      }
      
      public function get itemId() : int
      {
         return _itemId;
      }
   }
}

