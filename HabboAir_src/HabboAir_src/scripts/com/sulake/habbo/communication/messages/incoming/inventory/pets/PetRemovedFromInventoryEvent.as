package com.sulake.habbo.communication.messages.incoming.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetRemovedFromInventoryParser;
   
   [SecureSWF(rename="true")]
   public class PetRemovedFromInventoryEvent extends MessageEvent implements IMessageEvent
   {
      public function PetRemovedFromInventoryEvent(param1:Function)
      {
         super(param1,PetRemovedFromInventoryParser);
      }
      
      public function getParser() : PetRemovedFromInventoryParser
      {
         return _parser as PetRemovedFromInventoryParser;
      }
   }
}

