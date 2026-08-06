package com.sulake.habbo.communication.messages.parser.inventory.bots
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BotAddedToInventoryParser implements IMessageParser
   {
      private var _item:BotData;
      
      private var _openInventory:Boolean;
      
      public function BotAddedToInventoryParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _item = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _item = new BotData(param1);
         _openInventory = param1.readBoolean();
         return true;
      }
      
      public function get item() : BotData
      {
         return _item;
      }
      
      public function openInventory() : Boolean
      {
         return _openInventory;
      }
   }
}

