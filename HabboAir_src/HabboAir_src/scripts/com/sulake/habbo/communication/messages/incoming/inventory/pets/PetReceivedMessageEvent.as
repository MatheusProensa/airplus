package com.sulake.habbo.communication.messages.incoming.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.PetReceivedMessageParser;
   
   [SecureSWF(rename="true")]
   public class PetReceivedMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function PetReceivedMessageEvent(param1:Function)
      {
         super(param1,PetReceivedMessageParser);
      }
      
      public function getParser() : PetReceivedMessageParser
      {
         return _parser as PetReceivedMessageParser;
      }
   }
}

