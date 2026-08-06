package com.sulake.habbo.communication.messages.incoming.mysterybox
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.mysterybox.UnknownHabboCommunicationMessagesParserMysterybox1;
   
   [SecureSWF(rename="true")]
   public class CancelMysteryBoxWaitMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function CancelMysteryBoxWaitMessageEvent(param1:Function)
      {
         super(param1,UnknownHabboCommunicationMessagesParserMysterybox1);
      }
      
      public function getParser() : UnknownHabboCommunicationMessagesParserMysterybox1
      {
         return _parser as UnknownHabboCommunicationMessagesParserMysterybox1;
      }
   }
}

