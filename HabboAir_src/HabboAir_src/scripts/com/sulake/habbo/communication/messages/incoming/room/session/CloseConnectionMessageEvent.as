package com.sulake.habbo.communication.messages.incoming.room.session
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.session.UnknownHabboCommunicationMessagesParserRoomSession1;
   
   [SecureSWF(rename="true")]
   public class CloseConnectionMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function CloseConnectionMessageEvent(param1:Function)
      {
         super(param1,UnknownHabboCommunicationMessagesParserRoomSession1);
      }
      
      public function getParser() : UnknownHabboCommunicationMessagesParserRoomSession1
      {
         return _parser as UnknownHabboCommunicationMessagesParserRoomSession1;
      }
   }
}

