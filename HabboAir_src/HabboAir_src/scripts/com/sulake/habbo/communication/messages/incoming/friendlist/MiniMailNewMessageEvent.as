package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.friendlist.MiniMailNewMessageMessageParser;
   
   [SecureSWF(rename="true")]
   public class MiniMailNewMessageEvent extends MessageEvent implements IMessageEvent
   {
      public function MiniMailNewMessageEvent(param1:Function)
      {
         super(param1,MiniMailNewMessageMessageParser);
      }
      
      public function getParser() : MiniMailNewMessageMessageParser
      {
         return _parser as MiniMailNewMessageMessageParser;
      }
   }
}

