package com.sulake.habbo.communication.messages.parser.recycler
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class RecyclerFinishedMessageEvent extends MessageEvent implements IMessageEvent
   {
      public static const UnknownConstFromRecyclerFinishedMessageEvent_Int_1:int = 1;
      
      public static const UnknownConstFromRecyclerFinishedMessageEvent_Int_2:int = 2;
      
      public function RecyclerFinishedMessageEvent(param1:Function)
      {
         super(param1,RecyclerFinishedMessageParser);
      }
      
      public function getParser() : RecyclerFinishedMessageParser
      {
         return _parser as RecyclerFinishedMessageParser;
      }
   }
}

