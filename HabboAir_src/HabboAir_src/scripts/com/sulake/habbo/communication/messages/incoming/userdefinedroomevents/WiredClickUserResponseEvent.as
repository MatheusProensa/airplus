package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.WiredClickUserResponseMessageParser;
   
   [SecureSWF(rename="true")]
   public class WiredClickUserResponseEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredClickUserResponseEvent(param1:Function)
      {
         super(param1,WiredClickUserResponseMessageParser);
      }
      
      public function getParser() : WiredClickUserResponseMessageParser
      {
         return this._parser as WiredClickUserResponseMessageParser;
      }
   }
}

