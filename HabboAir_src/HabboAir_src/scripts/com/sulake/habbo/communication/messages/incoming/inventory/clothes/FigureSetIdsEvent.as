package com.sulake.habbo.communication.messages.incoming.inventory.clothes
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.clothing.FigureSetIdsMessageParser;
   
   [SecureSWF(rename="true")]
   public class FigureSetIdsEvent extends MessageEvent implements IMessageEvent
   {
      public function FigureSetIdsEvent(param1:Function)
      {
         super(param1,FigureSetIdsMessageParser);
      }
      
      public function getParser() : FigureSetIdsMessageParser
      {
         return _parser as FigureSetIdsMessageParser;
      }
   }
}

