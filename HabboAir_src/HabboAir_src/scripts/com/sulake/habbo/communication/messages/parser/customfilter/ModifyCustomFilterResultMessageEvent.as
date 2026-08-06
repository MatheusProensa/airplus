package com.sulake.habbo.communication.messages.parser.customfilter
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class ModifyCustomFilterResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      public static const UnknownConstFromModifyCustomFilterResultMessageEvent_Int_1:int = 0;
      
      public static const UnknownConstFromModifyCustomFilterResultMessageEvent_Int_2:int = 1;
      
      public static const UnknownConstFromModifyCustomFilterResultMessageEvent_Int_3:int = 3;
      
      public function ModifyCustomFilterResultMessageEvent(param1:Function)
      {
         super(param1,ModifyCustomFilterResultMessageEventParser);
      }
      
      public function getParser() : ModifyCustomFilterResultMessageEventParser
      {
         return _parser as ModifyCustomFilterResultMessageEventParser;
      }
   }
}

