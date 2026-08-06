package com.sulake.habbo.communication.messages.incoming.groupforums
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.groupforums.PostMessageMessageParser;
   
   [SecureSWF(rename="true")]
   public class PostMessageMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function PostMessageMessageEvent(param1:Function)
      {
         super(param1,PostMessageMessageParser);
      }
      
      public function getParser() : PostMessageMessageParser
      {
         return this._parser as PostMessageMessageParser;
      }
   }
}

