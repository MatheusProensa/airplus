package com.sulake.habbo.communication.messages.parser.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PetRemovedFromInventoryParser implements IMessageParser
   {
      private var _petId:int;
      
      public function PetRemovedFromInventoryParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _petId = param1.readInteger();
         return true;
      }
      
      public function get petId() : int
      {
         return _petId;
      }
   }
}

