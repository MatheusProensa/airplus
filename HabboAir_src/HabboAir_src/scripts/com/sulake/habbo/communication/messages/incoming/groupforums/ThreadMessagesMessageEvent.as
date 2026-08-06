package com.sulake.habbo.communication.messages.incoming.groupforums
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.groupforums.ThreadMessagesMessageParser;
   
   [SecureSWF(rename="true")]
   public class ThreadMessagesMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function ThreadMessagesMessageEvent(param1:Function)
      {
         super(param1,ThreadMessagesMessageParser);
      }
      
      public function getParser() : ThreadMessagesMessageParser
      {
         return this._parser as ThreadMessagesMessageParser;
      }
   }
}

