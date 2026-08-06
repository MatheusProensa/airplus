package com.sulake.habbo.communication.messages.incoming.nux
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.nux.UnknownHabboCommunicationMessagesParserNux1;
   
   [SecureSWF(rename="true")]
   public class NewUserExperienceNotCompleteEvent extends MessageEvent implements IMessageEvent
   {
      public function NewUserExperienceNotCompleteEvent(param1:Function)
      {
         super(param1,UnknownHabboCommunicationMessagesParserNux1);
      }
      
      public function getParser() : UnknownHabboCommunicationMessagesParserNux1
      {
         return _parser as UnknownHabboCommunicationMessagesParserNux1;
      }
   }
}

