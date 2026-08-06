package com.sulake.habbo.communication.messages.parser.recycler
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class RecyclerStatusMessageEvent extends MessageEvent implements IMessageEvent
   {
      public static const UnknownConstFromRecyclerStatusMessageEvent_Int_1:int = 1;
      
      public static const UnknownConstFromRecyclerStatusMessageEvent_Int_2:int = 2;
      
      public static const UnknownConstFromRecyclerStatusMessageEvent_Int_3:int = 3;
      
      public function RecyclerStatusMessageEvent(param1:Function)
      {
         super(param1,RecyclerStatusMessageParser);
      }
      
      public function getParser() : RecyclerStatusMessageParser
      {
         return _parser as RecyclerStatusMessageParser;
      }
   }
}

