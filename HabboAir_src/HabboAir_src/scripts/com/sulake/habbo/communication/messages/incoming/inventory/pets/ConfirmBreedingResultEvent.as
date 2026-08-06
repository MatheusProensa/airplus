package com.sulake.habbo.communication.messages.incoming.inventory.pets
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.pets.ConfirmBreedingResultParser;
   
   [SecureSWF(rename="true")]
   public class ConfirmBreedingResultEvent extends MessageEvent implements IMessageEvent
   {
      public function ConfirmBreedingResultEvent(param1:Function)
      {
         super(param1,ConfirmBreedingResultParser);
      }
      
      public function getParser() : ConfirmBreedingResultParser
      {
         return _parser as ConfirmBreedingResultParser;
      }
   }
}

