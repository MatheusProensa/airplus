package com.sulake.habbo.communication.messages.incoming.inventory.clothes
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.clothing.FigureSetIdRemovedMessageParser;
   
   [SecureSWF(rename="true")]
   public class FigureSetIdRemovedEvent extends MessageEvent implements IMessageEvent
   {
      public function FigureSetIdRemovedEvent(param1:Function)
      {
         super(param1,FigureSetIdRemovedMessageParser);
      }
      
      public function getParser() : FigureSetIdRemovedMessageParser
      {
         return _parser as FigureSetIdRemovedMessageParser;
      }
   }
}

