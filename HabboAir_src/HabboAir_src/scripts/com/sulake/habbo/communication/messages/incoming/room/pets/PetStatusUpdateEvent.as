package com.sulake.habbo.communication.messages.incoming.room.pets
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.pets.PetStatusUpdateMessageParser;
   
   [SecureSWF(rename="true")]
   public class PetStatusUpdateEvent extends MessageEvent implements IMessageEvent
   {
      public function PetStatusUpdateEvent(param1:Function)
      {
         super(param1,PetStatusUpdateMessageParser);
      }
      
      public function getParser() : PetStatusUpdateMessageParser
      {
         return _parser as PetStatusUpdateMessageParser;
      }
   }
}

