package com.sulake.habbo.communication.messages.incoming.groupforums
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.groupforums.ForumThreadsMessageParser;
   
   [SecureSWF(rename="true")]
   public class ForumThreadsMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function ForumThreadsMessageEvent(param1:Function)
      {
         super(param1,ForumThreadsMessageParser);
      }
      
      public function getParser() : ForumThreadsMessageParser
      {
         return this._parser as ForumThreadsMessageParser;
      }
   }
}

