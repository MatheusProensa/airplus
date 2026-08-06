package com.sulake.habbo.communication.messages.incoming.callforhelp
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   
   [SecureSWF(rename="true")]
   public class MyCfhReportStatusMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function MyCfhReportStatusMessageEvent(param1:Function)
      {
         super(param1,MyCfhReportStatusMessageParser);
      }
      
      public function getParser() : MyCfhReportStatusMessageParser
      {
         return _parser as MyCfhReportStatusMessageParser;
      }
   }
}

