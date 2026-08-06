package com.sulake.habbo.communication.messages.parser.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PetAddedToInventoryParser implements IMessageParser
   {
      private var _pet:PetData;
      
      private var _openInventory:Boolean;
      
      public function PetAddedToInventoryParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _pet = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _pet = new PetData(param1);
         _openInventory = param1.readBoolean();
         return true;
      }
      
      public function get pet() : PetData
      {
         return _pet;
      }
      
      public function openInventory() : Boolean
      {
         return _openInventory;
      }
   }
}

