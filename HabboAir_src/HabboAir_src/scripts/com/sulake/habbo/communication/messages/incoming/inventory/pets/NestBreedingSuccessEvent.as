package com.sulake.habbo.communication.messages.incoming.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.NestBreedingSuccessParser;
   
   [SecureSWF(rename="true")]
   public class NestBreedingSuccessEvent extends MessageEvent implements IMessageEvent
   {
      public function NestBreedingSuccessEvent(param1:Function)
      {
         super(param1,NestBreedingSuccessParser);
      }
      
      public function getParser() : NestBreedingSuccessParser
      {
         return _parser as NestBreedingSuccessParser;
      }
   }
}

