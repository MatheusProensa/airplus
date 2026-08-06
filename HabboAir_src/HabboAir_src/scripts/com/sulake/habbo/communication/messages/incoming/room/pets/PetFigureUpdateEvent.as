package com.sulake.habbo.communication.messages.incoming.room.pets
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.pets.PetFigureUpdateMessageParser;
   
   [SecureSWF(rename="true")]
   public class PetFigureUpdateEvent extends MessageEvent implements IMessageEvent
   {
      public function PetFigureUpdateEvent(param1:Function)
      {
         super(param1,PetFigureUpdateMessageParser);
      }
      
      public function getParser() : PetFigureUpdateMessageParser
      {
         return _parser as PetFigureUpdateMessageParser;
      }
   }
}

