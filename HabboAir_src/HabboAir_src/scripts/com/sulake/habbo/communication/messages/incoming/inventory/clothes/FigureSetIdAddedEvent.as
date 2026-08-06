package com.sulake.habbo.communication.messages.incoming.inventory.clothes
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.clothing.FigureSetIdAddedMessageParser;
   
   [SecureSWF(rename="true")]
   public class FigureSetIdAddedEvent extends MessageEvent implements IMessageEvent
   {
      public function FigureSetIdAddedEvent(param1:Function)
      {
         super(param1,FigureSetIdAddedMessageParser);
      }
      
      public function getParser() : FigureSetIdAddedMessageParser
      {
         return _parser as FigureSetIdAddedMessageParser;
      }
   }
}

