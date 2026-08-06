package com.sulake.habbo.communication.messages.incoming.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.ConfirmBreedingRequestParser;
   
   [SecureSWF(rename="true")]
   public class ConfirmBreedingRequestEvent extends MessageEvent implements IMessageEvent
   {
      public function ConfirmBreedingRequestEvent(param1:Function)
      {
         super(param1,ConfirmBreedingRequestParser);
      }
      
      public function getParser() : ConfirmBreedingRequestParser
      {
         return _parser as ConfirmBreedingRequestParser;
      }
   }
}

