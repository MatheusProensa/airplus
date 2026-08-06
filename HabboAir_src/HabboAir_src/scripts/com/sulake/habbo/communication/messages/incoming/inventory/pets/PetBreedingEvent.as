package com.sulake.habbo.communication.messages.incoming.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetBreedingMessageParser;
   
   [SecureSWF(rename="true")]
   public class PetBreedingEvent extends MessageEvent implements IMessageEvent
   {
      public function PetBreedingEvent(param1:Function)
      {
         super(param1,PetBreedingMessageParser);
      }
      
      public function getParser() : PetBreedingMessageParser
      {
         return _parser as PetBreedingMessageParser;
      }
   }
}

