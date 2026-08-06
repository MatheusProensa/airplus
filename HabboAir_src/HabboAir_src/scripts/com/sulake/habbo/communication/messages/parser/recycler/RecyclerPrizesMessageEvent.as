package com.sulake.habbo.communication.messages.parser.recycler
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class RecyclerPrizesMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function RecyclerPrizesMessageEvent(param1:Function)
      {
         super(param1,RecyclerPrizesMessageParser);
      }
      
      public function getParser() : RecyclerPrizesMessageParser
      {
         return _parser as RecyclerPrizesMessageParser;
      }
   }
}

