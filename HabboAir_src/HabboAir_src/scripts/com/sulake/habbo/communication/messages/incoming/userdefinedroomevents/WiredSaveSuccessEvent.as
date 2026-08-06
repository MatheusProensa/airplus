package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.UnknownHabboCommunicationMessagesParserUserdefinedroomevents1;
   
   [SecureSWF(rename="true")]
   public class WiredSaveSuccessEvent extends MessageEvent implements IMessageEvent
   {
      public function WiredSaveSuccessEvent(param1:Function)
      {
         super(param1,UnknownHabboCommunicationMessagesParserUserdefinedroomevents1);
      }
      
      public function getParser() : UnknownHabboCommunicationMessagesParserUserdefinedroomevents1
      {
         return this._parser as UnknownHabboCommunicationMessagesParserUserdefinedroomevents1;
      }
   }
}

