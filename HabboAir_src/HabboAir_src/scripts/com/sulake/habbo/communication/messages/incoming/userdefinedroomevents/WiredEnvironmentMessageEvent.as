package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredEnvironmentMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredEnvironmentMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredEnvironmentMessageEvent(param1:Function)
      {
         super(param1,WiredEnvironmentMessageParser);
      }
      
      public function getParser() : WiredEnvironmentMessageParser
      {
         return this._parser as WiredEnvironmentMessageParser;
      }
   }
}

